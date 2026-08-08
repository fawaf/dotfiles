# functions/exponential_backoff.fish
# mirrors: dotfiles/zsh.functions.d/functions - exponential_backoff()

function exponential_backoff --description "Retry a command with exponential backoff on failure"
    set -l MAX_RETRIES (set -q EXPBACKOFF_MAX_RETRIES && echo $EXPBACKOFF_MAX_RETRIES || echo 19)
    set -l BASE (set -q EXPBACKOFF_BASE && echo $EXPBACKOFF_BASE || echo 1)
    set -l MAX (set -q EXPBACKOFF_MAX && echo $EXPBACKOFF_MAX || echo 9999999)
    set -l FAILURES 0

    while not $argv
        set FAILURES (math $FAILURES + 1)
        if test $FAILURES -gt $MAX_RETRIES
            echo $argv >&2
            echo " * Failed, max retries exceeded" >&2
            return 1
        else
            set -l SECONDS (math "$BASE * 2 ^ ($FAILURES - 1)")
            if test $SECONDS -gt $MAX
                set SECONDS $MAX
            end
            echo $argv >&2
            echo_color red " * $FAILURES failure(s), retrying in $SECONDS second(s)" >&2
            sleep $SECONDS
            echo
        end
    end
end

# alias
function expbackoff
    exponential_backoff $argv
end
