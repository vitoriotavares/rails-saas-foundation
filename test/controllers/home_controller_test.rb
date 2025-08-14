require "test_helper"

describe HomeController do
  it "gets index" do
    get home_index_url
    must_respond_with :success
  end

  it "gets dashboard" do
    get home_dashboard_url
    must_respond_with :success
  end
end
