# frozen_string_literal: true

class Pokemon < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, :type_1, presence: true
  validates :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, numericality: { only_integer: true }, presence: true
  validates :legendary, inclusion: { in: [true, false] }
end
