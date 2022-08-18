# register new type
require 'uuidtools'

module MysqlUUIDType
  class UUID < ActiveModel::Type::Binary
    def type
      :uuid
    end

    def serialize(value)
      return if value.blank?

      ActiveRecord::Type::Binary::Data.new(
        UUIDTools::UUID.serialize(value).value_for_database
      )
    end

    def deserialize(value)
      return nil if value.nil?

      UUIDTools::UUID.serialize(value.to_s).shorten.to_s
    end

    def type_cast_for_schema(value)
      super
    end

    def cast(value)
      return if value.nil?

      UUIDTools::UUID.serialize(value).to_s
    end
  end
end
