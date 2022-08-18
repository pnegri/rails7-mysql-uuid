module MysqlUUIDType
  module ActiveRecordRegisterType
    extend ActiveSupport::Concern

    module ClassMethods
      def initialize_type_map(m)
        super
        register_class_with_limit m, /binary\(16(,0)?\)/i, MysqlUUIDType::UUID
      end
    end

    def self.prepended(_klass)
      _klass.singleton_class.prepend(ClassMethods)

      # TODO: Find a better way to do this. Rails 7 Schema Caching
      nTypeMap = ActiveRecord::Type::TypeMap.new.tap { |m| _klass.initialize_type_map(m) }
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::const_set('TYPE_MAP', nTypeMap)
      nTypeMapBoolean = ActiveRecord::Type::TypeMap.new(nTypeMap).tap do |m|
        m.register_type %r(^tinyint\(1\))i, ActiveRecord::Type::Boolean.new
      end
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::const_set('TYPE_MAP_WITH_BOOLEAN', nTypeMapBoolean)
    end
  end
end
