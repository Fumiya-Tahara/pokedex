require "rails_helper"

RSpec.describe Type, type: :model do
  describe "バリデーション" do
    context "nameが空の場合" do
      it "無効である" do
        type = described_class.new(name: nil)
        expect(type).not_to be_valid
        expect(type.errors[:name]).to include("can't be blank")
      end
    end

    context "nameが重複している場合" do
      it "無効である" do
        described_class.create!(name: "ほのお")
        type = described_class.new(name: "ほのお")
        expect(type).not_to be_valid
        expect(type.errors[:name]).to include("has already been taken")
      end
    end

    context "nameが正しい場合" do
      it "有効である" do
        type = described_class.new(name: "ほのお")
        expect(type).to be_valid
      end
    end
  end

  describe "アソシエーション" do
    it "pokemon_typesを複数持てる" do
      association = described_class.reflect_on_association(:pokemon_types)
      expect(association.macro).to eq(:has_many)
    end

    it "pokemonsをpokemon_typesを経由して持てる" do
      association = described_class.reflect_on_association(:pokemons)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:pokemon_types)
    end
  end
end
