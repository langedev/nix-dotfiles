set -l last_command_status $status

set -l symbol 'τ'

set -l normal_color (set_color normal)
set -l symbol_color (set_color blue -o)
set -l error_color (set_color red -o)

if test $last_command_status -eq 0
    echo -n -s $symbol_color $symbol " " $normal_color
else
    echo -n -s $error_color $symbol " " $normal_color
end
