require "test_helper"

class AlipayMini::Api::TradeCreateTest < Minitest::Test

  def setup
    init_alipaymini_config
  end

  def test_should_create_trade
    mock_res = {
        "alipay_trade_create_response" => {
            "msg" => "success",
        }
    }
    sign = test_generate_json_sign(mock_res["alipay_trade_create_response"])
    stub_request(:get, /https:\/\/openapi\.alipaydev\.com\/gateway\.do/).to_return(body: mock_res.merge(sign: sign).to_json)

    flag, res = AlipayMini.trade_create('test', 0.01, 'test', 'userid')

    assert_equal true, flag
    assert res.is_a? ::Hash
  end

end