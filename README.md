# 🚀 SaaS Foundation

A comprehensive Rails 8 template for building SaaS applications with authentication, billing, background jobs, and deployment configurations.

[![Rails Version](https://img.shields.io/badge/Rails-8.0-red.svg)](https://rubyonrails.org/)
[![Ruby Version](https://img.shields.io/badge/Ruby-3.4.1-red.svg)](https://www.ruby-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## ✨ Features

### 🔐 Authentication (4 hours)
- **Complete Devise setup** with email/password authentication
- **OAuth integration** with Google and GitHub
- **Password reset** functionality
- **User management** with admin flags and profile management

### 💳 Billing & Subscriptions (6 hours)
- **Multi-provider support** with Stripe and Paddle integrations via Pay gem
- **Subscription management** with checkout flows
- **Webhook handling** for payment events
- **Customer portal** for billing management

### ⚡ Background Jobs (1 hour)
- **Sidekiq** configuration for background job processing
- **Redis** setup for job queuing
- **Password-protected web dashboard** for monitoring jobs
- **Sample jobs** and mailer integration

### 🚀 Deployment (2 hours)
- **Heroku** deployment with one-click setup
- **Render** configuration for modern cloud deployment
- **Hatchbox** setup for VPS deployment
- **Kamal** configuration for Docker-based deployment

### 🧪 Tests (1 hour)
- **Dual testing framework** support (RSpec and Minitest)
- **Factory Bot** integration for test data
- **Capybara** setup for feature testing
- **Comprehensive test examples** and helpers

### 🎨 Extras (2 hours)
- **SEO optimization** with meta-tags gem
- **OpenGraph images** setup for social sharing
- **Custom fonts** (Inter) and Tailwind CSS configuration
- **Setup scripts** for quick project initialization

## 🛠️ Quick Start

### Prerequisites

- Ruby 3.4.1 or higher
- Node.js 20 or higher
- PostgreSQL
- Redis (for background jobs)

### Installation

1. **Clone or fork this repository:**
   ```bash
   git clone https://github.com/your-username/saas-foundation.git my-saas-app
   cd my-saas-app
   ```

2. **Run the setup script:**
   ```bash
   ./bin/setup_saas
   ```

3. **Configure your environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your API keys and configuration
   ```

4. **Start the development servers:**
   ```bash
   # Terminal 1: Rails server
   rails server
   
   # Terminal 2: Background jobs
   bundle exec sidekiq
   
   # Terminal 3: Email testing (optional)
   gem install mailcatcher && mailcatcher
   ```

5. **Visit your application:**
   Open [http://localhost:3000](http://localhost:3000)

## 📚 Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# OAuth Configuration
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_CLIENT_SECRET=your_github_client_secret

# Stripe Configuration
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
STRIPE_BASIC_PRICE_ID=price_...
STRIPE_PRO_PRICE_ID=price_...

# Database & Redis
DATABASE_URL=postgresql://localhost/my_saas_app_development
REDIS_URL=redis://localhost:6379/0
```

### OAuth Setup

#### Google OAuth
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URI: `http://localhost:3000/users/auth/google_oauth2/callback`

#### GitHub OAuth
1. Go to [GitHub Developer Settings](https://github.com/settings/developers)
2. Create a new OAuth App
3. Set Authorization callback URL: `http://localhost:3000/users/auth/github/callback`

### Stripe Setup
1. Create a [Stripe account](https://stripe.com)
2. Get your API keys from the dashboard
3. Create products and prices for your subscription plans
4. Update the price IDs in your environment variables

## 🚀 Deployment

### Heroku

1. **One-click deploy:**
   [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

2. **Manual deployment:**
   ```bash
   heroku create my-saas-app
   heroku addons:create heroku-postgresql:essential-0
   heroku addons:create heroku-redis:essential-0
   git push heroku main
   ```

### Render

1. **Connect your GitHub repository**
2. **Use the included `render.yaml`** for automatic configuration
3. **Set environment variables** in Render dashboard

### Hatchbox

1. **Create a new app** in Hatchbox dashboard
2. **Use the included `hatchbox.yml`** configuration
3. **Deploy** with git push

### Kamal (Docker)

1. **Update `config/deploy.yml`** with your server details
2. **Setup accessories** (database and Redis)
   ```bash
   kamal accessory boot all
   ```
3. **Deploy:**
   ```bash
   kamal deploy
   ```

## 🧪 Testing

### RSpec (Recommended)
```bash
# Run all specs
rspec

# Run specific test
rspec spec/models/user_spec.rb

# Run with coverage
COVERAGE=true rspec
```

### Minitest
```bash
# Run all tests
rails test

# Run specific test
rails test test/models/user_test.rb
```

## 📁 Project Structure

```
app/
├── controllers/
│   ├── billing_controller.rb          # Subscription management
│   ├── home_controller.rb             # Dashboard and landing
│   └── users/
│       └── omniauth_callbacks_controller.rb  # OAuth handling
├── models/
│   └── user.rb                        # User model with Pay integration
├── jobs/
│   └── welcome_email_job.rb           # Background job example
├── mailers/
│   └── user_mailer.rb                 # Email templates
└── helpers/
    ├── application_helper.rb          # General helpers
    └── seo_helper.rb                  # SEO and meta tags

config/
├── initializers/
│   ├── devise.rb                      # Authentication config
│   ├── pay.rb                         # Billing config
│   ├── sidekiq.rb                     # Background jobs config
│   └── meta_tags.rb                   # SEO config
├── deploy.yml                         # Kamal deployment
└── database.yml                       # Database config

deployment/
├── app.json                           # Heroku config
├── render.yaml                        # Render config
├── hatchbox.yml                       # Hatchbox config
└── Procfile                           # Process definitions
```

## 🔧 Customization

### Adding New Features

1. **Create a new controller:**
   ```bash
   rails generate controller Features index show
   ```

2. **Add routes:**
   ```ruby
   # config/routes.rb
   resources :features
   ```

3. **Update navigation:**
   ```erb
   <!-- app/views/layouts/application.html.erb -->
   <%= link_to "Features", features_path %>
   ```

### Modifying Billing Plans

1. **Update the plans in `billing_controller.rb`:**
   ```ruby
   @plans = [
     {
       name: "Starter",
       price: 999,
       stripe_price_id: ENV['STRIPE_STARTER_PRICE_ID'],
       features: ["Feature 1", "Feature 2"]
     }
   ]
   ```

2. **Create corresponding Stripe products** in your dashboard

### Adding Email Templates

1. **Create new mailer methods:**
   ```ruby
   # app/mailers/user_mailer.rb
   def custom_email(user)
     @user = user
     mail(to: @user.email, subject: 'Custom Email')
   end
   ```

2. **Create email templates:**
   ```erb
   <!-- app/views/user_mailer/custom_email.html.erb -->
   <!-- app/views/user_mailer/custom_email.text.erb -->
   ```

## 🐛 Troubleshooting

### Common Issues

**Database connection errors:**
```bash
# Ensure PostgreSQL is running
brew services start postgresql  # macOS
sudo service postgresql start   # Linux
```

**Redis connection errors:**
```bash
# Ensure Redis is running
brew services start redis       # macOS
sudo service redis-server start # Linux
```

**Asset compilation issues:**
```bash
# Rebuild assets
yarn build && yarn build:css
rails assets:precompile
```

**OAuth errors:**
- Check your callback URLs match exactly
- Ensure your OAuth apps are configured correctly
- Verify environment variables are set

## 📖 Additional Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [Devise Documentation](https://github.com/heartcombo/devise)
- [Pay Gem Documentation](https://github.com/pay-rails/pay)
- [Sidekiq Documentation](https://sidekiq.org/)
- [Tailwind CSS Documentation](https://tailwindcss.com/)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Rails](https://rubyonrails.org/) - The web framework
- [Devise](https://github.com/heartcombo/devise) - Authentication
- [Pay](https://github.com/pay-rails/pay) - Payments
- [Sidekiq](https://sidekiq.org/) - Background jobs
- [Tailwind CSS](https://tailwindcss.com/) - Styling

---

**Built with ❤️ for the Rails community**

Need help? [Open an issue](https://github.com/your-username/saas-foundation/issues) or [start a discussion](https://github.com/your-username/saas-foundation/discussions).
