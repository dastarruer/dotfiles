{pkgs, ...}: {
  home.packages = [pkgs.rclone];

  # Declare the rclone config file
  xdg.configFile."rclone/rclone.conf".text = ''
    [gdrive]
    type = drive
    scope = drive
    token = {"access_token":"ya29.A0AS3H6NzFdw4xnW1y6KB9R5NAfILyaZGmTXcmA-igOBvbwkQysTOsFLE1_CPpGgE_oaNcELU_xrW34r9Wkk69KVJMXMkrrqlya2Js2wilAYFWFLB7gvPZolNJ1kRrA6zy_sUAlrfZw1ra503ArQsblBHg9QJaGnnWmEwmnicIY6cYi8fzXhWA0MppUcGG9fj2rENR088aCgYKAYwSARMSFQHGX2MiXRpfh49-HccfzJnu6yvB9A0206","token_type":"Bearer","refresh_token":"1//05S41v2dWHqxQCgYIARAAGAUSNwF-L9IrfuXF78VlEY7iOIewqj2gQVhCUP_LzGTxNO3y7r3_8Vu-cf5ep6HGmuG0X8DGnRWPySo","expiry":"2025-07-31T23:50:52.319140182-04:00","expires_in":3599}
    team_drive =
  '';
}
