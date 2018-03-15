require "yaml"
require "webrick"
config = YAML.load_file("./config.yml")

root = File.expand_path "~"
host = config["http"]["host"]
port = config["http"]["port"]

authenticate = Proc.new do |req, res|
  WEBrick::HTTPAuth.basic_auth(req, res, "") do |user, password|
    user == config["auth"]["user"] && password == config["auth"]["password"]
  end
end

server = WEBrick::HTTPServer.new(:Port => port, :BindAddress => host)

server.mount("/", WEBrick::HTTPServlet::FileHandler, root,
  :FancyIndexing => true,
  :HandlerCallback => authenticate
)

trap("INT") { server.shutdown }
trap("TERM") { server.shutdown }
server.start
