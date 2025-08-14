require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user should be valid with valid attributes" do
    user = build(:user)
    assert user.valid?
  end

  test "user should require email" do
    user = build(:user, email: nil)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "user should require unique email" do
    existing_user = create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "full_name should return concatenated first and last name" do
    user = build(:user, first_name: "John", last_name: "Doe")
    assert_equal "John Doe", user.full_name
  end

  test "display_name should return full name when available" do
    user = build(:user, first_name: "John", last_name: "Doe")
    assert_equal "John Doe", user.display_name
  end

  test "display_name should return email prefix when name not available" do
    user = build(:user, first_name: nil, last_name: nil, email: "test@example.com")
    assert_equal "test", user.display_name
  end

  test "oauth_user? should return true for oauth users" do
    user = build(:user, :oauth_user)
    assert user.oauth_user?
  end

  test "oauth_user? should return false for regular users" do
    user = build(:user)
    assert_not user.oauth_user?
  end

  test "from_omniauth should create new user" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: 'newuser@example.com',
        first_name: 'Jane',
        last_name: 'Smith'
      }
    })

    assert_difference 'User.count', 1 do
      user = User.from_omniauth(auth_hash)
      assert_equal 'newuser@example.com', user.email
      assert_equal 'Jane', user.first_name
      assert_equal 'Smith', user.last_name
      assert_equal 'google_oauth2', user.provider
      assert_equal '123456789', user.uid
    end
  end

  test "from_omniauth should find existing user by email" do
    existing_user = create(:user, email: 'existing@example.com')
    auth_hash = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: 'existing@example.com',
        first_name: 'Jane',
        last_name: 'Smith'
      }
    })

    assert_no_difference 'User.count' do
      user = User.from_omniauth(auth_hash)
      assert_equal existing_user, user
    end
  end
end