require "alipay_mini/version"
require "alipay_mini/config"
require "alipay_mini/utils"
require "alipay_mini/sign/rsa2"
require "alipay_mini/sign"
require "alipay_mini/request"
require "alipay_mini/api/alipay_base"
require "alipay_mini/api/system_oauth_token"
require "alipay_mini/api/user_info_share"
require "alipay_mini/api/trade_create"

module AlipayMini

  class << self
    def configure
      config = Config.instance
      yield config
    end

    def config
      Config.instance.configuration
    end

    # synchronize notify verify sign
    def verify?(params, options = {})
      AlipayMini::Sign.verify?(params, options)
    end

    # asynchronous notify verify sign
    def async_verify?(params, options = {})
      AlipayMini::Sign.async_verify?(params, options)
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

    # https://docs.open.alipay.com/api_1/alipay.trade.create
    # alipay.trade_create
    #
    # @params trade_no String length < 64, only letter, number, underline
    # @params amount Price Accurate to two decimal places, the range of values [0.01,100000000]
    # @params subject String the title of order
    # @params buyer_id String the user id of taobao
    #
    # @return Array [flag<Boolean>, res<Hash>]
    def trade_create(trade_no, amount, subject, buyer_id, options = {})
      AlipayMini::Api::TradeCreate.new.get(trade_no, amount, subject, buyer_id, options)
    end
  end

end
