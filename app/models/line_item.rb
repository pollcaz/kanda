class LineItem < ApplicationRecord
  belongs_to :order
  validates :quantity, :amount, presence: true

  after_save :do_recalculate_order

  private
  
  def do_recalculate_order
    order = self.order
    order.reload
    order.recalculate!
  end 
end
