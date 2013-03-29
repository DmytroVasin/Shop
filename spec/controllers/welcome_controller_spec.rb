require 'spec_helper'

describe WelcomeController do
  #def setup
  #  @controller = PostController.new
  #end

  describe 'GET index page' do
    it 'returns http success' do
      get :index
      response.should be_success
    end

    it 'something do'
    it 'something do_not'
  end
end
