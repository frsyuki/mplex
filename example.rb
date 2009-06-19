data = <<DATA
Get:
  - [std::string, key]
  - [int, flags]
Set:
  - [std::string, key]
  - [std::string, value]
DATA

require 'yaml'

msg = Struct.new("Message", :name, :member, :id)
mem = Struct.new("Member",  :type, :name)

YAML.load(data).map {|name, member|
	msg.new(name, member.map {|t,v| mem.new(t,v) })
}

