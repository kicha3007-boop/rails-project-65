class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end
end
