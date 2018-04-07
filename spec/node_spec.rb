require "spec_helper.rb"

RSpec.describe "NodeJS Module" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use nvm" do
    zsh("nvm --version")
    expect($?.success?).to be true
  end

  it "should use yarn" do
    zsh("yarn --version")
    expect($?.success?).to be true
  end

end if config["modules"].include? "node"
