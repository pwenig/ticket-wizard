require "rails_helper"

RSpec.describe "Event Dashboard", type: :feature do
  let(:category1) { create(:category) }
  let(:category2) { create(:category, name: "Art") }
  let(:user) { create(:user) }
  let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category1.id, user_id: user.id) }

  before do
    sign_in_user(user)
    visit event_dashboard_index_path(upcoming_event, key: upcoming_event.event_guid)
  end

  it "should show event dashboard page" do 
    expect(page.text).to include("#{upcoming_event.title} Dashboard")
  end

end 