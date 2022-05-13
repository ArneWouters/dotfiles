# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases, for a full list of active aliases, run `alias`.
source ~/.shell/aliases.sh

# Makes it only show the username instead of username@machine
# prompt_context() {
#     if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#         prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#     fi
# }

# transfer.sh
transfer()
{
    local file
    declare -a file_array
    file_array=("${@}")

    if [[ "${file_array[@]}" == "" || "${1}" == "--help" || "${1}" == "-h" ]]
    then
        echo "${0} - Upload arbitrary files to \"transfer.sh\"."
        echo ""
        echo "Usage: ${0} [options] [<file>]..."
        echo ""
        echo "OPTIONS:"
        echo "  -h, --help"
        echo "      show this message"
        echo ""
        echo "EXAMPLES:"
        echo "  Upload a single file from the current working directory:"
        echo "      ${0} \"image.img\""
        echo ""
        echo "  Upload multiple files from the current working directory:"
        echo "      ${0} \"image.img\" \"image2.img\""
        echo ""
        echo "  Upload a file from a different directory:"
        echo "      ${0} \"/tmp/some_file\""
        echo ""
        echo "  Upload all files from the current working directory. Be aware of the webserver's rate limiting!:"
        echo "      ${0} *"
        echo ""
        echo "  Upload a single file from the current working directory and filter out the delete token and download link:"
        echo "      ${0} \"image.img\" | awk --field-separator=\": \" '/Delete token:/ { print \$2 } /Download link:/ { print \$2 }'"
        echo ""
        echo "  Show help text from \"transfer.sh\":"
        echo "      curl --request GET \"https://transfer.sh\""
        return 0
    else
        for file in "${file_array[@]}"
        do
            if [[ ! -f "${file}" ]]
            then
                echo -e "\e[01;31m'${file}' could not be found or is not a file.\e[0m" >&2
                return 1
            fi
        done
        unset file
    fi

    local upload_files
    local curl_output
    local awk_output
    local filename

    du --total --block-size="K" --dereference "${file_array[@]}" >&2
    # be compatible with "bash"
    if [[ "${ZSH_NAME}" == "zsh" ]]
    then
        read $'upload_files?\e[01;31mDo you really want to upload the above files ('"${#file_array[@]}"$') to "transfer.sh"? (Y/n): \e[0m'
    elif [[ "${BASH}" == *"bash"* ]]
    then
        read -p $'\e[01;31mDo you really want to upload the above files ('"${#file_array[@]}"$') to "transfer.sh"? (Y/n): \e[0m' upload_files
    fi

    case "${upload_files:-y}" in
        "y"|"Y")
            # for the sake of the progress bar, execute "curl" for each file.
            # the parameters "--include" and "--form" will suppress the progress bar.
            for file in "${file_array[@]}"
            do
                filename="${file##*/}"
                # show delete link and filter out the delete token from the response header after upload.
                # it is important to save "curl's" "stdout" via a subshell to a variable or redirect it to another command,
                # which just redirects to "stdout" in order to have a sane output afterwards.
                # the progress bar is redirected to "stderr" and is only displayed,
                # if "stdout" is redirected to something; e.g. ">/dev/null", "tee /dev/null" or "| <some_command>".
                # the response header is redirected to "stdout", so redirecting "stdout" to "/dev/null" does not make any sense.
                # redirecting "curl's" "stderr" to "stdout" ("2>&1") will suppress the progress bar.
                curl_output=$(curl --request PUT --progress-bar --dump-header - --upload-file "${file}" "https://transfer.sh/${filename}")
                awk_output=$(awk \
                    'gsub("\r", "", $0) && tolower($1) ~ /x-url-delete/ \
                    {
                        delete_link=$2;
                        print "Delete command: curl --request DELETE " "\""delete_link"\"";

                        gsub(".*/", "", delete_link);
                        delete_token=delete_link;
                        print "Delete token: " delete_token;
                    }

                    END{
                        print "Download link: " $0;
                    }' <<< "${curl_output}")

                # return the results via "stdout", "awk" does not do this for some reason.
                echo -e "${awk_output}\n"

                # avoid rate limiting as much as possible; nginx: too many requests.
                if (( ${#file_array[@]} > 4 ))
                then
                    sleep 5
                fi
            done
            ;;

        "n"|"N")
            return 1
            ;;

        *)
            echo -e "\e[01;31mWrong input: '${upload_files}'.\e[0m" >&2
            return 1
    esac
}

# TMUX
export TERM=xterm-256color
export LC_CTYPE="en_US.UTF-8"

# Haskell stuff
export PATH="$PATH:$HOME/.cabal/bin"

# opam configuration
[[ ! -r /home/awouters/.opam/opam-init/init.zsh ]] || source /home/awouters/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

eval "$(starship init zsh)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

