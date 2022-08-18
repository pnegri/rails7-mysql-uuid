module MysqlUUIDType
  module ActiveRecordMapTypeToSQL
    def self.prepended(_klass)
      # def type_to_sql(type, limit = nil, precision = nil, scale = nil, unsigned = nil, **)

      def type_to_sql(type, limit: nil, precision: nil, scale: nil, **)
        case type.to_s
        when 'uuid'
          'binary(16)'
        else
          super
        end
      end

      def native_database_types
        @native_database_types ||= super.merge(uuid: { name: 'binary', limit: 16 })
      end
    end
  end
end
