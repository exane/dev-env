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
      prefix=$(echo $@ | sed "s#^\(.*\) --.*#\1#")
      subfix=$(echo $@ | sed "s#.*-- \(.*\)\$#\1#")
      docker run \
        --add-host "dev.docker:192.168.99.100" \
        -v $(PWD):/work \
        --volumes-from dev-store $(echo $prefix) \
        -it --rm dev $(echo $subfix)
      exit
      ;;
    *)
      arguments="$arguments $arg"
      ;;
  esac
done

# Now call the actual command
$command $arguments
