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
  virtualisation.oci-containers.containers."flame" = {
    image = "pawelmalak/flame:latest";
    environment = {
      "PASSWORD" = "verysecurepassword";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/flame/data:/app/data:rw"
      "/var/run/docker.sock:/var/run/docker.sock:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=flame"
      "--network=homelab"
    ];
  };
  systemd.services."docker-flame" = {
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
  virtualisation.oci-containers.containers."hugodocs" = {
    image = "ghcr.io/gohugoio/hugo:v0.148.1";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/hugodocs/hugodocs:/project:rw"
    ];
    ports = [
      "1313:1313/tcp"
    ];
    cmd = [ "server" "--buildDrafts" "--bind" "0.0.0.0" ];
    user = "1000:100";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=hugodocs"
      "--network=homelab"
    ];
  };
  systemd.services."docker-hugodocs" = {
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
  virtualisation.oci-containers.containers."immich_machine_learning" = {
    image = "ghcr.io/immich-app/immich-machine-learning:release";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "homelab_model-cache:/cache:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=immich-machine-learning"
      "--network=homelab"
    ];
  };
  systemd.services."docker-immich_machine_learning" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-homelab.service"
      "docker-volume-homelab_model-cache.service"
    ];
    requires = [
      "docker-network-homelab.service"
      "docker-volume-homelab_model-cache.service"
    ];
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."immich_server" = {
    image = "ghcr.io/immich-app/immich-server:release";
    environment = {
      "DB_DATABASE_NAME" = "immich";
      "DB_HOSTNAME" = "postgres";
      "DB_PASSWORD" = "postgres";
      "DB_USERNAME" = "postgres";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/home/nebuleab/Homelab/homelab/immich/library:/usr/src/app/upload:rw"
    ];
    ports = [
      "2283:2283/tcp"
    ];
    dependsOn = [
      "postgres"
      "redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=immich-server"
      "--network=homelab"
    ];
  };
  systemd.services."docker-immich_server" = {
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
  virtualisation.oci-containers.containers."it-tools" = {
    image = "corentinth/it-tools:latest";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=it-tools"
      "--network=homelab"
    ];
  };
  systemd.services."docker-it-tools" = {
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
  virtualisation.oci-containers.containers."metube" = {
    image = "ghcr.io/alexta69/metube";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/metube/downloads:/downloads:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=metube"
      "--network=homelab"
    ];
  };
  systemd.services."docker-metube" = {
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
  virtualisation.oci-containers.containers."postgres" = {
    image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0";
    environment = {
      "DB_DATABASE_NAME" = "immich";
      "POSTGRES_INITDB_ARGS" = "--data-checksums";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/immich/postgres:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=postgres"
      "--network=homelab"
    ];
  };
  systemd.services."docker-postgres" = {
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
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "qbittorrentofficial/qbittorrent-nox:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "QBT_EULA" = "accept";
      "QBT_VERSION" = "latest";
      "QBT_WEBUI_PORT" = "8083";
      "TZ" = "{TIMEZONE}";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    dependsOn = [
      "wireguard-client"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=container:wireguard-client"
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
  virtualisation.oci-containers.containers."redis" = {
    image = "docker.io/valkey/valkey:8-bookworm@sha256:fec42f399876eb6faf9e008570597741c87ff7662a54185593e74b09ce83d177";
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=redis-cli ping || exit 1"
      "--network-alias=redis"
      "--network=homelab"
    ];
  };
  systemd.services."docker-redis" = {
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
  virtualisation.oci-containers.containers."wireguard-client" = {
    image = "linuxserver/wireguard";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "{TIMEZONE}";
    };
    environmentFiles = [
      "/home/nebuleab/Homelab/homelab/.env"
    ];
    volumes = [
      "/home/nebuleab/Homelab/homelab/wireguard-client/wg-config:/config:rw"
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
      "--network-alias=wireguard-client"
      "--network=homelab"
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
    ];
  };
  systemd.services."docker-wireguard-client" = {
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

  # Volumes
  systemd.services."docker-volume-homelab_model-cache" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect homelab_model-cache || docker volume create homelab_model-cache
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
