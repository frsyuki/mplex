struct Get {
	Get(
		const std::string& key_,
		const int& flags_
		) :
		key(key_),
		flags(flags_)
	{ }

	std::string key;
	int flags;

};

struct Set {
	Set(
		const std::string& key_,
		const std::string& value_
		) :
		key(key_),
		value(value_)
	{ }

	std::string key;
	std::string value;

};

