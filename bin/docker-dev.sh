#!/bin/bash

# Get the actual command to be called
command="$1"
shift

# To save the real arguments
arguments=""

# expands port arguments
# docker dev -p 3000 -> docker dev -p 3000:3000
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
    dev)
      shift
      docker_options=$(echo " $@" | sed "s#\(.*\)\s--\s.*#\1#")
      docker_entrypoint=$(echo " $@" | sed -n "s#.*\s--\s\(.*\)\$#\1#p")
      docker_options=$(transform_port_forwarding "$docker_options")
      export SCRIPT_DIR=$(dirname $0)
      address=$(ruby -e 'require "yaml"; puts YAML.load_file("#{ENV[%(SCRIPT_DIR)]}/../config.yml")["docker"]["net"]')
      docker run \
        --add-host "dev.docker:$address" \
        -v $(PWD):/work \
        --volumes-from dev-store $(echo " $docker_options") \
        -it --rm dev $(echo " $docker_entrypoint")
      exit
      ;;
    setup)
      shift
      for arg in $*
      do
        case $arg in
          mysql)
            echo "Setup MySQL docker container..."
            docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mariadb
            echo "Setup done and running."
            exit
            ;;
          postgres)
            echo "Setup PostgreSQL docker container..."
            docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -d postgres
            echo "Setup done and running."
            exit
            ;;
          mongodb)
            echo "Setup MongoDB docker container..."
            docker run --name mongodb -p 27017:27017 -d mongo
            echo "Setup done and running."
            exit
            ;;
          mongodb34)
            echo "Setup MongoDB v3.4 on port 27018 as docker container..."
            docker run --name mongodb -p 27018:27017 -d mongo:3.4
            echo "Setup done and running."
            exit
            ;;
          elasticsearch)
            echo "Setup Elasticsearch docker container..."
            docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "ES_JAVA_OPTS=-Xms512m" -d docker.elastic.co/elasticsearch/elasticsearch:5.6.1
            echo "Setup done and running."
            exit
            ;;
          redis)
            echo "Setup Redis docker container..."
            docker run --name redis -p 6379:6379 -d redis
            echo "Setup done and running."
            exit
            ;;
          *)
            echo "docker setup: Missmatched or missing service name. Given: $arg"
            exit
            ;;
        esac
      done
      ;;
    *)
      arguments="$arguments $arg"
      ;;
  esac
done

# Now call the actual command
$command $arguments
