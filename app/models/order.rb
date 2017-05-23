class Order < ApplicationRecord
  attr_writer :current_step

  validates :company_name, :first_name, :last_name, :phone, :company_email,
            :pickup_address, :pickup_city, :pickup_contact, :pickup_zip,
            :pickup_phone, :pickup_date, :pickup_time, :delivery_address,
            :delivery_city, :delivery_contact, :delivery_zip, :delivery_phone, :delivery_date,
            :delivery_time, presence: true

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[main payment]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
