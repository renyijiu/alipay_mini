require "test_helper"

class AlipayMini::Api::UserInfoShareTest < Minitest::Test

  def setup
    init_alipaymini_config
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