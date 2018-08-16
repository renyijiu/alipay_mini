require "alipay_mini/version"
require "alipay_mini/config"
require "alipay_mini/utils"
require "alipay_mini/sign/rsa2"
require "alipay_mini/sign"

module AlipayMini

  class << self
    def configure
      config = Config.instance
      yield config
    end

    def config
      Config.instance.configuration
    end
  end

end
