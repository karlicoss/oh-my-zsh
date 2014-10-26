# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# taken from plugins/mercurial in_hg function
function in_git() {
  if [[ -d .git ]] || $(git status > /dev/null 2>&1)
  then
    echo 1
  fi
}

function vcs_type() {
    if [ $(in_git) ]
    then
        echo 'git'
    elif [ $(in_hg) ]
    then
        echo 'hg'
    fi
}

function vcs_status() {
    if [ $(in_git) ]
    then
        local st=$(git_prompt_status)
        if [[ -n $st ]]
        then
            echo " $st"
        else
            echo ""
        fi
    elif [ $(in_hg) ]
    then
        local st=$(hg_prompt_status)
        if [[ -n $st ]]
        then
            echo " $st"
        else
            echo ""
        fi
    fi
}

function vcs_branch() {
    if [ $(in_git) ]
    then
        echo $(current_branch)
    elif [ $(in_hg) ]
    then
        echo $(hg_get_branch_name)
    fi    
}

function vcs_prompt_status() {
    if [ $(in_git) ] || [ $(in_hg) ]
    then
        echo " [$(vcs_type):%{$fg[cyan]%}$(vcs_branch)%{$reset_color%}$(vcs_status)]"
    else
        echo ''
    fi
}


ZSH_THEME_GIT_PROMPT_ADDED="%B%{$FG[082]%}A%{$reset_color%}%b"
ZSH_THEME_GIT_PROMPT_MODIFIED="%B%{$FG[166]%}M%{$reset_color%}%b"
ZSH_THEME_GIT_PROMPT_DELETED="%B%{$FG[160]%}D%{$reset_color%}%b"
ZSH_THEME_GIT_PROMPT_RENAMED="%B%{$FG[220]%}R%{$reset_color%}%b"
ZSH_THEME_GIT_PROMPT_UNMERGED="%B%{$FG[082]%}═%{$reset_color%}%b"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%B%{$FG[190]%}U%{$reset_color%}%b"


# TODO distinguish removed and deleted statuses in git and mercurial

ZSH_THEME_HG_PROMPT_ADDED="%B%{$FG[082]%}A%{$reset_color%}%b"
ZSH_THEME_HG_PROMPT_MODIFIED="%B%{$FG[166]%}M%{$reset_color%}%b"
ZSH_THEME_HG_PROMPT_DELETED="%B%{$FG[160]%}D%{$reset_color%}%b"
ZSH_THEME_HG_PROMPT_RENAMED="%B%{$FG[220]%}R%{$reset_color%}%b"
ZSH_THEME_HG_PROMPT_UNMERGED="%B%{$FG[082]%}═%{$reset_color%}%b"
ZSH_THEME_HG_PROMPT_UNTRACKED="%B%{$FG[190]%}U%{$reset_color%}%b"

local vcs_info='$(vcs_prompt_status)'


# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 

# 1. Print hash (colored blue and bold)
# 2. Print username (colored cyan)
# 3. "at"
# 4. Print hostname (colored green)
# 5. "in"
# 6. Print current directory (colored yellow, bold)
# 7. Print time (colored white, 24 hour format)
# 8. Print "$" on the next line (colored red, bold)
PROMPT="%{$fg[blue]%}%B#%b%{$reset_color%} \
%{$fg[cyan]%}%n%{$fg[white]%}@%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$fg[yellow]%}%B%~%b%{$reset_color%}\
${vcs_info} \
%{$fg[white]%}[%T]
%{$fg[red]%}%B$%b%{$reset_color%} "