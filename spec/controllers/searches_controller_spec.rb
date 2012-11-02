require 'spec_helper'

describe SearchesController do

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end

  describe "GET 'rebuild_search_index'" do
    it "returns http success" do
      get 'rebuild_search_index'
      response.should be_success
    end
  end

end
