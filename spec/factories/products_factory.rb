FactoryGirl.define do
  factory :product do
    name 'Ticketee'
  end
end

# FactoryGirl.define do
#  factory :user do
#    sequence(:nickname) { |n| "user_#{n}" }
#    sequence(:email) { |n| "email_#{n}@email.com" }
#    first_name 'Test'
#    last_name 'User'
#    password '123456'
#    password_confirmation '123456'

#    factory :reader_user do
#      role 'reader'
#    end

#    factory :admin_user do
#      role 'admin'
#    end

#    factory :moderator_user do
#      role 'moderator'
#    end
#  end
# end

#   @user = FactoryGirl.create :reader_user
#   @admin = FactoryGirl.create :admin_user
#   @moderator = FactoryGirl.create :moderator_user