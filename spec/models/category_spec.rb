
require "rails_helper"

RSpec.describe Category, type: :model do 

  it "has many events" do 
    should have_many(:events)
  end 
end 