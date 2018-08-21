require "test_helper"

class AlipayMini::Api::UserInfoShareTest < Minitest::Test

  def setup
    Singleton.__init__(AlipayMini::Config)

    @url = "https://openapi.alipaydev.com/gateway.do"
    @app_id = '2015102700040153'

    pkey = OpenSSL::PKey::RSA.new(2048)
    @private_key = remove_start_end_for_key(pkey.to_s)
    @public_key = remove_start_end_for_key(pkey.public_key.export)

    AlipayMini.configure do |c|
      c.url = @url
      c.app_id = @app_id
      c.private_key = @private_key
      c.public_key = @public_key
    end
  end

  def test_get_when_has_escape_forward
    mock_res = {
        "alipay_user_info_share_response" => {
            "avatar" => "https://tfs.alipayobjects.com/images/partner/TB1EQ0HXXmLDuNkUQcDXXXqTFXa",
        }
    }
    sign = test_generate_json_sign(mock_res["alipay_user_info_share_response"])
    stub_request(:get, /https:\/\/openapi\.alipaydev\.com\/gateway\.do/).to_return(body: mock_res.merge(sign: sign).to_json)

    flag, res = AlipayMini.user_info_share('test')

    assert_equal true, flag
    assert res.is_a? ::Hash
  end

  def test_get_when_no_escape
    mock_res = {
        "alipay_user_info_share_response" => {
            "city" => "上海市"
        }
    }
    sign = test_generate_json_sign(mock_res["alipay_user_info_share_response"])
    stub_request(:get, /https:\/\/openapi\.alipaydev\.com\/gateway\.do/).to_return(body: mock_res.merge(sign: sign).to_json)

    flag, res = AlipayMini.user_info_share('test')

    assert_equal true, flag
    assert res.is_a? ::Hash
  end

end