require 'httparty'

class OrdersController < ApplicationController
  def new
  end

  def show
    @orders = Order.find(params[:id])
  end

  def create
    @orders = Order.new(order_params)

    #Todo: Before saving the order redirect to payment page. Compute payment using the pick up and delivery zip codes
    distance = get_distance(:pickup_zip, :delivery_zip)
    distance_float = distance.gsub(" mi","").to_float

    @orders.save
    redirect_to @orders
  end

  private
    def order_params
      params.require(:orders).permit(:company_name, :account_num, :first_name, :last_name, :phone, :company_email,
                                     :pickup_address, :pickup_company, :pickup_city, :pickup_contact, :pickup_zip,
                                     :pickup_phone, :pickup_date, :pickup_time, :delivery_address, :delivery_company,
                                     :delivery_city, :delivery_contact, :delivery_zip, :delivery_phone, :delivery_date,
                                     :delivery_time)
    end

    def self.get_distance(pzip, dzip)
      google_api = Rails.application.config.google_api_key
      url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + pzip + '&destinations=' + dzip +
          '&mode=driving&sensor=false&units=imperial&key=' + google_api
      response = HTTParty.get(url)
      distance = response.parsed_response["rows"][0]["elements"][0]["distance"]["text"]
      return distance
    end
end

