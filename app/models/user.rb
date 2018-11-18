# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_attends, class_name: "Attend", foreign_key: "attendee_id", dependent: :destroy
  has_many :attending, through: :active_attends, source: :attended_event
  has_many :purchased_tickets, dependent: :destroy

  validates_presence_of :name, length: { maximum: 50 }
  validates_presence_of :email, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, presence: true, on: :create
  validates :password_confirmation, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, presence: true, on: :update, if: :password_digest_changed?
  validates :password_confirmation, length: { minimum: 6 }, on: :update, if: :password_digest_changed?
  before_save :normalize_name
  before_save :downcase_email

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.admin = true
    end
  end 

  # Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Adds user to attend list for event
  def attend(event)
    active_attends.create(attended_event_id: event.id)
  end

  # Removes a user from the attend list for event
  def unattend(event)
    active_attends.find_by(attended_event_id: event.id).destroy
  end

  # Returns true if the current user is attending the event
  def attending?(event)
    purchased_tickets.pluck(:event_id).include?(event.id)
  end

  # Returns user's upcoming events
  def upcoming_events
    events.where("date > ?", Time.now)
  end

  # Returns user's past events
  # UPDATE THIS TO INCLUDE PAST ATTENDED? CREATED?
  def past_events
    events.where("date < ?", Time.now)
  end

private

  # Downcase email before being saved
  def downcase_email
    self.email = email.downcase
  end

  def normalize_name
    self.name = name.downcase.titleize
  end

  # def blank_password?
  #   self.password = nil if self.password.blank?
  # end
end
