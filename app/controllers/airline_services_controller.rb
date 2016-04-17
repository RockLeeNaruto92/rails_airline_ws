class AirlineServicesController < ApplicationController
  soap_service namespace: "urn:airline_ws", wsdl_style: "document"

  soap_action "check_available_flight",
    args: {check_available_flight_request: {flightId: :integer, bookingSeats: :integer}},
    return: {result: :integer}

  def check_available_flight
    flight_params = params[:check_available_flight_request]
    flight_params["flightId"] ||= 0
    flight_params["bookingSeats"] ||= 1
    condition = "id = #{flight_params["flightId"]} and available_seats > #{flight_params["bookingSeats"]}"
    flights = Flight.where condition
    render soap: {result: flights.empty? ? 0 : 1}
  end

  soap_action "add_new_constract",
    args: {add_new_constract_request: {
      flightId: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingSeats: :integer}},
    return: {result: :integer}

  def add_new_constract
    params = get_constract_params

    constract = Constract.new standarlize_params params
    messages = constract.save ? constract.id : -1
    render soap: {result: messages}
  end

  private
  def standarlize_params params
    params.keys.each do |key|
      unless key.to_s == key.to_s.underscore
        params[key.to_s.underscore.to_sym] = params[key]
        params.delete key
      end
    end
    params
  end

  def get_constract_params
    params[:add_new_constract_request]
  end
end
