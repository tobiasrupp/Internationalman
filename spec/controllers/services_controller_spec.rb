require 'spec_helper'

describe ServicesController do

  describe "GET 'get_facebook_items_to_refresh'" do
    it "returns http success" do
      get 'get_facebook_items_to_refresh'
      response.should be_success
    end
  end

  describe "GET 'refresh_facebook_data_remote'" do
    it "returns http success" do
      get 'refresh_facebook_data_remote'
      response.should be_success
    end
  end

  describe "GET 'refresh_facebook_item'" do
    it "returns http success" do
      get 'refresh_facebook_item'
      response.should be_success
    end
  end

end
