require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:order) { create(:order) }
  let(:hash_values) { { quantity: 1, amount: 1000, order: order } } 
  let(:subject) { described_class.new(hash_values) }

  context 'validations' do
    context 'when sets all attributes required' do
      it { is_expected.to be_valid }
    end

    context 'when an attribute required is not set' do
      context 'when missing to set the order_id' do
        let(:order) { nil }
        it 'is not a valid record' do
          expect(subject.valid?).to be_falsy
          expect(subject.errors.messages[:order].first).to eq('must exist')
        end
      end

      context 'when quantity is missing' do
        let(:hash_values) { { amount: 1000, order: order } }
        it 'is not a valid record' do
          expect(subject.valid?).to be_falsy
          expect(subject.errors.messages[:quantity].first).to eq('can\'t be blank')
        end
      end

      context 'when amount is missing' do
        let(:hash_values) { { quantity: 1, order: order } }
        it 'is not a valid record' do
          expect(subject.valid?).to be_falsy
          expect(subject.errors.messages[:amount].first).to eq('can\'t be blank')
        end
      end
    end
  end

  context 'when creates a record' do
    it 'updates its respective order\'s values' do
      expect(subject.save).to be_truthy
      order.reload
      expect(order.line_items.size).to eq(1)
      expect(order.subtotal).to eq(1000)
      expect(order.tax).to eq(80.0)
      expect(order.total).to eq(1080)
    end
  end
end
