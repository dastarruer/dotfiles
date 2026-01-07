{pkgs, ...}: {
  # Enable the smart-pause-resume script, which plays and pauses multiple media players (https://github.com/erenseymen/smart-pause-resume/blob/master/smart-pause-resume.service)
  systemd.user.services.smart-pause-resume = {
    Unit = {
      Description = "Auto-pause previous media when new media starts";
    };

    Service = {
      ExecStart = let
        name = "smart-pause-resume";
      in "${pkgs.writeShellApplication {
        name = "${name}";

        runtimeInputs = with pkgs; [
          coreutils
          playerctl
        ];

        # Slightly modified version of https://github.com/erenseymen/smart-pause-resume/blob/master/smart-pause-resume
        text = ''
          shopt -s extglob
          set -euo pipefail

          # ────────────────  internal state  ────────────────────── #
          declare -A STATUS=()          # busName → last known status
          declare -A AUTO_PAUSED=()     # busName → 1  (flag when *we* paused it)
          declare -a QUEUE=()           # LIFO stack (index 0 = top)

          # ────────────────  stack helpers  ─────────────────────── #
          push_stack() {                # push_stack <busName>
            local p=$1
            for i in "''\${!QUEUE[@]}"; do [[ ''\${QUEUE[i]} == "$p" ]] && unset 'QUEUE[i]'; done
            QUEUE=("$p" "''\${QUEUE[@]}")
          }

          pop_stack() {                 # echo next valid player or return 1
            while ((''\${#QUEUE[@]})); do
              local p=''\${QUEUE[0]}; QUEUE=("''\${QUEUE[@]:1}")
              [[ -n ''\${STATUS[$p]+x} ]] && { echo "$p"; return 0; }
            done
            return 1
          }

          remove_from_stack() {         # remove_from_stack <busName>
            local tgt=$1
            for i in "''\${!QUEUE[@]}"; do [[ ''\${QUEUE[i]} == "$tgt" ]] && unset 'QUEUE[i]'; done
            QUEUE=("''\${QUEUE[@]}")
          }

          # ────────────────  utils  ─────────────────────────────── #
          any_playing() {               # true (0) if some player currently Playing
            for p in "''\${!STATUS[@]}"; do [[ ''\${STATUS[$p]} == "Playing" ]] && return 0; done
            return 1
          }

          pause_player() {   # pause_player <busName>  — helper with state update
            local p=$1
            AUTO_PAUSED[$p]=1
            playerctl --player="$p" pause &>/dev/null || true
            STATUS[$p]="Paused"
            push_stack "$p"
          }

          pause_others() {              # pause_others <currentBusName>
            local cur=$1
            for p in "''\${!STATUS[@]}"; do
              [[ $p == "$cur" ]] && continue
              if [[ ''\${STATUS[$p]} == "Playing" ]]; then
                pause_player "$p"
              fi
            done
          }

          # Comment this out so a player does not unpause immediately after pausing another player (e.g. spotify plays right after unpausing a yt video) because this is how it works on apple devices. id like to keep my attention span please and thank you
          resume_next() {               # attempt to resume next valid player in stack
          #   local n
          #   while n=$(pop_stack); do
          #     # try to resume, suppress stderr to avoid noise
          #     if playerctl --player="$n" play &>/dev/null; then
          #       STATUS[$n]="Playing"
          #       unset 'AUTO_PAUSED[$n]' || true
          #       return 0
          #     else
          #       # player vanished; drop its state and continue
          #       unset 'STATUS[$n]'
          #       unset 'AUTO_PAUSED[$n]' || true
          #     fi
          #   done
              # ':' indicates that this function does nothing
              :
          }

          # ───────────────── event dispatcher ────────────────────── #
          on_event() {                  # on_event <busName> <status>
            local player=$1 status=$2

            STATUS[$player]="$status"               # update table

            case $status in
              Playing)
                unset 'AUTO_PAUSED[$player]' || true
                remove_from_stack "$player"
                pause_others "$player"
                ;;

              Paused|Stopped)
                if [[ -n ''\${AUTO_PAUSED[$player]+x} ]]; then
                  unset 'AUTO_PAUSED[$player]'         # we did it – ignore
                  return
                fi
                remove_from_stack "$player"            # user action → never resume it
                any_playing || resume_next
                ;;
            esac
          }

          # ───────────────── startup scan  ─────────────────────── #
          startup_scan() {
            local designated_player=""

            # Get a list of all player instances. Use `|| true` to prevent exit on error.
            local player_list
            player_list=$(playerctl --list-all 2>/dev/null || true)

            # If there are no players, there's nothing to do.
            if [[ -z "$player_list" ]]; then
              return
            fi

            # Iterate through each discovered player instance
            while read -r p; do
              # Skip empty lines that might result from the command
              [[ -z "$p" ]] && continue

              # Get the status for this specific player.
              # If player quits between list and status commands, default to "Stopped".
              local s
              s=$(playerctl --player="$p" status 2>/dev/null || echo "Stopped")

              # Record the initial, true status of every player
              STATUS["$p"]="$s"

              if [[ "$s" == "Playing" ]]; then
                if [[ -z "$designated_player" ]]; then
                  # This is the first "Playing" player found. It becomes the one we keep.
                  designated_player="$p"
                else
                  # A player is already designated, so this one must be paused.
                  pause_player "$p"
                fi
              fi
            done <<< "$player_list" # Feed the list of players into the loop
          }

          trap 'echo "smart-pause-resume: terminated." >&2; exit' INT TERM

          startup_scan
          sleep 0.5 # Give some time for the initial scan to settle

          # ───────────────────── main loop ───────────────────────── #
          playerctl --all-players --follow status --format '{{playerInstance}} {{status}}' |
          while read -r PLAYER STATUS_LINE; do
            [[ -z $PLAYER ]] && continue
            on_event "$PLAYER" "$STATUS_LINE"
          done
        '';
      }}/bin/${name}";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  # Add pause-all script to nixpkgs
  nixpkgs.overlays = [
    (final: prev: {
      pause-all = prev.writeShellApplication {
        name = "pause-all";

        runtimeInputs = with prev; [
          systemdMinimal
          playerctl
        ];

        text = ''
          if systemctl --user --quiet is-active smart-pause-resume.service; then
            systemctl --user stop smart-pause-resume.service

            # || true makes sure the script does not return a non-zero exit code
            playerctl --all-players pause || true

            systemctl --user start smart-pause-resume.service
          else
            playerctl --all-players pause || true
          fi
        '';
      };
    })
  ];
}
