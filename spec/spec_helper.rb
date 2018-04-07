require "YAML"

CONTAINER_NAME = "dev-test"

def zsh(cmd)
  `docker exec #{CONTAINER_NAME} zsh -c 'source /home/dev/.zshrc>/dev/null 2>/dev/null&& #{cmd}'`
end

def docker
  "bin/docker-dev.sh docker"
end

def create_container
  `#{docker} dev -d --name #{CONTAINER_NAME}`
end

def delete_container
  `#{docker} rm -f #{CONTAINER_NAME}`
end

def config
  @config ||= YAML.load_file("./config.yml")
end
