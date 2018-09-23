# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Event Attending", type: :feature do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user2.id) }

  it "should attend an event" do
    sign_in_user(user)
    visit event_path(upcoming_event, key: upcoming_event.event_guid)
    click_on "Attend Event"
    expect(page.text).to include("Confirmed.")
    expect(page.text).to include ("Events You're Attending")
    expect(page.text).to include("Folk Festival")
  end

  it "should unattend an event" do
    sign_in_user(user)
    visit event_path(upcoming_event, key: upcoming_event.event_guid)
    click_on "Attend Event"
    expect(page.text).to include("Confirmed.")
    expect(page.text).to include ("Events You're Attending")
    expect(page.text).to include("Folk Festival")
    click_on "Folk Festival"
    click_on "Unattend Event"
    expect(page.text).to include("Confirmed. You are no longer attending Folk Festival")
    expect(page.text).to_not include ("Events You're Attending")
    visit user_path(user.id)
    expect(page.text).to_not include("Folk Festival")
  end
end
