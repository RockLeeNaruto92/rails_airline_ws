class Flight < ActiveRecord::Base
  before_create :initialize_available_seats

  belongs_to :airline
  has_many :constracts

  validates :code, presence: true, uniqueness: true
  validates :airline_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :seats, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :cost, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :in_out_time_validation

  private
  def in_out_time_validation
    return unless start_time.present? && end_time.present?

    if start_time > end_time
      errors.add :start_time,
        message: I18n.t("errors.less_than_attr", attr: "end_time")
    end
  end

  def initialize_available_seats
    self.available_seats = seats
  end
end
