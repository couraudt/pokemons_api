# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon do
  it 'validate uniqueness of name' do
    create(:pokemon)
    expect(build_stubbed(:pokemon)).to_not be_valid
  end
end
