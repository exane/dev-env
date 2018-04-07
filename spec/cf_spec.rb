require "spec_helper.rb"

RSpec.describe "CF Module" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use cf" do
    zsh("cf --version")
    expect($?.success?).to be true
  end

  it "should use spruce" do
    zsh("spruce --version")
    expect($?.success?).to be true
  end

end if config["modules"].include? "cf"

