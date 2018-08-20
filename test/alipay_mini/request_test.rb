require "test_helper"

class AlipayMini::RequestTest < Minitest::Test

  def setup
    Singleton.__init__(AlipayMini::Config)

    @url = "https://openapi.alipaydev.com/gateway.do"
    @app_id = '2015102700040153'
    @private_key = OpenSSL::PKey::RSA.new(2048)
    @public_key = @private_key.public_key.export

    AlipayMini.configure do |c|
      c.url = @url
      c.app_id = @app_id
      c.private_key = @private_key
      c.public_key = @public_key
    end

    @params = {
        hello: 'world',
        nick_name: 'renyijiu'
    }
  end

  def test_get_network_error
    stub_request(:get, @url).with(query: @params)
        .to_return(body: {"error_response" => 'invalid'}.to_json, status: 500)

    flag, res = AlipayMini::Request.get('system.oauth.token', @params)

    assert_equal false, flag
    assert "Network error", res
  end

  def test_get_empty_body
    stub_request(:get, @url).with(query: @params)
        .to_return(body: {}.to_json, status: 200)

    flag, res = AlipayMini::Request.get('system.oauth.token', @params)

    assert_equal false, flag
    assert "Response body is empty", res
  end

  def test_get_sign_error
    sign = test_generate_json_sign(@params.merge('test' => 'renyijiu'))

    stub_request(:get, @url).with(query: @params)
        .to_return(body: {'system_oauth_token_response' => @params, sign: sign}.to_json, status: 200)

    flag, res = AlipayMini::Request.get('system.oauth.token', @params)

    assert_equal false, flag
    assert_equal 'Sign error', res
  end

  def test_get_error_response
    sign = test_generate_json_sign(@params)

    stub_request(:get, @url).with(query: @params)
        .to_return(body: {'error_response' => @params, sign: sign}.to_json, status: 200)

    flag, res = AlipayMini::Request.get('system.oauth.token', @params)

    assert_equal false, flag
    assert res.is_a? ::Hash
  end

  def test_get_right_data
    sign = test_generate_json_sign(@params)

    stub_request(:get, @url).with(query: @params)
        .to_return(body: {'system_oauth_token_response' => @params, sign: sign}.to_json, status: 200)

    flag, res = AlipayMini::Request.get('system.oauth.token', @params)

    assert_equal true, flag
    assert res.is_a? ::Hash
  end
end