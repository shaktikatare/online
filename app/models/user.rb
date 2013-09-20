class User < ActiveRecord::Base
  attr_accessible :city, :country, :email, :encrypted_password, :first_name, :is_admin, :last_name, :phone, :state
  validates :city, :country, :email, :encrypted_password, :first_name, :last_name, :phone, :state, presence: true
  validates :phone, numericality: { only_integer: true }
  validates :email, uniqueness: true
  #validates :first_name,
   #:format     => { :with => /^[a-zA-Z\d\s]*$/ }
  validates :phone, length: { is: 10 }
end
