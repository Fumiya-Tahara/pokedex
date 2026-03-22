require "rails_helper"

RSpec.describe PokemonType, type: :model do
  describe "バリデーション" do
    context "slotが空の場合" do
      it "無効である" do
        pokemon_type = build(:pokemon_type, slot: nil)
        expect(pokemon_type).not_to be_valid
        expect(pokemon_type.errors[:slot]).to include("can't be blank")
      end
    end

    context "slotが1未満の場合" do
      it "無効である" do
        pokemon_type = build(:pokemon_type, slot: 0)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "slotが3以上の場合" do
      it "無効である" do
        pokemon_type = build(:pokemon_type, slot: 3)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "同じpokemonに同じslotが重複している場合" do
      it "無効である" do
        pokemon = create(:pokemon)
        type1 = create(:type)
        type2 = create(:type)
        create(:pokemon_type, pokemon: pokemon, type: type1, slot: 1)
        pokemon_type = build(:pokemon_type, pokemon: pokemon, type: type2, slot: 1)
        expect(pokemon_type).not_to be_valid
        expect(pokemon_type.errors[:slot]).to include("has already been taken")
      end
    end

    context "pokemon_idが空の場合" do
      it "無効である" do
        pokemon_type = build(:pokemon_type, pokemon: nil)
        expect(pokemon_type).not_to be_valid
      end
    end

    context "type_idが空の場合" do
      it "無効である" do
        pokemon_type = build(:pokemon_type, type: nil)
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
