
require "openssl"
require "base64"

require "test_helper"

class AlipayMini::Sign::RSA2Test < Minitest::Test

  def setup
    @string = "hello=world&nick_name=xiaoming"
    @rsa2_pkey = OpenSSL::PKey::RSA.new(2048)
    @rsa2_public_key = @rsa2_pkey.public_key.export

    digest = OpenSSL::Digest::SHA256.new
    @sign = Base64.strict_encode64(@rsa2_pkey.sign(digest, @string))
  end

  def test_sign
    assert_equal @sign, AlipayMini::Sign::RSA2.sign(@rsa2_pkey, @string)
  end

  def test_verify
    assert_equal true, AlipayMini::Sign::RSA2.verify?(@rsa2_public_key, @string, @sign)
  end

  def test_verify_fail_when_sign_not_true
    assert_equal false, AlipayMini::Sign::RSA2.verify?(@rsa2_public_key, "false#{@string}", @sign)
  end

end

