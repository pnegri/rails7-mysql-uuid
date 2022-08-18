require 'uuidtools'

module UUIDTools
  class UUID
    alias id raw

    # duck typing activerecord 3.1 dirty hack )
    def gsub(*)
      self
    end

    def quoted_id
      s = raw.unpack1('H*')
      "x'#{s}'"
    end

    def as_json(_options = nil)
      hexdigest.upcase
    end

    def to_param
      hexdigest.upcase
    end

    def to_liquid
      to_param
    end

    def to_json(_options = nil)
      "\"#{to_param}\""
    end

    def value_for_database
      raw
    end

    def self.serialize(value)
      case value
      when self
        value
      when String
        parse_string value
      end
    end

    def bytesize
      16
    end

    def shorten
      MysqlUUIDType::ShortUUIDTools.shorten(to_s)
    end

    def self.parse_string(str)
      return nil if str.length.zero?

      case str.length
      when 36
        parse str
      when 32
        parse_hexdigest str
      when 16
        parse_raw str
      else
        parse MysqlUUIDType::ShortUUIDTools.expand(str)
      end
    end
  end
end
