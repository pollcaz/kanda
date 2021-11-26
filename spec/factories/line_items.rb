FactoryBot.define do
  factory :line_item do
    quantity { (1..10).to_a.sample }
    amount { rand(100..1000) }
    order
    
    before(:create) do |line_item|
      order ||= create(:order)
    end

    after(:create) do |line_item|
      order = line_item.order
      order.reload
      order.recalculate!
    end
  end
end