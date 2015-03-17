class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :images
  has_many :sharedImages
  has_many :images, through: :sharedImages
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def full_name
  	 "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
