# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation

  # ------------------- VALIDATION ------------------- #
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:name, :presence    => true,
                   :length      => { :maximum => 50 })
  validates(:email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false })

  # Automatically create the virtual attribute called "password_confirmation"
  validates(:password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :within => 6..40 })


  # ------------------- ACTIVE RECORD CONFIGURATION ------------------- #
  has_many :microposts, :dependent => :destroy

  # Wire up to ActiveRecord's "before_save" callback...
  before_save :encrypt_password


  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      # Need to put "self" here so that we're assigning a value to this User instance's "encrypt_password"
      # attribute.  Otherwise, Ruby would just create an encrypt_password local variable, which wouldn't be useful
      # for what we want.

      # Also note that the password parameter here *is* referring to the User instance's password attribute.  Much
      # like C#, we can leave off the "self" qualifier.  However, don't forget to put the "self" qualifier on the
      # attribute to which you're assigning...
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(input)
      Digest::SHA2.hexdigest(input)
    end
end
