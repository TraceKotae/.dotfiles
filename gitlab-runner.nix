{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
	gitlab-runner
  ];
 services.gitlab-runner = {
 enable = true;
 settings {
  concurrent = 1;
  check_interval = 59;
   };
  };
 };
}
