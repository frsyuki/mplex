
bin_SCRIPTS = mplex

mplex: lib/mplex.rb bin/mplex
	echo "#!/usr/bin/env ruby" > "$@.tmp"  # FIXME path of ruby
	grep -v "require 'mplex'" <  bin/mplex >> "$@.tmp"
	cat lib/mplex.rb >> "$@.tmp"
	chmod 755 "$@.tmp"
	mv "$@.tmp" "$@"

MOSTLYCLEANFILES = mplex

