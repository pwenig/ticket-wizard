require "rails_helper"

RSpec.describe Attend, type: :model do 

  it "belongs to an attendee" do
    should belong_to(:attendee)
  end

  it "belongs to an attended event" do
    should belong_to(:attended_event)
  end
end 