class AirlineServicesController < ApplicationController
  soap_service namespace: "urn:airline_ws", wsdl_style: "document"

  soap_action "add_new_constract",
    args: {add_new_constract_request: {
      flightId: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingSeats: :integer}},
    return: {result: :string}

  def add_new_constract
    params = get_constract_params

    constract = Constract.new standarlize_params params
    messages = constract.save ? I18n.t("action.success") : constract.errors.full_messages
    render soap: {result: messages}
  end

  soap_action "check_available_flight",
    args: {check_available_flight_request: {flightCode: :string}},
    return: {result: :string}

  def check_available_flight
    if params[:check_available_flight_request] && params[:check_available_flight_request][:flightCode].present?
      flight = Flight.find_by code: params[:check_available_flight_request][:flightCode]
      render soap: {result: (flight.present? && flight.available_seats > 0).to_s}
    else
      render soap: {result: I18n.t("errors.param_not_present", param: "flightCode")}
    end
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
