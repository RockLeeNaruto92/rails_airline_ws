class Constract < ActiveRecord::Base
  before_save :initialize_total_money, :decrease_flight_available_seats

  belongs_to :flight

  validates :flight, presence: true
  validates :customer_id_number, presence: true
  validates :company_name, presence: true
  validates :company_phone, presence: true
  validates :company_address, presence: true

  validate :booking_seats_validation

  private
  def booking_seats_validation
    return unless flight.present?
    case
    when !booking_seats.is_a?(Integer)
      errors.add :booking_seats, message: I18n.t("errors.not_integer")
    when booking_seats < 1
      errors.add :booking_seats,
        message: I18n.t("errors.greater_than", number: 0)
    when booking_seats > self.flight.available_seats
      errors.add :booking_seats,
        message: I18n.t("errors.less_than_attr", attr: "available_seats")
    end
  end


  def initialize_total_money
    self.total_money = flight.cost * booking_seats
  end

  def decrease_flight_available_seats
    self.flight.update! available_seats: (flight.available_seats - booking_seats)
  end
end
