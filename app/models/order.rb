class Order < ApplicationRecord
  has_many :line_items, dependent: :delete_all
  accepts_nested_attributes_for :line_items
  
  validates :subtotal, :tax, :total, presence: true

  before_validation :calc_subtotal, :calc_tax, :calc_total

  TAX_ORDER = 0.08.freeze

  def recalculate!
    calc_subtotal
    calc_tax
    calc_total
    save!
  end

  protected

  def calc_subtotal
    self.subtotal = line_items.map {|li| li.quantity.to_i * li.amount.to_i }.reduce(&:+).to_i
  end

  def calc_tax
    self.tax = self.subtotal * TAX_ORDER
  end

  def calc_total
    self.total = self.subtotal + self.tax
  end
end
