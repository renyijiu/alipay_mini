require "test_helper"

class AlipayMini::Api::SystemOauthTokenTest < Minitest::Test

  def setup
    init_alipaymini_config
  end

  def test_get_with_authorization_code
    mock_res = {
        "alipay_system_oauth_token_response" => {
            "hello" => "world"
        }
    }
    sign = test_generate_json_sign(mock_res["alipay_system_oauth_token_response"])
    stub_request(:get, /https:\/\/openapi\.alipaydev\.com\/gateway\.do/).to_return(body: mock_res.merge(sign: sign).to_json)

    flag, res = AlipayMini.system_oauth_token('authorization_code', 'test')

    assert_equal true, flag
    assert res.is_a? ::Hash
  end

  def test_get_with_refresh_token
    mock_res = {
        "alipay_system_oauth_token_response" => {
            "hello" => "world"
        }
    }
    sign = test_generate_json_sign(mock_res["alipay_system_oauth_token_response"])
    stub_request(:get, /https:\/\/openapi\.alipaydev\.com\/gateway\.do/).to_return(body: mock_res.merge(sign: sign).to_json)

    flag, res = AlipayMini.system_oauth_token('refresh_token', 'test')

    assert_equal true, flag
    assert res.is_a? ::Hash
  end

end