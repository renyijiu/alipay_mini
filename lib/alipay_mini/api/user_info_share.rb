module AlipayMini
  module Api
    class UserInfoShare < AlipayBase

      def get(access_token)
        params = base_params.merge(auth_token: access_token)

        AlipayMini::Request.get(method, sign_params(params))
      end

      private

      def method
        "alipay.user.info.share"
      end

    end
  end
end