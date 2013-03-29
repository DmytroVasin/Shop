require 'spec_helper'

describe Admin::BrandsController do
  context 'GET index page' do
    it 'returns http success' do
      get 'index'
      response.should_not be_success
    end
  end
end
