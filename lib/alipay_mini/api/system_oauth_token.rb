module AlipayMini
  module Api
    class SystemOauthToken
      # when grant_type is 'authorization_code', code is the auth_code
      # when grant_type is 'refresh_token', code is the refresh_tok``en
      def get(grant_type, code)
        case grant_type
        when 'authorization_code'
          params = base_params.merge(grant_type: grant_type, code: code)
        when 'refresh_token'
          params = base_params.merge(grant_type: grant_type, refresh_token: code)
        else
          raise ArgumentError, 'grant type not valid, allow type "authorization_code", "refresh_token"'
        end

        AlipayMini::Request.get(method, sign_params(params))
      end

      private

      def method
        "alipay.system.oauth.token"
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