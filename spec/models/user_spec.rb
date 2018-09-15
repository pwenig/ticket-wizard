require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user, name: 'New User')}

  it 'creates a user' do
    expect(user.name).to eq('New User')
  end
  
end
