require "action_view"

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = ["Black", "White", "Gray", "Orange", "Calico"].freeze
  validates :name, :description, :birth_date, presence: true
  validates :color, presence: true, inclusion: { in: CAT_COLORS, message: "is not a valid color" }
  validates :sex, presence: true, inclusion: { in: ["M", "F"], message: "must be 'M' or 'F'" }

  validate :birth_date_cannot_be_future, on: :create

  def birth_date_cannot_be_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

  def age
    time_ago_in_words(self.birth_date)
  end
end