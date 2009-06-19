__BEGIN__
def delim(i, c, between = ",")
	between if c.length != i+1
end
__END__
%self.each do |msg|
struct [%msg.name%] {
	%# constructor
	%unless msg.member.empty?
	[%msg.name%](
		const [%m.type%]& [%m.name%]_[%delim(i, msg.member)%]  %|m,i| msg.member.each_with_index
		) :
		[%m.name%]([%m.name%]_)[%delim(i, msg.member)%]  %|m,i| msg.member.each_with_index
	{ }
	%end

	%# members
	[%m.type%] [%m.name%];  %|m| msg.member.each

	static const int id = [%msg.id%];  %>if msg.id
};

%end
%# vim: syntax=mplex

