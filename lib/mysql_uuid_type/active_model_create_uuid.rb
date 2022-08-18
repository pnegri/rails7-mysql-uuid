module MysqlUUIDType
  module ActiveModelCreateUUID
    extend ActiveSupport::Concern
    included do
      before_create :generate_uuids_if_needed
    end

    def generate_uuids_if_needed
      primary_key = self.class.primary_key
      if self.class.attribute_types[primary_key].type == :uuid
        send("#{primary_key}=", SecureRandom.uuid) unless send("#{primary_key}?")
      end
    end
  end
end
