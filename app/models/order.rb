class Order < ApplicationRecord
  attr_writer :current_step

  validates :company_name, :first_name, :last_name, :phone, :company_email,
            :pickup_address, :pickup_city, :pickup_contact, :pickup_zip,
            :pickup_phone, :pickup_date, :pickup_time, :delivery_address,
            :delivery_city, :delivery_contact, :delivery_zip, :delivery_phone, :delivery_date,
            :delivery_time, presence: true

  # Validate phone numbers
  validates :pickup_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "should be in xxx-xxx-xxxx format" }
  validates :delivery_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "should be in xxx-xxx-xxxx format" }
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "should be in xxx-xxx-xxxx format" }

  # Email regex /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :company_email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "invalid email" }

  # Pickup date cannot be less than delivery date
  validate :pick_up_date_cannot_be_before_delivery_date

  def pick_up_date_cannot_be_before_delivery_date
    if pickup_date > delivery_date
      errors.add(:pickup_date, "can't be less than delivery date")
    end
  end

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
