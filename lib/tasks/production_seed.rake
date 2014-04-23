namespace :db do
  desc "Set default data for production"
  task production_seed: :environment do
    load "#{Rails.root}/db/seeds/admins.rb"
    # load "#{Rails.root}/db/seeds/categories.rb"
    load "#{Rails.root}/db/seeds/gender.rb"

    # include Seeds
    add_admin
    # create_categories
    add_gender
  end

  desc "Fully reloading of development environment"
  task :up_ do
    raise "Not allowed to run on production" unless Rails.env.development?
    system("rake db:drop")
    system("rake db:create")
    system("rake db:migrate")
    sleep 2
    system("rake db:seed")
  end
end
