require "rails_helper"

RSpec.describe Pokemon, type: :model do
  describe "バリデーション" do
    context "nameが空の場合" do
      it "無効である" do
        pokemon = described_class.new(name: nil, national_number: 1)
        expect(pokemon).not_to be_valid
        expect(pokemon.errors[:name]).to include("can't be blank")
      end
    end

    context "national_numberが空の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: nil)
        expect(pokemon).not_to be_valid
        expect(pokemon.errors[:national_number]).to include("can't be blank")
      end
    end

    context "national_numberが重複している場合" do
      it "無効である" do
        described_class.create!(name: "フシギダネ", national_number: 1)
        pokemon = described_class.new(name: "フシギソウ", national_number: 1)
        expect(pokemon).not_to be_valid
        expect(pokemon.errors[:national_number]).to include("has already been taken")
      end
    end

    context "national_numberが0以下の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 0)
        expect(pokemon).not_to be_valid
      end
    end

    context "heightが空の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 1, height: nil, weight: 6.9)
        expect(pokemon).not_to be_valid
        expect(pokemon.errors[:height]).to include("can't be blank")
      end
    end

    context "heightが0以下の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 1, height: 0, weight: 6.9)
        expect(pokemon).not_to be_valid
      end
    end

    context "weightが空の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 1, height: 0.7, weight: nil)
        expect(pokemon).not_to be_valid
        expect(pokemon.errors[:weight]).to include("can't be blank")
      end
    end

    context "weightが0以下の場合" do
      it "無効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 1, height: 0.7, weight: 0)
        expect(pokemon).not_to be_valid
      end
    end

    context "全カラムが正しい場合" do
      it "有効である" do
        pokemon = described_class.new(name: "フシギダネ", national_number: 1, height: 0.7, weight: 6.9)
        expect(pokemon).to be_valid
      end
    end
  end

  describe "アソシエーション" do
    it "pokemon_typesを複数持てる" do
      association = described_class.reflect_on_association(:pokemon_types)
      expect(association.macro).to eq(:has_many)
    end

    it "typesをpokemon_typesを経由して持てる" do
      association = described_class.reflect_on_association(:types)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:pokemon_types)
    end
  end
end
