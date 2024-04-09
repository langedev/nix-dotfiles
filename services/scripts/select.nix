{ pkgs }:

pkgs.writeShellApplication {
  name = "select";

  runtimeInputs = [ fzf rofi ];

  text = ''
    if [ ${PPID} -ne 1 ]; then
      echo -e $1 | fzf
    else
      echo -e $1 | rofi -dmenu -p $2
    fi
  '';
}
