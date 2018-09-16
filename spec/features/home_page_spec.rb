# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home Page", type: :feature do
  it "visits root path" do
    visit("/")
    expect(current_path).to eq(root_path)
  end
end
