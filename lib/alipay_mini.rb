require 'alipay_mini/version'
require 'alipay_mini/config'

module AlipayMini

  class << self

    def configure
      config = Config.instance
      yield config
    end

    def config
      config = Config.instance
      @setting ||= config.configuration
    end

  end

end
