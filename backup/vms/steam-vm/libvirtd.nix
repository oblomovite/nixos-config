{
  steam-libvirtd= {
    deployment = {
      targetEnv = "libvirtd";
      libvirtd.headless = true;
      libvirtd.extraDevicesXML = ''
        <graphics type='vnc' port='-1' autoport='yes'/>
      '';
    };
  };
}
