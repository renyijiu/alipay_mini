
module AlipayMini
  module Utils
    def self.stringify_keys(hash)
      if hash.is_a? ::Hash
        return hash.inject({}) do |memo, (k, v)|
          memo.tap { |m| m[k.to_s] = self.stringify_keys(v) }
        end
      end

      hash
    end

    def self.params_to_string(params)
      params.sort.map{ |item| item.join('=') }.join('&')
    end


  end
end