# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon do
  it 'validate uniqueness of name' do
    described_class.create(name: 'Pikachu')
    expect { described_class.create!(name: 'Pikachu') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
