# frozen_string_literal: true

require "rails_helper"

RSpec.feature "User Signup", type: :feature do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:ops) { create(:user, ops: true)}
  # let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user2.id) }
  let!(:attending_event) { create(:event, :attendees, title: "Jazz Festival", date: "#{Time.now + 1.week.to_i}", category_id: category1.id, user_id: user.id) }

  it "should create a new user" do
    visit signup_path
    fill_in("user_name", with: "Test User")
    fill_in("user_email", with: "test@test.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    click_on "submit"
    user = User.last
    expect(current_path).to eq(user_path(user.id))
  end

  it "should display error with incomplete user profile" do
    visit signup_path
    fill_in("user_name", with: "")
    fill_in("user_email", with: "test@test.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    click_on "submit"
    expect(page.text).to include("The form contains 1 error")
  end

  it "should allow a user to login with valid email/password" do
    sign_in_user(user)
    expect(current_path).to eq(user_path(user))
  end

  it "should show not allow a user to login with invalid email/password" do
    invalid_user = user
    User.last.destroy!
    sign_in_user(invalid_user)
    expect(page.text).to include("Invalid Email or Password")
  end

  it "should log a user out" do
    sign_in_user(user)
    click_on "signout_link"
    expect(current_path).to eq(root_path)
  end

  it "should edit a user profile" do
    sign_in_user(user)
    visit edit_user_path(user.id)
    expect(page.text).to include("Edit Account")
    fill_in("user_name", with: "Test User Update")
    click_on "submit"
    expect(page.text).to include("Updated Successfully")
  end

  it "should edit stripe keys for an admin user" do 
    user.update(admin: true)
    sign_in_user(user)
    visit edit_user_path(user.id)
    expect(page.text).to include("Stripe Publishable Key")
    expect(page.text).to include("Stripe Secret Key")
    expect(page.text).to include("Edit Admin Account")
  end 

  it "should display error with incomplete user profile" do
    sign_in_user(user)
    visit edit_user_path(user.id)
    expect(page.text).to include("Edit Account")
    fill_in("user_name", with: "")
    click_on "submit"
    expect(page.text).to include("The form contains 1 error")
  end

  it "should not show the Admin link" do 
    sign_in_user(user)
    expect(page.text).to_not include('Admin')
  end 

  it "should show the Admin link" do 
    sign_in_user(ops)
    expect(page.text).to include('Admin')
  end 
end
