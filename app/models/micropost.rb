# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :content

  # ------------------- VALIDATION ------------------- #
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 140 }


  # ------------------- ACTIVE RECORD CONFIGURATION ------------------- #
  belongs_to :user
  default_scope :order => "microposts.created_at DESC"

  scope :from_users_followed_by, lambda { |user| followed_by(user) }


  private

    def self.followed_by(user)
      followed_ids = %(SELECT followed_id
                       FROM relationships
                       WHERE follower_id = :user_id)

      where("user_id IN (#{ followed_ids }) OR user_id = :user_id", { :user_id => user })
    end
end
