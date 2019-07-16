class Mss < ApplicationRecord
  belongs_to :user
  validates :messages, length: { in: 2..80 }, on: :create
end
