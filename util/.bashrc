# Change shell to ignore hostname
export PS1="\u@\h:\w $ "

alias ls="ls --color=auto"

# Go to xv6_docker directory
if [[ -s /xv6_docker ]]; then
        cd /xv6_docker
fi
