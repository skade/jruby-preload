require 'test_helper'

describe Bundled::Runtime::Container do
  it "can be created with no arguments" do
    Bundled::Runtime::Container.new
  end

  it "can be terminated" do
    Bundled::Runtime::Container.new.terminate
  end

  it "loads the bundle" do
    container = Bundled::Runtime::Container.new
    container.load_bundler!
    container.container.run_scriptlet("Minitest")
  end

  it "has not loaded any outer classes" do
    assert_raises(Java::OrgJrubyEmbed::EvalFailedException) {
      container = Bundled::Runtime::Container.new
      container.load_bundler!
      container.container.run_scriptlet("Bundled::Runtime::Container")
    }
  end
end
