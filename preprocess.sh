#!/bin/sh
out=bin/mplex
echo "#!/usr/bin/env ruby" > "$out.tmp"  # FIXME path of ruby
grep -v "require 'mplex'" <  mplex-run >> "$out.tmp"
cat lib/mplex.rb >> "$out.tmp"
chmod 755 "$out.tmp"
mv "$out.tmp" "$out"

