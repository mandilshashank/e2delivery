require 'httparty'

class OrdersController < ApplicationController
  def new
    session[:order_params] ||= {}
    @order = Order.new(session[:order_params])
    @order.current_step = session[:order_step]
  end

  def show
    @orders = Order.find(params[:id])
  end

  def create
    if not defined?(@order)
      session[:order_params] ||= {}
      @order = Order.new(session[:order_params])
      @order.current_step = session[:order_step]
    end

    session[:order_params].deep_merge!(params[:orders]) if params[:orders]
    @order = Order.new(session[:order_params])
    @order.current_step = session[:order_step]


    # Todo: Before saving the order redirect to payment page. Compute payment using the pick up and delivery zip codes
    delivery_fee = ""
    if params[:orders] && params[:orders]["pickup_zip"] && params[:orders]["delivery_zip"]
      begin
        distance = OrdersController.get_distance(params[:orders]["pickup_zip"], params[:orders]["delivery_zip"])
        distance_float = distance.gsub(" mi","").to_f
        no_items = 2
        delivery_fee = (25 + distance_float) * 100
      rescue
        delivery_fee = 30 * 100
      end
    else
      delivery_fee = 30 * 100
    end

    if @order.valid?
      if params[:back_button]
        @order.previous_step
      elsif @order.last_step?
        @order.save if @order.all_valid?
      else
        @order.next_step
      end
      session[:order_step] = @order.current_step
    end
    if @order.new_record?
      render "new"
    else
      session[:order_step] = session[:order_params] = nil
      flash[:notice] = "Order saved!"
      redirect_to controller: 'charges', action: 'new', a: delivery_fee
    end
  end

  def self.get_distance(pzip, dzip)
    google_api = Rails.application.config.google_api_key
    url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + pzip +
        '&destinations=' + dzip + '&mode=driving&sensor=false&units=imperial&key=' + google_api
    response = HTTParty.get(url)
    distance = response.parsed_response["rows"][0]["elements"][0]["distance"]["text"]
    return distance
  end

  private
    def order_params
      params.require(:orders).permit(:company_name, :account_num, :first_name, :last_name, :phone, :company_email,
                                     :pickup_address, :pickup_company, :pickup_city, :pickup_contact, :pickup_zip,
                                     :pickup_phone, :pickup_date, :pickup_time, :delivery_address, :delivery_company,
                                     :delivery_city, :delivery_contact, :delivery_zip, :delivery_phone, :delivery_date,
                                     :delivery_time)
    end
end

