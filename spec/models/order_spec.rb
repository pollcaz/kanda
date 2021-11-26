require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:subject) { described_class.new }

  context 'When it is instantiated' do
    it 'has a subtotal' do
      expect(subject.subtotal).to be_nil
    end

    it 'has a tax' do
      expect(subject.tax).to be_nil
    end

    it 'has a total' do
      expect(subject.total).to be_nil
    end
  end

  context 'when it is saved' do
    before { subject.save }

    it 'has a subtotal equal to 0' do
      expect(subject.subtotal).to eq(0)
    end

    it 'has a tax equal to 0.0' do
      expect(subject.tax).to eq(0.0)
    end

    it 'has a total equal to 0.0' do
      expect(subject.total).to eq(0.0)
    end
  end

  describe '#recalculate!' do
    it 'recalculates the order values based on its line_items values' do
      order = Order.new
      order.save
      hash_values = { quantity: 1, amount: 1000, order: order }   
      line_items = create_list(:line_item, 2, hash_values)

      order.update_attribute(:subtotal, 0)
      expect(order.reload.subtotal).to eq(0)
      
      order.recalculate!
      expect(order.subtotal).to eq(2000)
    end
  end
end
