require 'spec_helper'

describe ParserController do

  describe "GET 'sixpm'" do
    it "returns http success" do
      get 'sixpm'
      response.should be_success
    end
  end

end
