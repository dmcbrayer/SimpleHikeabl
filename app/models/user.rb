class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  #has_many :created_trips
  #has_and_belongs_to_many :trips

  has_many :trips, :foreign_key => :user_id

  has_many :invitations, :foreign_key => :attendee_id
  has_many :attended_trips, :through => :invitations

  before_save { self.email = email.downcase}

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: {case_sensitive: false}


  

  has_attached_file :avatar, 
  	:styles => { 
  		:header => "24x24#", 
  		:small => "52x52#", 
  		:medium => "300x300#", 
  		:thumb => "100x100#" }, 
  		:default_url => "/images/default_user_:style.jpg"
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


end
