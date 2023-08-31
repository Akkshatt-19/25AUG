class User < ApplicationRecord
	require "securerandom"
	has_secure_password
	has_one_attached :profile_picture
 	has_many :posts,dependent: :destroy
	has_many :comments,dependent: :destroy
	has_many :likes,dependent: :destroy
	validates :fname, length: { minimum: 2 ,message: "Please Enter First-name Carefully !!!"}
	validates :lname, length: { minimum: 2 ,message: "Please Enter Last-name Carefully !!!"}
	# validates :password, length: { in: 6..20 ,message: "Please check password,It must contain atleast 6-20 letters !!!"}
	validates :email, format: {  with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "Please Enter Valid Email" },uniqueness: true
	
	has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
	has_many :followees, through: :followed_users
	has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
	has_many :followers, through: :following_users
	
	
	has_many :blocked_users, foreign_key: :blocker_id, class_name: 'Block'
	has_many :blockeds, through: :blocked_users
	has_many :blocking_users, foreign_key: :blocked_id, class_name: 'Block'
	has_many :blockers, through: :blocking_users
	
end
