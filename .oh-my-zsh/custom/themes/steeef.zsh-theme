# prompt style and colors based on Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

function steeef_is_ahead_or_behind {
    remoteStatus=$(git rev-list --left-right --count origin/$(git rev-parse --abbrev-ref HEAD)...HEAD 2>/dev/null)
    if [[ -n "$remoteStatus" ]]; then
        ahead=$(echo $remoteStatus | cut -f2)
        behind=$(echo $remoteStatus | cut -f1)
        if [[ $ahead -gt 0 && $behind -gt 0 ]]; then
            echo -n "%{$yellow%}⇡$ahead %{$orange%}⇣$behind${PR_RST}"
        elif [[ $ahead -gt 0 ]]; then
            echo -n "%{$yellow%}⇡$ahead${PR_RST}"
        elif [[ $behind -gt 0 ]]; then
            echo -n "%{$limegreen%}⇣$behind${PR_RST}"
        fi
    fi
}

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{141}"
    hotpink="%F{161}"
    limegreen="%F{118}"
    blue="%F{69}"
    yellow="%F{214}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="on %{$limegreen%} %b ${PR_RST}[%u%c${PR_RST}]"
FMT_ACTION="%{$limegreen%}%a${PR_RST}"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        remoteStatus=$(steeef_is_ahead_or_behind)

        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="on %{$limegreen%} %b ${PR_RST}[%u%c%{$hotpink%}●${PR_RST}${remoteStatus}]"
        else
            FMT_BRANCH="on %{$limegreen%} %b ${PR_RST}[%u%c${PR_RST}${remoteStatus}]"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd
add-zsh-hook precmd steeef_is_ahead_or_behind

PROMPT=$'
%{$purple%}%n${PR_RST} at %{$yellow%}%m${PR_RST} in %{$blue%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
$ '
