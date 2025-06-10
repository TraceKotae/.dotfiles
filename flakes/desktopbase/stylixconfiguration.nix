{ pkgs, ... }:
{
stylix.image = ~/.dotfiles/flakes/Assets/Wallpapers/SakuratreeLarge.png;
stylix.cursor.package = pkgs.bibata-cursors;
stylix.cursor.name = "Bibata-Modern-Ice";
stylix.fonts = {
	monospace = {
		package = pkgs.nerfonts.override {fonts = ["JetBraintsMono];};
		name = "JetBrainsMono Nerd Font Mono";
		};
	sansSerif = {
		package = pkgs.dejavu_fonts;
		name = "DejaVu Sans";
		}
	serif = {
		package = pkgs.dejavu_fonts;
		name = "DejaVu Serif";
	};
};
}