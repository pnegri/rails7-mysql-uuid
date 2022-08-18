require 'active_record'
require 'active_support/concern'
require 'active_record/connection_adapters/abstract_mysql_adapter'

module MysqlUUIDType
  module Configuration
    def self.apply!
      if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::Table.prepend Migrations
      end
      if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::TableDefinition.prepend Migrations
      end
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.prepend ActiveRecordMapTypeToSQL
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.prepend ActiveRecordRegisterType
      ActiveRecord::Type.register(:uuid, MysqlUUIDType::UUID)
      if defined? ActiveRecord::Base
        ActiveRecord::Base.include MysqlUUIDType::ActiveModelCreateUUID
      end
    end
  end
end
