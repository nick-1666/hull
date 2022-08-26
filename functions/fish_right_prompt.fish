function is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function get_git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function fish_right_prompt
    set -q hull_secondary; or set -g hull_secondary (set_color brblack)  # grey text
    set -q hull_primary;   or set -g hull_primary   (set_color bryellow) # yellow text
    set -l r (set_color normal) # normal text

    echo -n -s $hull_secondary (prompt_pwd) $r
    
    # Show git branch and dirty state
    if [ (get_git_branch_name) ]
        set -l git_branch_name (get_git_branch_name)
        if  [ (is_git_dirty) ]
            echo -n -s $hull_primary " $git_branch_name" " ±" $r
        else
            echo -n -s $hull_primary " $git_branch_name" $r
        end
    end
end