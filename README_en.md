![](https://travis-ci.com/renyijiu/alipay_mini.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/alipay_mini.svg)](https://badge.fury.io/rb/alipay_mini)
[![Maintainability](https://api.codeclimate.com/v1/badges/38ee73000994e3721c04/maintainability)](https://codeclimate.com/github/renyijiu/alipay_mini/maintainability)

# AlipayMini

An unofficial simple gem for alipay mini program. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alipay_mini', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alipay_mini

## Usage

### Config

Setup the config first.

```ruby
AlipayMini.configure do |c|
   c.private_key = "your own private key generate by alipay"
   c.public_key = "the alipay's public key"
   c.url = "the alipay api url"
   c.app_id = "your own app_id"
end
```
> Attention: the public key is alipay's official public key!!!

Config example:

```ruby
AlipayMini.configure do |c|
  c.private_key = "MIIEogIBAAKCAQEA0J12pYTGu5y6uWv06/vso4EZkmh9s51hbV4TiM9K99x4bz/mn8+6mRXCxooGvWqtU4xM7sYx+GE3EE4JX3Zxzzg7c/SUbzMC3GwIAO05U6R5dANBsBsl9GZ95EdPKKmxklM1Sa8IdeWNJkU9UJ9zXHHm35bzvVyfG3ava0Kp2pfKHskAfiqtOV5WEkwY3dAyqa2URHm182A0dUyCGXDeeTmbJ0VDXoAHdlNzhdHiH1hJtzSeJ9ouI6tY6lBcfII/ywvLF83a7GWUGFyBoV724xIBsBPc/bHCK2rlRdAqr7dyILHubetHtzs/6RT4OHjvnPTNbHemtWQrOXcVk4DpJQIDAQABAoIBAHEqKfVpzGBzibsR+/+TXm/nlVadhirMIdCxKsmZIWLJXy+CK3nftqpaaplGwJc56iIbRpR0QSEqozMeEemOF/i/2UhykZ6svk2R8NmH1gQwgY3UQmrknzcv7fTKVf+J5gCpUIvS/jTuPB5ZiwRUKsEoLIR3n2rGdqzwOgJmXDtuBpjqxfFDE2tS8hMx2xwBmN5xabUbAv897uci6Bw/J+p3C8xADMKOJvUqkoTz1V0zXJIJ0DA3yIo0SakZ8iGu5P8x1VPBccSO3LQIfX1xS7lsFk3lq1VED918/KKnJvwvF8moyKJEo4UgeKoDgJiYjMmIob2mj/bL+IJQR2vJN8ECgYEA9P+MSWDh6FOVD2pLZQ9G87X34aZxPJsVuZR4vXENR7cV5vq77d6W1DoI+wBq3KHj+l2m4eY0IY4c/wyf4dRVtRisZe9JSTpJc/VSUv/hCzRoFK64C2kAhynkKfb9smNnxq7gt/Z5nuDninHubW/9monv5dWhQzs38u82KVwEPNECgYEA2fupdRpwlAAeDLHtFbnV6GdgSy/Nq6fpe4abtQ1hSmcKdnIOJdFnh4jPsKuM5WGCcJf2Fupz7rcBbhGncLcSkCs4QR7goQ//h1676VvCersLI+Xm2GEEARA5dSqTAOs0yfMR1sQU2S2/CkRniluJt42ywSm9xXqtYXD3oF50LBUCgYAEbg56US8khUZftftRA3qz82ldAiZwAxncdivMuRuVXWEfAQ+e2HR/t+DrsPE9tguqPkFDOmdc5/XsQq0tZyp5kM2lNjNsCIrFdv0bFRdbnYH4RcR8KFTjHMXMYHPr4tJAjG7xxJokXkqxfSfjgK/kOHRHAprc3VhAo0SmcMx+0QKBgEZakzbYcb1SzGAMjRiWAhQgSVP6+caNSy4zI84ro1sAJsBTz30lOOTloyLCO5dNAWyVnzeGNCS3rB56VDBs5fDiAiYCcT2KjE6EpOGMXBiAhffwG7F6nnA5bFIEi62gPElxyjAm2RO/UAlgSoq9QJWdhjQR5M336j2o2ENKOPSBAoGAeeduPyZrc2oa3zJJdgMuSN8zrfG9OMYIeGfBkAv5YPrqpYryn9w0FDj+aHLsCwiVOZPeS39ySa/0+7j7rnw/fAS2meHguosE5PlQgQfTG1V24xogPwXoBP1b3dgyC18JHWQu/wucEe9a11VTVHqY7rMDEcL6R0WPljCxNChnj5Q="
  c.public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoBr6Ag68Dlbf/ZNvqNotNpe2pDei58ObbD7SNEWjMx8CpTTIOqgwbCL0EHuUAF1fxOP42uLd4n/fEdbU0BNkd+4TL71P49Fq4wMXyqoYm+EzEZ8mBnevKtPPb813L1W2thZVISNWMR67axyy6xMk77YOEqRUz3hfJlowm9us8YgHranx+O1vR8olgVTdhjOub9QD/tK7ok1GWSw/dBFpcG9WTuKnPrklMIBxUllIONciH+7KGX+Yhs0zLTEPRufATAy1slIC8NhoBSxSB0PRsix4/gVCw4IAIzGPspdRPA0ZCeJPrjGvuBh9215lNpv0+ew6/a/x3db0ZIVDzLrzyQIDAQAB"
  c.app_id = "2015102700040153"
  c.url = "https://openapi.alipaydev.com/gateway.do"
end
```

## API

### [alipay.system.oauth.token](https://docs.open.alipay.com/api_9/alipay.system.oauth.token)

```ruby
# when grant_type is 'authorization_code', code is the auth_code
# when grant_type is 'refresh_token', code is the refresh_token
#
# @param grant_type String - 'authorization_code', 'refresh_token'
# @param code String - auth_code or refresh_token
#
# @return Array - [flag<Boolean>, res<Hash>] flag: request status, res: response hash
#
# Example:
#   AlipayMini.system_oauth_token('authorization_code', 'helloworld')
#

AlipayMini.system_oauth_token(grant_type, code)
```
### [alipay.user.info.share](https://docs.open.alipay.com/api_2/alipay.user.info.share)

```ruby
# @param access_token String
#
# @return Array [flag<Boolean>, res<Hash>]
#
# Example:
#   AlipayMini.user_info_share("helloworld")
#

AlipayMini.user_info_share(access_token)
```

### Response

```ruby
# flag: request state, true is success, false means the request error
#
# Example:
#   AlipayMini.system_oauth_token('authorization_code', 'helloworld')
#
# Return:
#   [true,  {"access_token" => "12345", "alipay_user_id" => "12345", "expires_in" => 1296000, "re_expires_in" => 2592000, "refresh_token" => "12345", "user_id"=> "12345"}]
#   
#   [false, {"code" => "40002", "msg" => "Invalid Arguments", "sub_code" => "isv.code-invalid", "sub_msg" => "授权码code无效"}]]	
# 
```

## Schedule

### Done
1. [alipay.user.info.share](https://docs.open.alipay.com/api_9/alipay.system.oauth.token)
2. [alipay.user.info.share](https://docs.open.alipay.com/api_2/alipay.user.info.share)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Bug report or pull request are welcome. Please write unit test with your code if necessary
