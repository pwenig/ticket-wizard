require "rails_helper"

RSpec.describe Event, type: :model do
let(:category) {create(:category)}
let(:user) {create(:user)}
let!(:upcoming_event) {create(:event, title: 'Folk Festival', date: "#{Time.now + 2.week.to_i}", category_id: category.id, user_id: user.id)}
let!(:past_event) { create(:event, title: 'Rock Festivall', date: "#{Time.now - 2.week.to_i}", category_id: category.id, user_id: user.id) }

  it 'creates an event' do 
    expect(upcoming_event.title).to eq('Folk Festival')
  end 

  it 'belongs to a user' do 
    should belong_to(:user)
  end 

  it 'should have many passive_attends' do 
    should have_many(:passive_attends)
  end 

  it 'should have many attendees' do 
    should have_many(:attendees)
  end 

  it 'should have many comments' do 
    should have_many(:comments)
  end

  it 'should validate :title required' do 
    should validate_presence_of(:title)
  end 

  it 'should validate :description required' do
    should validate_presence_of(:description)
  end 

  it 'should validate :address required' do
    should validate_presence_of(:address)
  end 

  it 'should validate :category_id required' do
    should validate_presence_of(:category_id)
  end 

  it 'should return a list of upcoming events' do 
    results = Event.upcoming
    event_titles = results.pluck(:title)
    expect(event_titles).to include(upcoming_event.title)
    expect(event_titles).to_not include(past_event.title)
  
  end 

end 

