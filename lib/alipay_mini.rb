require "alipay_mini/version"
require "alipay_mini/config"
require "alipay_mini/utils"
require "alipay_mini/sign/rsa2"
require "alipay_mini/sign"
require "alipay_mini/request"
require "alipay_mini/api/system_oauth_token"

module AlipayMini

  class << self
    def configure
      config = Config.instance
      yield config
    end

    def config
      Config.instance.configuration
    end

    # alipay.system.oauth.token api
    def system_oauth_token(grant_type, code)
      AlipayMini::Api::SystemOauthToken.new.get(grant_type, code)
    end
  end

end
