class Pokemon < ApplicationRecord
  has_many :pokemon_types, dependent: :destroy
  has_many :types, through: :pokemon_types

  validates :name, presence: true
  validates :national_number, presence: true, uniqueness: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }
end
