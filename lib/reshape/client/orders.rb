# frozen_string_literal: true

module Reshape
  class Client
    module Orders
      def order(id, options = {}, raw = false)
        get("/orders/#{id}/#{api_version}", options, raw)
      end

      def orders(options = {}, raw = false)
        get("/orders/#{api_version}", options, raw)
      end

      def add_order(order_details, options = {}, raw = false)
        options.merge!(order_details)
        post("/orders/#{api_version}", options, raw)

        false
      end

      def cart(options = {}, raw = false)
        get("/orders/cart/#{api_version}", options, raw)
      end

      def add_to_cart(model_id, material_id, quantity, options = {}, raw = false)
        options.merge!(
          {
            modelId: model_id,
            materialId: material_id,
            quantity: quantity
          }
        )
        post("/orders/cart/#{api_version}", options, raw)
      end
    end
  end
end
