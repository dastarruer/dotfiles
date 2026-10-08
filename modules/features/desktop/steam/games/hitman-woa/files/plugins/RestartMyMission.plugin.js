/*
  RestartMyMission plugin (2026-02-22)
  Version 1.0.0

  Adds a "Restart Mission" button to the pause menu during Freelancer
  (Evergreen) missions that lets players retry without ANY loss of progress,
  items, or campaign state — perfect for Silent Assassin retries.
*/

"use strict";

const { log, LogLevel }             = require("@peacockproject/core/loggingInterop");
const { contractRoutingRouter }     = require("@peacockproject/core/contracts/contractRouting");
const { getCpd }                    = require("@peacockproject/core/evergreen");
const { writeUserData }             = require("@peacockproject/core/databaseHandler");
const { menuSystemDatabase }        = require("@peacockproject/core/menus/menuSystem");
const { compare, PEACOCKVERSTRING } = require("@peacockproject/core/utils");

const TAG          = "restart-my-mission";
const EVERGREEN_ID = "f8ec92c2-4fa2-471e-ae08-545480c746ee"; // Freelancer safehouse

/**
 * Per-user snapshot: userId → { contractId, cpd }
 * Cleared when the player successfully returns to the safehouse.
 * @type {Map<string, { contractId: string, cpd: object }>}
 */
const missionSnapshot = new Map();

/** @param {import("@peacockproject/core/controller").Controller} controller */
function initPlugin(controller) {
    if (compare(PEACOCKVERSTRING, "8.0.0") === -1) {
        log(LogLevel.ERROR, `Your Peacock version (${PEACOCKVERSTRING}) is too old!`, TAG);
        log(LogLevel.ERROR, "RestartMyMission requires Peacock 8.0.0 or newer.", TAG);
        return;
    }

    // ── 1. Menu injection ────────────────────────────────────────────────────
    //
    // PeacockInternal already adds "menusystem/pages/pause/pausemenu/restart.json"
    // to the database diff for h2/h3.  We only need to override what getConfig
    // returns for that path so the restart button is always visible.
    //
    // The stock config hides the button for Freelancer:
    //   { $if: { $condition: { $or: ["$not $eq(...ContractType,evergreen)",
    //                                "$isallowedtorestart"] }, $then: … } }
    //
    // Our override unconditionally includes the restartnoconditions element,
    // which renders the standard "Restart Mission" list item and fires the
    // native "restart-level" game action when accepted.

    // getConfig uses a custom bail hook (Zl) whose tap() method only reads
    // `name` and `context` — the standard tapable `before` option is silently
    // ignored.  Taps are stored in push order, so PeacockInternal (registered
    // at boot) always runs before any plugin tap.
    //
    // We work around this by registering normally and then directly moving our
    // entry to the front of the internal _taps array so it executes first.
    menuSystemDatabase.hooks.getConfig.tap("RestartMyMission", (name, gameVersion) => {
        if (
            name        === "/pages/pause/pausemenu/restart.json" &&
            gameVersion === "h3"
        ) {
            // Unconditionally include the restart button element.
            // PeacockInternal's stock config wraps this in a $if that hides
            // the button when ContractType === "evergreen" and
            // $isallowedtorestart is false.  We skip that guard entirely.
            return {
                $include: {
                    $path: "menusystem/pages/pause/pausemenu/restartnoconditions.json",
                },
            };
        }
        // Return undefined so the bail hook continues to the next tap.
        return undefined;
    });

    // Move our tap to index 0 so it fires before PeacockInternal.
    const taps = menuSystemDatabase.hooks.getConfig._taps;
    const ourTap = taps.pop();
    taps.unshift(ourTap);

    // ── 2 & 3. CPD snapshot + restore via GetForPlay2 ───────────────────────

    const gfp2Route = contractRoutingRouter.stack.find(
        (e) => e.route?.path === "/GetForPlay2"
    );

    if (!gfp2Route) {
        log(
            LogLevel.WARN,
            "Could not find /GetForPlay2 route — CPD snapshot/restore disabled.",
            TAG
        );
        return;
    }

    const gfp2Layer = gfp2Route.route.stack[gfp2Route.route.stack.length - 1];
    const origGfp2  = gfp2Layer.handle;

    gfp2Layer.handle = async function (req, res, next) {
        const userId     = req.jwt?.unique_name;
        const contractId = req.body?.id;

        if (userId && contractId) {
            if (contractId === EVERGREEN_ID) {
                // ── Player returned to the safehouse ─────────────────────────
                // Mission was completed (or the campaign ended).  Discard the
                // snapshot – we only restore on an actual restart.
                if (missionSnapshot.has(userId)) {
                    missionSnapshot.delete(userId);
                    log(LogLevel.INFO, "Mission completed — CPD snapshot cleared.", TAG);
                }
            } else {
                // ── Player is entering (or re-entering) a sub-mission ────────
                const cpd      = getCpd(userId, EVERGREEN_ID);
                const snapshot = missionSnapshot.get(userId);

                if (snapshot && snapshot.contractId === contractId) {
                    // Same contract called again → player hit "Restart Mission"
                    // Restore the CPD to the state it was in at mission start.
                    if (cpd) {
                        // Replace every key on the live CPD object in-place so
                        // Peacock's internal references remain valid.
                        for (const key of Object.keys(cpd)) {
                            delete cpd[key];
                        }
                        Object.assign(cpd, JSON.parse(JSON.stringify(snapshot.cpd)));
                        writeUserData(userId, "h3");

                        log(
                            LogLevel.INFO,
                            `CPD restored — restarting ${contractId} with no progress loss.`,
                            TAG
                        );
                    } else {
                        log(LogLevel.WARN, "CPD object not found during restore.", TAG);
                    }
                } else {
                    // First time entering this mission — take a snapshot.
                    if (cpd) {
                        missionSnapshot.set(userId, {
                            contractId,
                            cpd: JSON.parse(JSON.stringify(cpd)),
                        });
                        log(
                            LogLevel.INFO,
                            `CPD snapshot taken for mission ${contractId}.`,
                            TAG
                        );
                    } else {
                        log(
                            LogLevel.WARN,
                            "CPD unavailable — could not snapshot for this mission.",
                            TAG
                        );
                    }
                }
            }
        }

        return origGfp2.call(this, req, res, next);
    };

    log(
        LogLevel.INFO,
        'Loaded! "Restart Mission" is now available in the Freelancer pause menu.',
        TAG
    );
}

module.exports = initPlugin;
