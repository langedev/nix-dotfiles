{ config, lib, ... }:

{
  options.forgejo = {
    enable = lib.mkEnableOption "";
    server = {
      port = lib.mkOption { default = 4848; };
      domain = lib.mkOption { type = lib.types.str; };
    };
    users = {
      admin = {
        enable = lib.mkEnableOption "creates an admin account";
        username = lib.mkOption { type = lib.types.str; };
        passwordFile = lib.mkOption {};
      };
    };
  };

  config = lib.mkIf config.forgejo.enable {
    services.forgejo = {
      enable = true;
      settings = {
        server = {
          DOMAIN = config.forgejo.server.domain; #"winry.woach.me";
          HTTP_PORT = config.forgejo.server.port;
          ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}/";
          SSH_PORT = config.sshd.port;
        };
        session.COOKIE_SECURE = true;
        service.DISABLE_REGISTRATION = true;
        repository.DISABLE_HTTP_GIT = true;
      };
    };

    systemd.services.forgejo.preStart = lib.mkIf config.forgejo.users.admin.enable (let
      adminCmd = "${lib.getExe config.services.forgejo.package}";
    in ''
      ${adminCmd} admin user create --admin --email "root@localhost" --username ${config.forgejo.users.admin.username} --password "$(tr -d '\n' < ${config.forgejo.users.admin.passwordFile})" || true
    '');
  };
}
