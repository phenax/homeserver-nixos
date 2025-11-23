{ settings, pkgs, ... }:
{
  imports = [
    ../../services/lazylibrarian/default.nix
  ];

  systemd.tmpfiles.rules = [
    "d ${settings.media.booksDir} 0770 - ${settings.media.group} - -"
  ];

  services.lazylibrarian = {
    enable = true;
  };

  # virtualisation.oci-containers.containers.lazy-librarian = {
  #   image = "linuxserver/lazylibrarian";
  #   # user = "lazylibrarian:${settings.media.group}";
  #   imageFile = pkgs.dockerTools.pullImage {
  #     imageName = "linuxserver/lazylibrarian";
  #     finalImageTag = "version-68d7f93c";
  #     imageDigest = "sha256:5d0c935283e5393ff57fb52e88660ccc596c170cc6f68c58045cd2c792108fdd";
  #     sha256 = "sha256-jpdOJhf02Nbw/yRjEzTw+unZb7Ou+Lh9kPB/0oqHYV4=";
  #   };
  #   extraOptions = ["--network=host"];
  #   ports = ["${toString settings.network.ports.lazylibrarian}:5299"];
  #   volumes = [
  #     "${settings.media.booksDir}:/books"
  #     "${settings.media.downloadsDir}:/downloads"
  #     "/var/lib/lazylibrarian:/config"
  #   ];
  # };
}
