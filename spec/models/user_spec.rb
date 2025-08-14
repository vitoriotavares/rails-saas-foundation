require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to respond_to(:payment_methods) }
    it { is_expected.to respond_to(:subscriptions) }
  end

  describe "validations" do
    subject { create(:user) }
    
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "methods" do
    let(:user) { create(:user, first_name: "John", last_name: "Doe") }

    describe "#full_name" do
      it "returns the full name" do
        expect(user.full_name).to eq("John Doe")
      end
    end

    describe "#display_name" do
      context "when user has first and last name" do
        it "returns the full name" do
          expect(user.display_name).to eq("John Doe")
        end
      end

      context "when user has no names" do
        let(:user_without_names) { create(:user, first_name: nil, last_name: nil, email: "test@example.com") }
        
        it "returns email prefix" do
          expect(user_without_names.display_name).to eq("test")
        end
      end
    end

    describe "#oauth_user?" do
      context "when user has provider and uid" do
        let(:oauth_user) { create(:user, :oauth_user) }
        
        it "returns true" do
          expect(oauth_user.oauth_user?).to be true
        end
      end

      context "when user doesn't have provider or uid" do
        it "returns false" do
          expect(user.oauth_user?).to be false
        end
      end
    end
  end

  describe ".from_omniauth" do
    let(:auth_hash) do
      OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
          email: 'test@example.com',
          first_name: 'John',
          last_name: 'Doe'
        }
      })
    end

    context "when user doesn't exist" do
      it "creates a new user" do
        expect {
          User.from_omniauth(auth_hash)
        }.to change(User, :count).by(1)
      end

      it "sets user attributes correctly" do
        user = User.from_omniauth(auth_hash)
        expect(user.email).to eq('test@example.com')
        expect(user.first_name).to eq('John')
        expect(user.last_name).to eq('Doe')
        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('123456789')
      end
    end

    context "when user already exists" do
      let!(:existing_user) { create(:user, email: 'test@example.com') }

      it "doesn't create a new user" do
        expect {
          User.from_omniauth(auth_hash)
        }.not_to change(User, :count)
      end

      it "returns the existing user" do
        user = User.from_omniauth(auth_hash)
        expect(user).to eq(existing_user)
      end
    end
  end
end