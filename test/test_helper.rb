$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "alipay_mini"

require "minitest/autorun"
require "webmock/minitest"

TEST_RSA2_PRIVATE_KEY = "MIIEowIBAAKCAQEA4dYwCsxAphNKkBDWnAf//xwBHzhD6qcHcrVkjMEiFUuCZr9WR5biEpzdkArWdlKSX9vyZDwkls34Z82h2bpKNK9NSWGoGjozHbdKctr0VhedtiQsdQxuqgoeYpSg2o4HxXh+NT2NOoXcg2JZP7o7HDgpiaIRgjAw49ht56eqnkCUYIAKC/yTKiN8fG2vX3JsMnRMwoqNC10W3PrHGrjDUBc+ho6VpHLyFWE3wuFABKfZLPT4rgNwPIPBBvBQRfUldj7kszlNySY0ibNvUw2Go8TZ2H91/GgBt4ynYBv6t26QsMrwiqavf2arjPTM4GcObLsMLNl7q1Mwgwcmn7j1GwIDAQABAoIBAGLm52FDNCjHGAdhqGrqwfzaKc+fV3cDMSrWL7PIvQFwcSpILyPo+xbFpe54IJXu8XWToGKvSCLXDyt+jZwJjofmIcW6Q+FAjbQ82hjUtN6jNwlWbDXSfQBwr//iMVOlkde0PilYzGnNx9WuE4HqMAraua4x0NMgAbk2xmMGNZ1ZvhbKHhGDC+p82Rx5Zef4FsXPOjYX2o2HF30+yi3ySw9fvLUdLY4xYN0+MY0OZLF65LYgqjle62BsM7P9MXUsDq372OWwF0CWmtG33t7v8GsFcYHOIrmd0zyGaQpnn3NDM/+i02YOMokTArRkrp196S51E4BUWtDjs3EWjKUxPHkCgYEA+tNcc4eoTNc8HzIFZi4stLX8JZFhpNMtIIYEKEJD3VdLPLq6tEuPWchWOCbSNKMDvUBFpPhLMPLWc8mS+PlbweeoWtkMg8i/o/hD6c0wC9RG+3Z0gfx2m+szOl45YnqO8Pe48w1fTkOq9DPcCEkYrTpMacPmM8S4xtxSqCfgQw8CgYEA5n7bYq4G7fG1pDmW565Ay6LpoJ6zQKK1MYSVmUg24XGWVl0gzi9J8j16U0FCHHIVXikzXm5KagSwIMq4+frI0wrFLgwmu7TV4s/5Lj8wNtyaykIdLhF5UKfhY/AVr+lKoSI3KqQlGMJzA9IWRTfjmQVr/FVPjWQNUf+Y7RKnvTUCgYBIOz/fgUyFPGJy9Vu6rkdvjwza4MAG0E2plQ5zbYnPnwjqpzeHHk9c4qV5rCxSvjMgd/bWaC53HSeG1qC9lEnJUGYaK3FALjqKBL/B/7X7YhlC5zzsBgE+K4BoKaRK6NJrMFuRmuM8TZ5YjuqpdCtoD2bb+m87r0Yq9l3TURBzHwKBgQCNILk1F3b4s9lSv0wteN0Fki9YADOi7Lzin9p1KuknakPxhz3x4LR3FLtURI21GwkISVPBiugXN92bhmRx8uKJjXujsR76KUQYhtx8O4ZK4RIJqydwsJRGFTSE21h8B+yA8pEyk6R/H3gKq9Sk9w5tAAvZSWbXHJ6nSUeaSKTZzQKBgGjuNVuw6Jcc/bNNmtgIEArnZETuA1eSmPLQYQ/ZeIcsuwOIse0nNPpOuB/XY4i7Hu+7Hv/RJdE5OQ04GyH6skLEPUkXVWQBJAacFzQvtXwXYzjLwY1PtxunNREOAr4ZNjRNQP9T6fzxAh2HUA9peAZE2FhFYjZpPkPGMjghZaZP"
TEST_RSA2_PUBLIC_KEY =  "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4dYwCsxAphNKkBDWnAf//xwBHzhD6qcHcrVkjMEiFUuCZr9WR5biEpzdkArWdlKSX9vyZDwkls34Z82h2bpKNK9NSWGoGjozHbdKctr0VhedtiQsdQxuqgoeYpSg2o4HxXh+NT2NOoXcg2JZP7o7HDgpiaIRgjAw49ht56eqnkCUYIAKC/yTKiN8fG2vX3JsMnRMwoqNC10W3PrHGrjDUBc+ho6VpHLyFWE3wuFABKfZLPT4rgNwPIPBBvBQRfUldj7kszlNySY0ibNvUw2Go8TZ2H91/GgBt4ynYBv6t26QsMrwiqavf2arjPTM4GcObLsMLNl7q1Mwgwcmn7j1GwIDAQAB"


# 根据文档及实践发现，签名以及验签过程对于参数的处理不一致
# 为了方便测试，编写测试签名方法，方便生成合理的签名进行验签
def test_generate_json_sign(params, options = {})
  params = AlipayMini::Utils.stringify_keys(params)

  sign_type = options[:sign_type] || AlipayMini.config[:sign_type]
  key = options[:private_key] || AlipayMini.config[:private_key]

  # 正常签名使用 Utils.params_to_string(params)处理
  # 而验签时采用 params.to_json 进行处理
  string = params.to_json.gsub('/', '\/')

  case sign_type
    when 'RSA2'
      AlipayMini::Sign::RSA2.sign(key, string)
    else
      raise ArgumentError, "invalid sign_type #{sign_type}, allowed type: 'RSA2'"
  end
end


# 按相关文档处理rsa的private_key以及public_key
def remove_start_end_for_key(key)
  key_array = key.split("\n")

  key_array[1...-1].join
end

def add_start_end_for_private_key(key)
  "-----BEGIN RSA PRIVATE KEY-----\n#{key}\n-----END RSA PRIVATE KEY-----\n"
end

def add_start_end_for_public_key(key)
  "-----BEGIN PUBLIC KEY-----\n#{key}\n-----END PUBLIC KEY-----\n"
end


# init alipaymini config for test
def init_alipaymini_config
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