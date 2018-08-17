require "net/http"
require "json"

module AlipayMini
  module Request
    class << self
      def get(method, params)
        uri = URI(AlipayMini.config[:url])
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)

        format_res(method, res)
      end

      protected

      def format_res(method, res)
        return [false, "Network error"] unless res.is_a?(Net::HTTPSuccess)

        res = JSON.parse(res.body)
        method_key = "#{method.split('.').join('_')}_response"
        method_key = "error_response" if res.has_key?("error_response")

        body = res.fetch(method_key, nil)
        return [false, "Response body is empty"] if body.nil?

        sign_params = {sign: res.fetch("sign", nil), sign_type: AlipayMini.config[:sign_type]}
        verify = AlipayMini::Sign.verify?(body.merge(sign_params))
        return [false, 'Sign error'] unless verify

        [method_key != "error_response", body]
      end
    end
  end
end