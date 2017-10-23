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
      docker run --rm -v $(PWD):/work --volumes-from dev-store $(echo $@) -it dev
      exit
      ;;
    *)
      arguments="$arguments $arg"
      ;;
  esac
done

# Now call the actual command
$command $arguments
