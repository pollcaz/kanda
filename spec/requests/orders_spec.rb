require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :request do
  let(:line_item1) { { quantity: 2, amount: 10 } }
  let(:line_item2) { { quantity: 1, amount: 20 } }
  let(:payload) do 
   { order: { line_items_attributes: [line_item1, line_item2] } } 
  end
  let(:hash_order_values) { { subtotal: 40, tax: 3.2, total: 43.2 } }

  before do
    post '/api/v1/orders', params: payload   
  end

  describe 'POST #create' do
    context 'When send a valid payload' do
      it 'creates an order with its respective line items attributes' do
        order = Order.last
        expect(order).to be_present
        order_values = order.attributes.symbolize_keys.slice(:subtotal, :tax, :total)

        expect(order_values).to eq(hash_order_values)
        expect(order.line_items.size).to eq(2)
      end

      it 'returns a http success' do
        expect(response.status).to eq(200)
      end
    end

    context 'When send missing required values in the payload' do
      let(:line_item1) { { amount: 10 } }
      it 'does not create an order' do
        expect(Order.all.size).to eq(0)
      end

      it 'raises a RecordInvalid error' do
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body).symbolize_keys[:error]).to eq('RECORD_INVALID')
      end
    end
  end

  describe 'PATCH #update' do
    let!(:order) { create(:order) }
    let!(:line_item1) { create(:line_item, order: order, quantity: 2, amount: 10)}
    let!(:line_item1_attrs) { { id: line_item1.id, quantity: 4, amount: 10 } }
    let!(:line_item2) { create(:line_item, order: order, quantity: 1, amount: 20 )}
    let!(:line_item2_attrs) { { id: line_item2.id, quantity: 4, amount: 20 } }
    let(:payload2) do 
     { order: { line_items_attributes: [line_item1_attrs, line_item2_attrs] } } 
    end

    let(:hash_order_values_updated) { { subtotal: 120, tax: 9.6, total: 129.6 } }

    before do
      patch "/api/v1/orders/#{order.id}", params: payload2  
    end

    context 'When send a valid payload' do
      it 'update the line items attributes belongs to the order_id sent' do
        order_values = order.reload.attributes.symbolize_keys.slice(:subtotal, :tax, :total)

        expect(order_values).to eq(hash_order_values_updated)
      end

      it 'returns a http success' do
        expect(response.status).to eq(200)
      end
    end

    context 'When send missing required values in the payload' do
      let(:line_item1_attrs) { { quantity: 4, amount: 10 } }
      it 'does not create an order' do
        order_values = order.attributes.symbolize_keys.slice(:subtotal, :tax, :total)
        expect(order_values).to eq(hash_order_values)
      end

      it 'raises a StandarError exception' do
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body).symbolize_keys[:error]).to eq('MISSING_KEYS')
      end
    end
  end
end
