module AlipayMini
  module Api
    class UserInfoShare

      def get(access_token)
        params = base_params.merge(auth_token: access_token)

        AlipayMini::Request.get(method, sign_params(params))
      end

      private

      def method
        "alipay.user.info.share"
      end

      def timestamp
        Time.now.strftime("%Y-%m-%d %H:%M:%S")
      end

      def base_params
        {
            app_id: AlipayMini.config[:app_id],
            method: method,
            format: AlipayMini.config[:format],
            charset: AlipayMini.config[:charset],
            sign_type: AlipayMini.config[:sign_type],
            timestamp: timestamp,
            version: AlipayMini.config[:version]
        }
      end

      def sign_params(params)
        params.merge(sign: AlipayMini::Sign.generate(params))
      end

    end
  end
end