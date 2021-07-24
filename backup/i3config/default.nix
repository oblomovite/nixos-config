{ mutate,
  sakura,
  xorg,
  i3status,
  pulseaudioFull,
  # volume,
  # backlight,
  # dunst,
  # dunst_config,
  lib,
  # screenshot,
  # secrets
  rofi,
  alacritty
}:

mutate ./config {
  inherit
    sakura
    i3status
    pulseaudioFull
    #  volume
    #backlight
    # dunst
    # dunst_config
    #  screenshot
    i3lock-pixeled
    termite
    rofi
    alacritty
  ;

  i3status_conf = mutate ./i3status { };

}
