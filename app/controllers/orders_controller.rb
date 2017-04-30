class OrdersController < ApplicationController
  def new

  end

  def show
    @orders = Order.find(params[:id])
  end

  def create
    @orders = Order.new(order_params)
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
end

