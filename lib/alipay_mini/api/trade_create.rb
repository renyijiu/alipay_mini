module AlipayMini
  module Api
    class TradeCreate < AlipayBase

      def get(trade_no, amount, subject, buyer_id, options = {})
        trade_params = get_trade_params(trade_no, amount, subject, buyer_id, options)
        params = base_params.merge(trade_params)

        AlipayMini::Request.get(method, sign_params(params))
      end

      private

      def method
        'alipay.trade.create'
      end

      def get_trade_params(trade_no, amount, subject, buyer_id, options = {})
        biz_content = {
            out_trade_no: trade_no,
            seller_id: options.fetch(:seller_id, nil),
            total_amount: amount,
            discountable_amount: options.fetch(:discountable_amount, nil),
            subject: subject,
            body: options.fetch(:body, nil),
            buyer_id: buyer_id,
            goods_detail: options.fetch(:goods_detail, nil),
            operator_id: options.fetch(:operator_id, nil),
            store_id: options.fetch(:store_id, nil),
            terminal_id: options.fetch(:terminal_id, nil),
            extend_params: options.fetch(:extend_params, nil),
            timeout_express: options.fetch(:timeout_express, nil),
            settle_info: options.fetch(:settle_info, nil),
            logistics_detail: options.fetch(:logistics_detail, nil),
            business_params: options.fetch(:business_params, nil),
            receiver_address_info: options.fetch(:receiver_address_info, nil)
        }
        biz_content = AlipayMini::Utils.deep_compact(biz_content)

        params = {
            notify_url: options.fetch(:notify_url, nil),
            app_auth_token: options.fetch(:app_auth_token, nil),
        }

        AlipayMini::Utils.deep_compact(params).merge(biz_content: biz_content.to_json)
      end
    end
  end
end
