# frozen_string_literal: true

class Pokemon < ApplicationRecord
  validates_uniqueness_of :name
end
