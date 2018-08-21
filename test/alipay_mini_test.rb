require "openssl"
require "test_helper"

class AlipayMiniTest < Minitest::Test

  def setup
    init_alipaymini_config
  end

  def test_that_it_has_a_version_number
    refute_nil ::AlipayMini::VERSION
  end

  def test_set_config_value
    assert_equal @url, AlipayMini::Config.instance.url
    assert_equal @app_id, AlipayMini::Config.instance.app_id
    assert_equal @private_key, AlipayMini::Config.instance.private_key
    assert_equal @public_key, AlipayMini::Config.instance.public_key
  end

  def test_get_config_value
    assert_equal @url, AlipayMini.config[:url]
    assert_equal @app_id, AlipayMini.config[:app_id]
    assert_equal add_start_end_for_private_key(@private_key), AlipayMini.config[:private_key]
    assert_equal add_start_end_for_public_key(@public_key), AlipayMini.config[:public_key]

    assert_equal '1.0', AlipayMini.config[:version]
    assert_equal 'JSON', AlipayMini.config[:format]
    assert_equal 'utf-8', AlipayMini.config[:charset]
    assert_equal 'RSA2', AlipayMini.config[:sign_type]
  end
end
