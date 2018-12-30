require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    tickets: Field::HasMany,
    purchased_tickets: Field::HasMany,
    comments: Field::HasMany,
    orders: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::String,
    date: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    picture: Field::String,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    address: Field::String,
    category_id: Field::Number,
    event_guid: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :title,
    :date,
    :address,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :tickets,
    :purchased_tickets,
    :comments,
    :orders,
    :id,
    :title,
    :description,
    :date,
    :created_at,
    :updated_at,
    :picture,
    :latitude,
    :longitude,
    :address,
    :category_id,
    :event_guid,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :tickets,
    :purchased_tickets,
    :comments,
    :orders,
    :title,
    :description,
    :date,
    :picture,
    :latitude,
    :longitude,
    :address,
    :category_id,
    :event_guid,
  ].freeze

  # Overwrite this method to customize how events are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(event)
    event.title
  end
end
