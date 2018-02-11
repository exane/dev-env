#!/bin/bash

# Get the actual command to be called
command="$1"
shift

# To save the real arguments
arguments=""

# expands port arguments
# docker ssh -p 3000 -> docker ssh -p 3000:3000
transform_port_forwarding() {
  local port_option="$1"
  if [ $(uname) = "Darwin" ]; then
    echo " $port_option" | sed -E "s/-p ([0-9]+)/-p \1:\1 -e PORT_\1=/g"
  else
    echo " $port_option" | sed "s/-p \([0-9]\+\)/-p \1:\1 -e PORT_\1=/g"
  fi
}

for arg in $*
do
  case $arg in
    ssh)
      shift
      docker_options=$(echo " $@" | sed "s#\(.*\)\s--\s.*#\1#")
      docker_entrypoint=$(echo " $@" | sed -n "s#\s--\s\(.*\)\$#\1#p")
      docker_options=$(transform_port_forwarding "$docker_options")
      docker run \
        --add-host "dev.docker:192.168.99.100" \
        -v $(PWD):/work \
        --volumes-from dev-store $(echo " $docker_options") \
        -it --rm dev $(echo " $docker_entrypoint")
      exit
      ;;
    *)
      arguments="$arguments $arg"
      ;;
  esac
done

# Now call the actual command
$command $arguments
