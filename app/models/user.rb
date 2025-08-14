class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]

  # Pay gem integration for billing (only if Pay is loaded)
  if defined?(Pay)
    pay_customer stripe_attributes: :stripe_attributes,
                 paddle_attributes: :paddle_attributes
  end

  # Validations
  validates :first_name, :last_name, presence: true, on: :update
  validates :provider, :uid, presence: true, if: :oauth_user?

  # Methods
  def full_name
    "#{first_name} #{last_name}".strip
  end

  def display_name
    full_name.present? ? full_name : email.split('@').first
  end

  def oauth_user?
    provider.present? && uid.present?
  end

  # OAuth methods
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name || auth.info.name&.split&.first
      user.last_name = auth.info.last_name || auth.info.name&.split&.last
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  private

  def stripe_attributes
    {
      address: {
        city: billing_info['city'],
        country: billing_info['country'],
        line1: billing_info['address_line1'],
        line2: billing_info['address_line2'],
        postal_code: billing_info['postal_code'],
        state: billing_info['state']
      },
      metadata: {
        user_id: id
      }
    }
  end

  def paddle_attributes
    {
      name: full_name,
      email: email
    }
  end
end
