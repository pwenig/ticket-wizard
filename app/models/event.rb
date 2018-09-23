# frozen_string_literal: true

class Event < ActiveRecord::Base
  include RandomGuid

  default_scope -> { order(date: :asc) }
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :tickets, dependent: :destroy
  has_many :passive_attends, class_name: "Attend", foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :passive_attends, source: :attendee
  has_many :comments, dependent: :destroy
  validates_presence_of :title, length: { maximum: 100 }
  validates_presence_of :description, length: { maximum: 1000 }
  validates_presence_of :address
  validates_presence_of :category_id
  validate :picture_size
  validate :event_date
  before_save :normalize_title
  before_save :exclude_united_states_text_from_address
  # geocoded_by :address
  # before_save :geocode, if: :address_changed?
  before_create :generate_guid

  def self.upcoming
    Event.where("date > ?", Time.now)
  end

  def self.past
    Event.where("date < ?", Time.now)
  end

  def self.user_created_events(user)
    Event.where(user_id: user.id)
  end

  def self.user_events(user)
    Event.all.select { |x| x.attendees.include?(user) }
  end

  # def self.featured(visitor_latitude, visitor_longitude)
  #   Event.upcoming.near([visitor_latitude, visitor_longitude], 20).limit(6)
  # end

  def has_valid_date?
    if self.date
      self.date < Time.now.advance(days: 1) ? false : true
    end
  end

  def self.search(params)
    params[:category].to_i != 0 ? events = Event.where(category_id: params[:category].to_i) : events = Event.all
    events = events.where("lower(title) LIKE ? or lower(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search.downcase].downcase}%") if params[:search].present?
    events = events.near(params[:location], 30) if params[:location].present?
    params[:timeline] == "Past Events" ? events.past : events.upcoming
  end

private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def event_date
    if !has_valid_date?
      errors.add(:date, "must be 1 or more days ahead from now")
    end
  end

  def normalize_title
    self.title = title.downcase.titleize
  end

  def exclude_united_states_text_from_address
    self.address = address.gsub!(/(united states)/i, " ").strip!.chomp!(",") if address.downcase.include?("united states")
  end

  def generate_guid
    self.event_guid = create_guid
  end
end
