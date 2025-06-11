{
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland"; # Command to execute Hyprland
        user = "daniel"; # Replace with your actual username
      };
    };
  };
}
