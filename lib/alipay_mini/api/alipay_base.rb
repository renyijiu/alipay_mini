module AlipayMini
  module Api
    class AlipayBase

      def method
        raise ArgumentError, "please set the correct api method name"
      end

      def timestamp
        Time.now.strftime("%Y-%m-%d %H:%M:%S")
      end

      def base_params
        {
            app_id: AlipayMini.config[:app_id],
            format: AlipayMini.config[:format],
            charset: AlipayMini.config[:charset],
            sign_type: AlipayMini.config[:sign_type],
            version: AlipayMini.config[:version],
            method: method,
            timestamp: timestamp
        }
      end

      def sign_params(params)
        params.merge(sign: AlipayMini::Sign.generate(params))
      end

    end
  end
end
