# Changelog

All notable changes to SaaS Foundation will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-08-13

### Added
- Initial release of SaaS Foundation
- Complete Rails 8 application setup with PostgreSQL and Redis
- Authentication system with Devise including:
  - Email/password authentication
  - OAuth integration (Google and GitHub)
  - Password reset functionality
  - User profile management
- Billing system integration:
  - Pay gem for multi-provider support
  - Stripe integration with checkout flows
  - Paddle support configuration
  - Subscription management
  - Webhook handling
- Background job processing:
  - Sidekiq configuration
  - Redis setup
  - Password-protected web dashboard
  - Sample job implementations
- Deployment configurations:
  - Heroku with one-click deploy
  - Render with YAML configuration
  - Hatchbox setup
  - Kamal (Docker) deployment
- Testing framework setup:
  - RSpec configuration with FactoryBot
  - Minitest support
  - Capybara for feature testing
  - Comprehensive test examples
- SEO and performance features:
  - Meta tags configuration
  - OpenGraph setup
  - Custom fonts (Inter)
  - Tailwind CSS integration
- Developer experience:
  - Setup scripts for quick initialization
  - Comprehensive documentation
  - Environment configuration templates
  - Generator for new projects

### Technical Details
- Ruby 3.4.1
- Rails 8.0.2
- PostgreSQL database
- Redis for background jobs
- Tailwind CSS for styling
- esbuild for JavaScript bundling

### Dependencies
- devise (~> 4.9)
- pay (~> 7.0)
- sidekiq (~> 8.0)
- meta-tags (~> 2.22)
- omniauth-google-oauth2
- omniauth-github
- rspec-rails
- factory_bot_rails
- capybara
- selenium-webdriver

[1.0.0]: https://github.com/your-username/saas-foundation/releases/tag/v1.0.0