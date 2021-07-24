
{ config, pkgs, ... }:

{
  i18n = {
    #    consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
    consoleFont = "ter-i32b";
    consolePackages = with pkgs; [ terminus_font ];
  };
}
