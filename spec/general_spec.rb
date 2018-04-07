require "spec_helper.rb"

RSpec.describe "General" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use git" do
    zsh("git --version")
    expect($?.success?).to be true
  end

  it "should use mongo" do
    zsh("mongo --version")
    expect($?.success?).to be true
  end

  it "should use psql" do
    zsh("psql --version")
    expect($?.success?).to be true
  end

  it "should use mysql" do
    zsh("mysql --version")
    expect($?.success?).to be true
  end

  it "should use redis" do
    zsh("redis-cli --version")
    expect($?.success?).to be true
  end

  it "should use python" do
    zsh("python --version")
    expect($?.success?).to be true
  end

  it "should use pip" do
    zsh("pip --version")
    expect($?.success?).to be true
  end

end

