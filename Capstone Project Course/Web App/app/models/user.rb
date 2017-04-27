class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :logs
  belongs_to :event, optional: true
  belongs_to :booked_hour, optional: true
  has_many :user_programs
  has_many :programs, through: :user_programs

  validates :email, :presence => true, :email => true
  
 # def create
 #   # Create the user from params
 #   @user = User.new(params[:user])
 #   if @user.save
 #     # Deliver the signup email
 #     ApplicationMailer.send_signup_email(@user).deliver
 #     redirect_to(@user, :notice => 'User created')
 #   else
 #     render :action => 'new'
 #   end
 # end

end
