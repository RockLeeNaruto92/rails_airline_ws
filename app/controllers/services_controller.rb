class ServicesController < ApplicationController
  soap_service namespace: "urn:airline_ws"

  soap_action "add_new_airline",
    args: {code: :string, name: :string, website: :string},
    return: :string

  def add_new_airline
    airline = Airline.new params
    messages = airline.save ? I18n.t("action.success") : airline.errors.full_messages
    render soap: messages
  end

  soap_action "add_new_flight",
    args: {code: :string, airlineID: :integer, startTime: :datetime,
      endTime: :datetime, startPoint: :string, endPoint: :string,
      seats: :integer, cost: :integer},
    return: :string

  def add_new_flight
    standarlize_params
    flight = Flight.new params
    messages = flight.save ? I18n.t("action.success") : flight.errors.full_messages
    render soap: messages
  end

  soap_action "is_existed_flight",
    args: {code: :string},
    return: :boolean

  def is_existed_flight
    flight = Flight.find_by code: params[:code]
    render soap: flight.present?
  end

  soap_action "find_flight_by_code",
    args: {code: :string},
    return: :string

  def find_flight_by_code
    if params[:code].present?
      flight = Flight.find_by code: params[:code]
      messages = flight.present? ? flight.to_json : I18n.t("errors.object_not_exist",
        model: "flight", attr: "code", value: params[:code])
      render soap: messages
    else
      render soap: I18n.t("errors.param_not_present", param: "code")
    end
  end

  soap_action "add_new_constract",
    args: {flightID: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingSeats: :integer},
    return: :string

  def add_new_constract
    standarlize_params
    constract = Constract.new params
    messages = constract.save ? I18n.t("action.success") : constract.errors.full_messages
    render soap: messages
  end

  private
  def standarlize_params
    params.keys.each do |key|
      unless key.to_s == key.to_s.underscore
        params[key.to_s.underscore.to_sym] = params[key]
        params.delete key
      end
    end
  end
end
