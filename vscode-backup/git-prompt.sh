if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

set_bash_prompt() {
	local cwd="$PWD"
	if [[ "$cwd" == "$HOME"* ]]; then  # Change /home/user to ~
		cwd="~${cwd#$HOME}"
	fi
    local base="${cwd##*/}"            # Last folder name
    local parent="${cwd%/*}/"          # Path to the last folder

    PS1='\[\033]0;'"$TITLEPREFIX:$PWD"'\007\]'  # set terminal window title
    PS1="$PS1"' '                    			# space padding
	
	# PS1="$PS1"'\u@\h '             				# user@host<space>
	# PS1="$PS1"'$MSYSTEM '          				# show MSYSTEM

    PS1="$PS1"'\[\033[0;93m\]'"$parent"         # yellow + ~/Desktop/
    PS1="$PS1"'\[\033[1;91m\]'"$base"           # white bold + folder
    PS1="$PS1"'\[\033[0m\]'                     # reset

	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1""\[\033[0;91m\]"  		# change color to red
			PS1="$PS1"'`__git_ps1`'   			# bash function
		fi
	fi

    PS1="$PS1"'\[\033[0;93m\] > '               # yellow + >
    PS1="$PS1"'\[\033[0m\]'                     # reset
}

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PROMPT_COMMAND=set_bash_prompt
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
