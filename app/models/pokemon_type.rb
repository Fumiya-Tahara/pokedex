class PokemonType < ApplicationRecord
  belongs_to :pokemon
  belongs_to :type

  validates :slot, presence: true, numericality: { in: 1..2 }
  validates :slot, uniqueness: { scope: :pokemon_id }
end
