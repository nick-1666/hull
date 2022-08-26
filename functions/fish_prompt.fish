function fish_prompt
    set -l uid (id -u $USER) # get user id (for sudo check)

    set -q hull_prompt; or set -g hull_prompt "λ" # prompt
    set -q hull_prompt_su; or set -g hull_prompt_su "Λ" # sudo prompt

    set -q hull_secondary; or set -g hull_secondary (set_color brblack)  # grey text
    set -q hull_primary;   or set -g hull_primary   (set_color bryellow) # yellow text
    set -l r (set_color normal) # normal text

    # ssh hostname
    if test -n "$SSH_CONNECTION"
      echo -n -s $hull_secondary $HOSTNAME " " $r
    end

    # time
    echo -n -s $hull_secondary (date +"%R") " "
    
    # change prompt for root
    if [ $uid -eq 0 ]
        echo -n -s $hull_primary $hull_prompt_su $r
    else
        echo -n -s $hull_primary $hull_prompt $r 
    end

    echo -n -s $r " " $r
end
