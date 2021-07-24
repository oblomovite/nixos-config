# Next we have to make sure our user has access to create images by executing:

# Done:
  # sudo mkdir /var/lib/libvirt/images
  # sudo chgrp libvirtd /var/lib/libvirt/images
  # sudo chmod g+w /var/lib/libvirt/images

# We're ready to create the deployment, start by creating example.nix:

{
  default = { config, pkgs, lib, ... }:
  {
    

  };
}


# Finally, let's deploy it with NixOps:

#   $ nixops create -d example-libvirtd ./example.nix ./example-libvirtd.nix
#   $ nixops deploy -d example-libvirtd

# Graphics Display and Console
# It's possible to connect a VNC viewer to the guest to see the graphics display (X11) or the framebuffer console.

# To do this, ensure the deployment.libvirtd.headless option is set to false (the default). Then use the virsh vncdisplay command to get a VNC connection string to pass to your VNC viewer.

