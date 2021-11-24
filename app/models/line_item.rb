class LineItem < ApplicationRecord
  belongs_to :order #, class_name: 'Order', foreign_key: :order_id
  validates :order_id, :quantity, :amount, presence: true
end
