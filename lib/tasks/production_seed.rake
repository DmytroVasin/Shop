namespace :db do
  desc "Set default data for production"
  task production_seed: :environment do
    if Rails.env.production?
    # if Rails.env.development?
      load "#{Rails.root}/db/seeds/admins.rb"
      add_admin
    end
  end
end