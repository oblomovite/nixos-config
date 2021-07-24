{ config, lib, pkgs, ... }:

{

	users.extraUsers = {

		robeh = {

			createHome = true;
			
			extraGroups = [
				"wheel" 
				"video" 
				"audio" 
				"disk" 
				"networkmanager"
				"transmission"	
				"i3"
			];

			group = "users";
			home = "/home/robeh";
			isNormalUser = true;
			uid = 1000;
			
			subUidRanges = [
				{ startUid = 100000; count = 665536; }
			];
			subGidRanges = [
				{ startGid = 100000; count = 665536; }
			];
			
		};	
	
		# Backup automation
		backup = {

			description = "Backup user";
			uid = 600;
			group = "backup";
			home = "/var/lib/backup";
			createHome = true;
			useDefaultShell = true;
			
		};
			

	};

	users.extraGroups = {
		
		plugdev = { gid = 500; };
		tracing = { gid = 501; };
		usbtmc = { gid = 502; };
		wireshark = { gid = 503; };
		usbmon = { gid = 504; }; 
		backup = { gid = 600; };
	};
}
