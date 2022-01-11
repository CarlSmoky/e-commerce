class User < ActiveRecord::Base
  
  has_secure_password 
  
  validates_uniqueness_of :email
  validates :password, length: {minimum: 6}, presence: true
  validates :password_confirmation, length: {minimum: 6}, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
 
  

end
