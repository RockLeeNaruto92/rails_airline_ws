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
