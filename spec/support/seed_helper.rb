module SeedHelpers
  def create_user!
    user = FactoryGirl.create(:user)
    user.confirm!
    user
  end
end
