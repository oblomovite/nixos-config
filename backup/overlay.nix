{ }: self: super:

# let
#   upgradeOverride = package: overrides:
#   let
#     upgraded = package.overrideAttrs overrides;
#     upgradedVersion = (builtins.parseDrvName upgraded.name).version;
#     originalVersion =(builtins.parseDrvName package.name).version;

#     isDowngrade = (builtins.compareVersions upgradedVersion originalVersion) == -1;

#     warn = builtins.trace
#       "Warning: ${package.name} downgraded by overlay with ${upgraded.name}.";
#     pass = x: x;
#   in (if isDowngrade then warn else pass) upgraded;

#   upgradeReplace = package: upgraded:
#   let
#     upgradedVersion = (builtins.parseDrvName upgraded.name).version;
#     originalVersion =(builtins.parseDrvName package.name).version;

#     isDowngrade = (builtins.compareVersions upgradedVersion originalVersion) == -1;

#     warn = builtins.trace
#       "Warning: ${package.name} downgraded by overlay with ${upgraded.name}.";
#     pass = x: x;
#   in (if isDowngrade then warn else pass) upgraded;
# in
{

  # alacritty = super.alacritty.overrideAttrs (x: {
  #   postPatch = ''
  #     substituteInPlace alacritty_terminal/src/config/mouse.rs \
  #       --replace xdg-open ${self.xdg_utils}/bin/xdg-open
  #   '';
  # });

  backlight = self.callPackage ./backlight { };

  # bash-config = self.callPackage ./bash-config { };

  #custom-emacs = self.callPackage ./emacs { };

  custom-tmux = self.callPackage ./tmux { };
  custom-vim = self.callPackage ./vim { };

  # i3config = self.callPackage ./i3config {
  #   # inherit secrets;
  # };

  # freetube = self.callPackage ./freetube { };

  # freetube = import ./freetube/freetube.nix ;

#  gitconfig = self.callPackage ./gitconfig { };

#  gnupgconfig = self.callPackage ./gnupgconfig { };

  # is-nix-channel-up-to-date = self.callPackage ./is-nix-channel-up-to-date { };

  # did-graham-commit-his-repos = self.callPackage ./did-graham-commit-his-repos { };

  # motd-massive = self.callPackage ./motd { };

  mutate = self.callPackage ./mutate { };

  # nixpkgs-pre-push = self.callPackage ./nixpkgs-pre-push { };

  # passff-host = self.callPackage ./passff-host { };

   swayconfig = self.callPackage ./swayconfig {
     # inherit secrets;
   };

   sway-cycle-workspace = self.callPackage ./sway-cycle-workspace { };

  # redshift = super.redshift.overrideAttrs (old: {
  #   name = "redshift-wayland";
  #   src = self.fetchFromGitHub {
  #     owner = "minus7";
  #     repo = "redshift";
  #     rev = "420d0d534c9f03abc4d634a7d3d7629caf29b4b6";
  #     sha256 = "12dwb96i4pbny5s64k6k4f8k936xa41zvcjhv54wv0ax471ymls7";
  #   };
  # });

  # systemd-lock-handler = self.callPackage ./systemd-lock-handler { };

  # timeout_tcl = self.callPackage ./timeout { };

#  ttf-console-font = self.callPackage ./ttf-console-font { };


#  volume = self.callPackage ./volume { };

  # zsh-config = self.callPackage ./zsh-config { };

}
