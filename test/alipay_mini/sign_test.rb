require "openssl"
require "base64"

require "test_helper"

class AlipayMini::SignTest < Minitest::Test

  def setup
    Singleton.__init__(AlipayMini::Config)

    AlipayMini.configure do |c|
      c.private_key = TEST_RSA2_PRIVATE_KEY
      c.public_key = TEST_RSA2_PUBLIC_KEY
    end

    @params = {
        hello: 'world',
        nick_name: 'renyijiu'
    }
    @rsa2_type = 'RSA2'
    @sign = "m9rI0EWlCjJmcVHuBx8FGIG+yemR4/TbJJVK/902bgjBdStiigxCHfyT+MojmFGQwzv+wQIKDbTRpCwawn08Khkm9XN6Otry2DIg0jXyuObwwMeZY5R8VF1Hx/6neHe9CI4X5nfJvSnitP8W0JYrRM5mPiAaUrsfm2FqwCCpZqAhgBX+jI5GH3x4dYU8mgLBl9bGyScxQFgdam9/XIPEnHaaKp4DY8dpZa3oTG7+cmsxoPrjMemO0nlGQyGoIXo8sbG/LRRL4vUH6FyzvsMBzevkKzNqxept96804gU0FxA2eK2+vP90visZcy9qMb5ZeTUGIMY1QdBxGHtYeIAKmg=="
  end

  def test_generate_rsa2_sign
    assert_equal @sign, AlipayMini::Sign.generate(@params, {sign_type: @rsa2_type})
  end

  def test_verify_rsa2_sign
    assert AlipayMini::Sign.verify?(@params.merge(sign_type: @rsa2_type, sign: @sign))
    assert AlipayMini::Sign.verify?(@params.merge(sign_type: @rsa2_type, sign: @sign), public_key: TEST_RSA2_PUBLIC_KEY)
  end

  def test_verify_rsa2_sign_failed
    assert_equal false, AlipayMini::Sign.verify?(@params)
    assert_equal false, AlipayMini::Sign.verify?(@params.merge(error: 'hello', sign_type: @rsa2_type, sign: @sign))
    assert_equal false, AlipayMini::Sign.verify?(@params.merge(sign_type: @rsa2_type, sign: Base64.strict_encode64('error')))
  end

end

