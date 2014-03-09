namespace :db do
  desc "Set default data for production"
  task production_seed: :environment do
    # if Rails.env.production?
    if Rails.env.development?
      load "#{Rails.root}/db/seeds/admins.rb"
      load "#{Rails.root}/db/seeds/categories.rb"
      load "#{Rails.root}/db/seeds/gender.rb"

      include Seeds
      add_admin
      create_categories
      add_gender
    end
  end
end