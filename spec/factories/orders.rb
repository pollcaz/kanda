FactoryBot.define do
  factory :order do
    subtotal { 0 }
    tax { 0.0 }
    total { 0.0 }

    # after(:create) do |order|
    #   line_items = [create(:line_item, order_id: order.id), create(:line_item, order_id: order.id)]
    #   order.subtotal = line_items.map { |li| li.quantity * li.amount }.reduce(&:+)
    #   order.tax = order.subtotal * Order::TAX_ORDER
    #   order.total = order.subtotal + order.tax
    #   order.save
    # end
  end
end

#line_items_attributes = [{quantity: 2 , amount: 4 }] * 4
# order1 = Order.new(line_items_attributes: line_items_attributes)
# order1.send(:calc_subtotal)
# order1.send(:calc_tax)
# order1.send(:calc_total)
# order1.valid?