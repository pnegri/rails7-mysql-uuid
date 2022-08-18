require 'uuidtools'

class String
  def to_uuid
    UUIDTools::UUID.parse_string(self)
  end
end
