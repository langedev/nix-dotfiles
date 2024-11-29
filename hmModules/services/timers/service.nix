{ config, lib, ... }:
let rootPath = ./.; in
{
  options.timer = {
    enableHourly = lib.mkEnableOption "Enables an hourly notification";
    enableQuarterly = lib.mkEnableOption "Enables a quarterly notification";
  };

  config = {
    systemd.user.timers = {
      hourly-time = lib.mkIf config.timer.enableHourly {
        Timer = {
          OnCalendar = "hourly";
        };
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
      };
      quarterly-time = lib.mkIf config.timer.enableQuarterly {
        Timer = {
          OnCalendar = "*-*-* *:15,30,45:00";
        };
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
      };
    };

    systemd.user.services = {
      hourly-time = lib.mkIf config.timer.enableHourly {
        Unit = {
          Description = "Notify the user every hour of time passing";
        };
        Service = {
          Type="simple";
          ExecStart="/home/pan/.config/timer_scripts/notify-time.sh 60000 1";
        };
      };
      quarterly-time = lib.mkIf config.timer.enableQuarterly {
        Unit = {
          Description = "Notify the user every 15 minutes of time passing, \
            skips hours";
        };
        Service = {
          Type="simple";
          ExecStart="/home/pan/.config/timer_scripts/notify-time.sh 10000 0";
        };
      };
    };
    xdg.configFile."timer-scripts" = {
      source = rootPath + "/scripts";
      target = "timer_scripts/";
      executable = true;
    };
  };
}
