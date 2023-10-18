
# If on login node then source .profile; otherwise change shell to zsh
LOGIN="adder"
if [[ "$HOSTNAME" == *"$LOGIN"* ]]; 
then
	source .profile
else
	export PATH=$HOME/.local/bin:$PATH
	export SHELL=`which zsh`
	[ -f "$SHELL" ] && exec "$SHELL" -l
fi

