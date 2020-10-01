# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon do
  it 'validate uniqueness of name' do
    pokemon = create(:pokemon)
    expect(build_stubbed(:pokemon, name: pokemon.name)).to_not be_valid
  end

  context 'validates presence of' do
    %i[name type_1 total hp attack defense sp_atk sp_def speed generation].each do |attr|
      it "attribute #{attr}" do
        expect(build_stubbed(:pokemon, { attr => nil })).to_not be_valid
      end
    end
  end
end
