require "administrate/base_dashboard"

class TicketDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    event: Field::BelongsTo,
    purchased_tickets: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    price: Field::String.with_options(searchable: false),
    qty_available: Field::Number,
    description: Field::Text,
    onsale_start: Field::DateTime,
    onsale_end: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :event,
    :purchased_tickets,
    :id,
    :title,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :event,
    :purchased_tickets,
    :id,
    :title,
    :price,
    :qty_available,
    :description,
    :onsale_start,
    :onsale_end,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :event,
    :purchased_tickets,
    :title,
    :price,
    :qty_available,
    :description,
    :onsale_start,
    :onsale_end,
  ].freeze

  # Overwrite this method to customize how tickets are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(ticket)
    ticket.title
  end

  
end
