require "spec_helper.rb"

RSpec.describe "PHP Module" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use php" do
    zsh("php --version")
    expect($?.success?).to be true
  end

  it "should use composer" do
    zsh("composer --version")
    expect($?.success?).to be true
  end

end if config["modules"].include? "php"
