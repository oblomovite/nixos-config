{ config, lib, pkgs, ... }:

{
    boot = {
        kernelPackages = pkgs.linuxPackages;
        kernelParams = [

                    "i915.enable_fbc=1"
                    "i915.enable_fbc=2"
        ];
    };
}
