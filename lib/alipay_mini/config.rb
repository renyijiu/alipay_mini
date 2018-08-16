require 'singleton'

module AlipayMini
  class Config
    include Singleton

    # api request url
    attr_accessor :url

    # mini program app id
    attr_accessor :app_id

    # format, default is 'JSON', only support 'JSON'
    attr_accessor :format

    # charset, default is 'utf-8'
    attr_accessor :charset

    # sign type, default is 'RSA2', support 'RSA2' or 'RSA'
    attr_accessor :sign_type

    # version, now is '1.0'
    attr_accessor :version

    # app private key, use for sign
    attr_accessor :private_key

    # alipay public key, use for verify
    attr_accessor :public_key


    def configuration
      setting = {}

      setting.tap do |config|
        config[:url] = url if url
        config[:app_id] = app_id if app_id
        config[:private_key] = private_key if private_key
        config[:public_key] = public_key if public_key

        config[:version] = '1.0'
        config[:format] = format || 'JSON'
        config[:charset] = charset || 'utf-8'
        config[:sign_type] = sign_type || 'RSA2'
      end
    end

  end
end