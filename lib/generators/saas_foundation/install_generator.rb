module SaasFoundation
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      
      class_option :project_name, type: :string, default: 'My SaaS App', desc: 'Name of your SaaS project'
      class_option :skip_git, type: :boolean, default: false, desc: 'Skip git initialization'
      class_option :skip_database, type: :boolean, default: false, desc: 'Skip database creation and migration'

      def install_saas_foundation
        say "🚀 Installing SaaS Foundation...", :green
        
        @project_name = options[:project_name]
        @project_slug = @project_name.downcase.gsub(/[^a-z0-9]/, '_')
        
        update_application_name
        setup_environment_file
        update_database_config unless options[:skip_database]
        setup_git unless options[:skip_git]
        
        say_installation_complete
      end

      private

      def update_application_name
        say "→ Updating application name to #{@project_name}", :blue
        
        gsub_file 'config/application.rb', 'SaasFoundation', @project_name.gsub(/[^A-Za-z0-9]/, '')
        gsub_file 'package.json', '"name": "app"', %("name": "#{@project_slug}")
      end

      def setup_environment_file
        if File.exist?('.env')
          say "→ .env file already exists, skipping...", :yellow
        else
          say "→ Creating .env file from template...", :blue
          copy_file '../../../.env.example', '.env'
          
          gsub_file '.env', 'saas_foundation_development', "#{@project_slug}_development"
        end
      end

      def update_database_config
        say "→ Updating database configuration...", :blue
        gsub_file 'config/database.yml', 'saas_foundation', @project_slug
      end

      def setup_git
        if File.exist?('.git')
          say "→ Git already initialized, skipping...", :yellow
        else
          say "→ Initializing git repository...", :blue
          run 'git init .'
          run 'git add .'
          run "git commit -m 'Initial commit: #{@project_name} based on SaaS Foundation'"
        end
      end

      def say_installation_complete
        say "\n✅ SaaS Foundation installation complete!", :green
        say "\nNext steps:", :blue
        say "1. Update your .env file with real API keys"
        say "2. Run: rails server"
        say "3. Run: bundle exec sidekiq (in another terminal)"
        say "4. Visit: http://localhost:3000"
        say "\nHappy coding! 🎉", :green
      end
    end
  end
end