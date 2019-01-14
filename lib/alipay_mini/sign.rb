
module AlipayMini
  module Sign
    def self.generate(params, options = {})
      params = Utils.stringify_keys(params)

      sign_type = options[:sign_type] || AlipayMini.config[:sign_type]
      key = options[:private_key] || AlipayMini.config[:private_key]

      string = Utils.params_to_string(params)

      case sign_type
      when 'RSA2'
        RSA2.sign(key, string)
      else
        raise ArgumentError, "invalid sign_type #{sign_type}, allowed type: 'RSA2'"
      end
    end

    def self.verify?(params, options = {})
      params = Utils.stringify_keys(params)

      sign_type = params.delete('sign_type')
      sign = params.delete('sign')
      public_key = options[:public_key] || AlipayMini.config[:public_key]

      # 转义正斜杠，防止验签无法通过
      string = params.to_json.gsub('/', '\/')

      case sign_type
      when 'RSA2'
        RSA2.verify?(public_key, string, sign)
      else
        false
      end
    end

    def self.async_verify?(params, options = {})
      params = Utils.stringify_keys(params)

      sign_type = params.fetch('sign_type')
      sign = params.delete('sign')
      public_key = options[:public_key] || AlipayMini.config[:public_key]
      params.delete('sign_type') if options.fetch(:delete_sign_type, true)

      string = AlipayMini::Utils.params_to_string(params)

      case sign_type
      when 'RSA2'
        RSA2.verify?(public_key, string, sign)
      else
        false
      end
    end

  end
end