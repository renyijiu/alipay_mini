
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

    def self.deep_compact(hash)
      return hash unless hash.is_a?(::Hash)

      hash.each_with_object({}) do |(k, v), compact_hash|
        if v.is_a?(::Hash)
          compact_hash[k] = deep_compact(v)
        else
          compact_hash[k] = v unless v.nil?
        end
      end
    end
  end
end