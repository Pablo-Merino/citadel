require "spec_helper"

describe Citadel do
  it "has a VERSION" do
    Citadel::VERSION.should =~ /^[\.\da-z]+$/
  end
end
