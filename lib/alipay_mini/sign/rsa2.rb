require "openssl"
require "base64"

module AlipayMini
  module Sign
    class RSA2

      def self.sign(key, string)
        pkey = OpenSSL::PKey::RSA.new(key)
        digest = OpenSSL::Digest::SHA256.new

        Base64.strict_encode64(pkey.sign(digest, string))
      end

      def self.verify?(key, string, sign)
        pkey = OpenSSL::PKey::RSA.new(key)
        digest = OpenSSL::Digest::SHA256.new

        pkey.verify(digest, Base64.strict_decode64(sign), string)
      end

    end
  end
end