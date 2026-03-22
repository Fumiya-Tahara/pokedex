require "rails_helper"

RSpec.describe PokemonType, type: :model do
  describe "バリデーション" do
    context "slotが空の場合" do
      it "無効である" do
        pokemon_type = described_class.new(slot: nil)
        expect(pokemon_type).not_to be_valid
        expect(pokemon_type.errors[:slot]).to include("can't be blank")
      end
    end

    context "slotが1未満の場合" do
      it "無効である" do
        pokemon_type = described_class.new(slot: 0)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "slotが3以上の場合" do
      it "無効である" do
        pokemon_type = described_class.new(slot: 3)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "同じpokemonに同じslotが重複している場合" do
      it "無効である" do
        pokemon = Pokemon.create!(name: "フシギダネ", national_number: 1, height: 0.7, weight: 6.9)
        type1 = Type.create!(name: "くさ")
        type2 = Type.create!(name: "どく")
        described_class.create!(pokemon: pokemon, type: type1, slot: 1)
        pokemon_type = described_class.new(pokemon: pokemon, type: type2, slot: 1)
        expect(pokemon_type).not_to be_valid
        expect(pokemon_type.errors[:slot]).to include("has already been taken")
      end
    end

    context "pokemon_idが空の場合" do
      it "無効である" do
        pokemon_type = described_class.new(pokemon: nil)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "type_idが空の場合" do
      it "無効である" do
        pokemon_type = described_class.new(type: nil)
        expect(pokemon_type).not_to be_valid
      end
    end
  end

  describe "アソシエーション" do
    it "pokemonに属する" do
      association = described_class.reflect_on_association(:pokemon)
      expect(association.macro).to eq(:belongs_to)
    end

    it "typeに属する" do
      association = described_class.reflect_on_association(:type)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
