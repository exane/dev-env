#!/bin/bash

# Get the actual command to be called
command="$1"
shift

# To save the real arguments
arguments=""

for arg in $*
do
  case $arg in
    ssh)
      shift
      docker_options=$(echo $@ | sed "s#^\(.*\) --.*#\1#")
      docker_entrypoint=$(echo $@ | sed "s#.*-- \(.*\)\$#\1#")
      docker run \
        --add-host "dev.docker:192.168.99.100" \
        -v $(PWD):/work \
        --volumes-from dev-store $(echo $docker_options) \
        -it --rm dev $(echo $docker_entrypoint)
      exit
      ;;
    *)
      arguments="$arguments $arg"
      ;;
  esac
done

# Now call the actual command
$command $arguments
