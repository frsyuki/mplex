#
# Mplex: Extended Metaprogramming Library
#
# Copyright (c) 2009-2011 FURUHASHI Sadayuki
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

class Mplex
	def initialize(src, fname = "(mplex)")
		@script = self.class.compile(src)
		b = nil; Object.new.instance_eval { b = binding }
		@proc   = eval("Proc.new{#{@script}}", b, fname)
	end
	attr_reader :script

	def result(context = nil, output = "")
		self.class.with_context(context, output) {|ctx|
			ctx.instance_eval(&@proc)
		}
	end

	def self.result(src, context = nil, fname = "(mplex)", output = "")
		with_context(context, output) {|ctx|
			ctx.instance_eval(compile(src), fname)
		}
	end

	def self.file(fname, context = nil)
		self.result(File.read(fname), context, fname)
	end

	def self.write(fname, outfname, context = nil)
		out = self.result(File.read(fname), context, fname)
		File.open(outfname, "w") {|f| f.write(out) }
		out
	end

	def self.script(src)
		compile(src)
	end

	private
	def self.with_context(context, output, &block)
		context ||= Object.new
		save = context.instance_variable_get(:@_mplexout)
		context.instance_variable_set(:@_mplexout, output)
		block.call(context)
		context.instance_variable_set(:@_mplexout, save)
		output
	end

	def self.compile(src)
		# MPLEX_COMPILE_BEGIN
		o = ""
		k = false
		src.each_line {|t|
			(k = false; o << "\n"; next) if k && t == "__END__\n"
			(o << t; next) if k
			(k = true;  o << "\n"; next) if t == "__BEGIN__\n"

			c, l = t.split(/^[ \t]*%/,2)
			(o << l; next) if l

			c, a, b = t.split(/[ \t]*\%\|([a-z0-9\,\*\&\(\)]*)\|/,2)
			t = "[%:#{b.strip} do |#{a}|%]#{c+"\n"}[%:end%]" if b

			c, q = t.split(/[ \t]*\%\>/,2)
			t = "[%:(%]#{c+"\n"}[%:)#{q.strip}%]" if q

			s = t.split(/(?:\[\%(\:?.*?)\%\]|\{\{(\:?.*?\}*)\}\})/m)
			s.each_with_index {|m,i|
				(o << "#{m[1..-1]};"; next) if m[0] == ?: && i % 2 == 1
				(o << "@_mplexout.concat((#{m}).to_s);"; next) if i % 2 == 1
				o << "@_mplexout.concat(#{m.dump});" unless m.empty?
			}
			o << "\n"
		}
		o << "@_mplexout"
		# MPLEX_COMPILE_END
	end
end

