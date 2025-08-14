require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    context "when user is not signed in" do
      it "returns successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "displays welcome message" do
        get root_path
        expect(response.body).to include("Welcome to SaaS Foundation")
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before { sign_in user }

      it "redirects to dashboard" do
        get root_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "GET /dashboard" do
    context "when user is not signed in" do
      it "redirects to sign in page" do
        get dashboard_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user, first_name: "John") }

      before { sign_in user }

      it "returns successful response" do
        get dashboard_path
        expect(response).to have_http_status(:success)
      end

      it "displays welcome message with user name" do
        get dashboard_path
        expect(response.body).to include("Welcome back, John")
      end
    end
  end
end