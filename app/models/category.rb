class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
end
