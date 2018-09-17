require "rails_helper"

RSpec.describe 'Comments', type: :feature do 
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:user2) { create(:user)}
  let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user2.id) }
 
  it 'should create a comment' do 
    sign_in_user(user)
    visit events_path
    expect(page.text).to include('Folk Festival')
    click_on 'Folk Festival'
    fill_in('comment_body', with: 'This is going to be great!')
    click_on 'Submit'
    expect(page.text).to include('This is going to be great!')
  end 

  it 'should delete a comment' do 
    sign_in_user(user)
    visit events_path
    expect(page.text).to include('Folk Festival')
    click_on 'Folk Festival'
    fill_in('comment_body', with: 'This is going to be great!')
    click_on 'Submit'
    visit event_path(upcoming_event.id)
    expect(page.text).to include('This is going to be great!')
    click_on 'Delete'
    visit event_path(upcoming_event.id)
    expect(page.text).to_not include('This is going to be great!')
  end 

end 