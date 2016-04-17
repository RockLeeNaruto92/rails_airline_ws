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
end
