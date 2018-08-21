require "alipay_mini/version"
require "alipay_mini/config"
require "alipay_mini/utils"
require "alipay_mini/sign/rsa2"
require "alipay_mini/sign"
require "alipay_mini/request"
require "alipay_mini/api/alipay_base"
require "alipay_mini/api/system_oauth_token"
require "alipay_mini/api/user_info_share"

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
    #
    # @params grant_type String 'authorization_code', 'refresh_token'
    # @params code String auth_code or refresh_token
    #
    # @return Array [flag<Boolean>, res<Hash>]
    def system_oauth_token(grant_type, code)
      AlipayMini::Api::SystemOauthToken.new.get(grant_type, code)
    end

    # alipay.user.info.share api
    #
    # @params access_token String access_token
    #
    # @return Array [flag<Boolean>, res<Hash>]
    def user_info_share(access_token)
      AlipayMini::Api::UserInfoShare.new.get(access_token)
    end
  end

end
