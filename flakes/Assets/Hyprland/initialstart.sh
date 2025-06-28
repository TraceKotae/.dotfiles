swww-daemon &
swww img ~/.dotfiles/flakes/desktopbase/Wallpapers/SakuratreeLarge.png &
sleep 2 &&
qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.open kdewallet 0 "Hyprland" &
kwallet-query -l kdewallet &
sleep 10 &&
nextcloud &
