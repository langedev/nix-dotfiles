function git_is_repo
  test -d .git
  or begin
    set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
    and test $info[2] = false
  end
end

function git_is_worktree
  git_is_repo
  and test (command git rev-parse --is-inside-git-dir) = false
end

function git_is_dirty
  git_is_worktree; and not command git diff --no-ext-diff --quiet --exit-code
end

function git_is_staged
  git_is_repo; and begin
    not command git diff --cached --no-ext-diff --quiet --exit-code
  end
end

function git_branch_name
  git_is_repo; and begin
    command git symbolic-ref --short HEAD 2> /dev/null;
      or command git show-ref --head -s --abbrev | head -n1 2> /dev/null
  end
end

function git_is_touched
  git_is_worktree; and begin
    # The first checks for staged changes, the second for unstaged ones.
    # We put them in this order because checking staged changes is *fast*.
    not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
    or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
  end
end

if git_is_repo
    echo -n -s (set_color yellow) (git_branch_name) (set_color normal)
    set -l git_meta ""
    if test (command git ls-files --others --exclude-standard | wc -w 2> /dev/null) -gt 0
        set git_meta "$git_meta?"
    end
    # if test (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
    #     set git_meta "$git_meta\$"
    # end
    if git_is_touched
        git_is_dirty && set git_meta (string join "$git_meta" "x")
        git_is_staged && set git_meta (string join "$git_meta" "o")
    end
    set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
    if test $commit_count
        set -l behind (echo $commit_count | cut -f 1)
        set -l ahead (echo $commit_count | cut -f 2)
        if test $behind -gt 0
            set git_meta "$git_meta«"
        end
        if test $ahead -gt 0
            set git_meta "$git_meta»"
        end
    end
    if test $git_meta
        echo -n -s (set_color red) " " $git_meta " " (set_color normal)
    else
        echo -n -s " "
    end
end
