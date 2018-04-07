require "spec_helper.rb"

RSpec.describe "Ruby Module" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use ruby" do
    zsh("ruby --version")
    expect($?.success?).to be true
  end

  it "should use rvm" do
    zsh("rvm --version")
    expect($?.success?).to be true
  end

end if config["modules"].include? "ruby"
