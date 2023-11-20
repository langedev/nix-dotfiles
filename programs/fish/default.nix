{ config, pkgs, ... }:

{
  programs.fish.enable = true;

  programs.fish.interactiveShellInit = ''
      cat ~/.cache/wal/sequences
    '';

  programs.fish.functions = {
    fish_greeting = "";
    fish_prompt = ''
      ${builtins.readFile ./functions/fish_prompt.fish}
    '';
    fish_right_prompt = ''
      ${builtins.readFile ./functions/fish_right_prompt.fish}
    '';
    git_branch_name = ''
      ${builtins.readFile ./functions/git_branch_name.fish}
    '';
    git_is_dirty = ''
      ${builtins.readFile ./functions/git_is_dirty.fish}
    '';
    git_is_repo = ''
      ${builtins.readFile ./functions/git_is_repo.fish}
    '';
    git_is_staged = ''
      ${builtins.readFile ./functions/git_is_staged.fish}
    '';
    git_is_touched = ''
      ${builtins.readFile ./functions/git_is_touched.fish}
    '';
    git_is_worktree = ''
      ${builtins.readFile ./functions/git_is_worktree.fish}
    '';
    n = ''
      ${builtins.readFile ./functions/n.fish}
    '';
    ssh = ''
      ${builtins.readFile ./functions/ssh.fish}
    '';
  };
}
