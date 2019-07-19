class User < ApplicationRecord
	has_secure_password
	has_many :mss
	validates :name, presence: true, length: { in: 4..20 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
	validates :password, presence: true, length: { in: 2..50 }, on: :create
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
