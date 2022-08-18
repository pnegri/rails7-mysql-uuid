module MysqlUUIDType
  module Migrations
    def uuid(*column_names)
      options = column_names.extract_options!
      column_names.each do |name|
        # column(name, 'binary(16)', options)
        column(name, 'binary(16)')
      end
    end
  end
end
