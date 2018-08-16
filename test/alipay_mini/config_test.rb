require 'test_helper'

class AlipayMini::ConfigTest < Minitest::Test

  def setup
    Singleton.__init__(AlipayMini::Config)

    @config = AlipayMini::Config.instance
  end

  def test_get_the_configuration
    configuration = @config.configuration

    assert_nil configuration[:url]
    assert_nil configuration[:app_id]
    assert_nil configuration[:private_key]
    assert_nil configuration[:public_key]

    assert_equal '1.0', configuration[:version]
    assert_equal 'JSON', configuration[:format]
    assert_equal 'utf-8', configuration[:charset]
    assert_equal 'RSA2', configuration[:sign_type]
  end

end