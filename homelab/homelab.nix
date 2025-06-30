# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."caddy" = {
    image = "ghcr.io/authcrunch/authcrunch:latest";
    environment = {
      "JWT" = "\"<Some 32 char random string>\"";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/caddy/caddy/config:/config:rw"
      "/home/nebuleab/Homelab/homelab/caddy/caddy/data:/data:rw"
      "/home/nebuleab/Homelab/homelab/caddy/conf:/etc/caddy:rw"
      "/home/nebuleab/Homelab/homelab/chibisafe/uploads:/app/uploads:ro"
    ];
    ports = [
      "80:80/tcp"
      "443:443/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=caddy"
      "--network=homelab"
    ];
  };
  systemd.services."docker-caddy" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."chibisafe" = {
    image = "chibisafe/chibisafe:latest";
    environment = {
      "BASE_API_URL" = "http://chibisafe_server:8000";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    ports = [
      "8000:8000/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=chibisafe"
      "--network=homelab"
    ];
  };
  systemd.services."docker-chibisafe" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."chibisafe-server" = {
    image = "chibisafe/chibisafe-server:latest";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/chibisafe/database:/app/database:rw"
      "/home/nebuleab/Homelab/homelab/chibisafe/logs:/app/logs:rw"
      "/home/nebuleab/Homelab/homelab/chibisafe/uploads:/app/uploads:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=chibisafe_server"
      "--network=homelab"
    ];
  };
  systemd.services."docker-chibisafe-server" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dozzle" = {
    image = "amir20/dozzle:latest";
    environment = {
      "DOZZLE_ENABLE_ACTIONS" = "true";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/dozzle:/data:rw"
      "/var/run/docker.sock:/var/run/docker.sock:rw"
    ];
    ports = [
      "8080:8080/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dozzle"
      "--network=homelab"
    ];
  };
  systemd.services."docker-dozzle" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "qbittorrentofficial/qbittorrent-nox:latest";
    environment = {
      "PGID" = "0";
      "PUID" = "0";
      "QBT_EULA" = "accept";
      "QBT_VERSION" = "latest";
      "QBT_WEBUI_PORT" = "8081";
      "TZ" = "{TIMEZONE}";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    dependsOn = [
      "wireguard"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=container:wireguard"
    ];
  };
  systemd.services."docker-qbittorrent" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."stirlingpdf" = {
    image = "docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest";
    environment = {
      "DOCKER_ENABLE_SECURITY" = "false";
      "LANGS" = "en_GB";
      "SERVER_HOST" = "\"0.0.0.0\"";
      "SERVER_PORT" = "8082";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/stirlingpdf/customFiles:/customFiles:rw"
      "/home/nebuleab/Homelab/homelab/stirlingpdf/extraConfigs:/configs:rw"
      "/home/nebuleab/Homelab/homelab/stirlingpdf/logs:/logs:rw"
      "/home/nebuleab/Homelab/homelab/stirlingpdf/pipeline:/pipeline:rw"
      "/home/nebuleab/Homelab/homelab/stirlingpdf/trainingData:/usr/share/tessdata:rw"
    ];
    ports = [
      "8082:8082/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=stirling-pdf"
      "--network=homelab"
    ];
  };
  systemd.services."docker-stirlingpdf" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."website" = {
    image = "compose2nix/website";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    ports = [
      "3000:3000/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=website"
      "--network=homelab"
    ];
  };
  systemd.services."docker-website" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."wireguard" = {
    image = "linuxserver/wireguard";
    environment = {
      "ENV_PGID" = "0";
      "ENV_PUID" = "0";
      "PGID" = "0";
      "PUID" = "0";
      "QBT_CONFIG_PATH" = "./qb-config";
      "QBT_DOWNLOADS_PATH" = "/path/to/your/media/drive";
      "QBT_EULA" = "accept";
      "QBT_VERSION" = "latest";
      "QBT_WEBUI_PORT" = "8080";
      "TIMEZONE" = "Europe/Oslo";
      "TZ" = "{TIMEZONE}";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/wg-config:/config:rw"
    ];
    ports = [
      "6881:6881/tcp"
      "6881:6881/udp"
      "8081:8081/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--cap-add=SYS_MODULE"
      "--network-alias=wireguard"
      "--network=homelab"
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
    ];
  };
  systemd.services."docker-wireguard" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-homelab.service"
    ];
    requires = [
      "docker-network-homelab.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-homelab" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f homelab";
    };
    script = ''
      docker network inspect homelab || docker network create homelab --subnet=172.20.0.0/24
    '';
    partOf = [ "docker-compose-homelab-root.target" ];
    wantedBy = [ "docker-compose-homelab-root.target" ];
  };

  # Builds
  systemd.services."docker-build-website" = {
    path = [ pkgs.docker pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /home/nebuleab/Homelab/homelab/website
      docker build -t compose2nix/website .
    '';
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-homelab-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
