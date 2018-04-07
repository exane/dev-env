require "spec_helper.rb"

RSpec.describe "Elixir Module" do

  before :all do
    create_container
  end

  after :all do
    delete_container
  end

  it "should use mix" do
    zsh("mix --version")
    expect($?.success?).to be true
  end

  it "should use iex" do
    zsh("iex --version")
    expect($?.success?).to be true
  end

end if config["modules"].include? "elixir"
