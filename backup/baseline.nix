# We'll also declare a common baseline that we'd like to share with all VMs as well. 
# This mostly boils down to making sure that we always have SSH access to the machines.

# Then tell NixOps about the new network, and make sure that it deploys correctly:
# 
# $ NIXOPS_DEPLOYMENT=vm-test-hosts nixops create network-hosts.nix
# $ NIXOPS_DEPLOYMENT=vm-test-hosts nixops deploy

{
  # Make sure that we still have admin access to the machine
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  users = {
    mutableUsers = false;
    users.root.openssh.authorizedKeys.keyFiles = [ ./teozkr_id_rsa.pub ];
  };
}
