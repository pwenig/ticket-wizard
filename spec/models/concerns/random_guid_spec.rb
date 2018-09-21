# frozen_string_literal: true

require "rails_helper"

RSpec.describe RandomGuid, type: :concern do
  let(:sample_class) do
    class Foobaz
      include ActiveModel::Model
      include RandomGuid
    end
  end

  describe "Structure" do
    it { is_expected.to be_an ActiveSupport::Concern }
  end

  describe "#create_guid" do
    let(:model) { sample_class.new }
    it "generates a random guid" do
      regex = /^[a-zA-Z0-9]{0,8}$/
      result = model.create_guid
      expect(result).to match(regex)
    end
  end
end
