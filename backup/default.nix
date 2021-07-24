{ mutate,
  alacritty,
  # xorg,
  # i3status,
  # dmenu,
  pulseaudioFull,
  # volume,
  # backlight,
  mako,
  lib,
  # screenshot,
  sway-cycle-workspace,
  wl-clipboard

# ,
  # secrets
}:
mutate ./config {
  inherit
    alacritty
    # i3status
    waybar
    wl-clipboard
    # dmenu
    rofi
    pulseaudioFull
    # volume
    # backlight
    mako
    # screenshot
  ;

  sway_cycle_workspace = sway-cycle-workspace;
  waybar_conf = mutate ./waybar/config { };
  # i3status_conf = mutate ./i3status {
  # #   remote_tzs = lib.lists.imap0 (i: tz: ''
  # #       tztime remote${toString i} {
  # #         format = "-%d %H:%M:%S %Z"
  # #         timezone = "${tz}"
  # #       }
  # #       order += "tztime remote${toString i}"
  # #     '') secrets.location.remote_timezones;
  # };
  # bgimage = ../../nixos-nineish.png;

};
