class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable




  #This shows that a user can create many trips.  the :foreign_key statement may be redundant since I'm separately saving a creator_id in the trips controller
  has_many :trips, :foreign_key => :user_id

  #this describes the relationship the user can have with other people's trips.
  has_many :invitations, :foreign_key => :attendee_id
  has_many :attended_trips, :through => :invitations

  #Validations
  validates :name, presence: true, length: {maximum: 50}
  
  #email validations
  before_save { self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: {case_sensitive: false}


  
  #statement required by paperclip.  show what images get created in the DB when an image is uploaded, and sets the default image
  has_attached_file :avatar, 
  	:styles => { 
  		:header => "24x24#", 
  		:small => "52x52#", 
  		:medium => "300x300#", 
  		:thumb => "100x100#" }, 
  		:default_url => "/images/default_user_:style.jpg"
  
  #image validation to make sure that what's being uploaded is in fact an image
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  #User Methods

  #Select all users from the database except a specified user
  def self.all_except(user)
    where.not(id: user)
  end
end
