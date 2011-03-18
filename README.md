mplex
=====
http://github.com/frsyuki/mplex/

## Overview

mplex is an Extended Metaprogramming Library.


## Requirements

  - ruby &gt;= 1.8


## Installation

Use ./configure or rubygems.

Install using ./configure:
    ./bootstrap
    ./configure
    make
    make install

Install using rubygems:
    gem build mplex.gemspec
    gem install mplex-*.gem


## Usage

    Usage: mplex [options] input...
        -c file                          context ruby script
        -o file                          output file
        -r library                       load library
        -x                               print ruby script


## Example

### Simple
    %0.upto(4) do |num|
    class Test[%num%] {
    public:
        %num.times do |i|
        int member{{i}};
        %end
    
        %if num % 2 == 0
        int even;
        %end
    };
    %end

"{{...}}" is same as "[%...%]".

### Simple with advanced syntax

    %0.upto(4) do |num|
    class Test[%num%] {
    public:
        int member{{i}};  %|i| num.times
        int even;  %> if num % 2 == 0
    };
    %end

### Macro

    %def abc(ns)
    namespace [%ns%] {
      % %w[A B C].each do |a|
      % yield a
      % end
    }
    %end
    
    %abc("name") do |a|
    void func[%a%]();
    %end

### Context script

rpc.rb:
    {
        "Get" => {
            "std::string"  => "key",
            "uint32_t"     => "flags",
        },
    
        "Put" => {
            "std::string" => "key",
            "std::string" => "value",
        },
    }

rpc.hmpl:
    %self.each_pair do |name, args|
    void [%name%]( [%args.map {|type,name| "#{type} #{name}" }.join(", ")%] );
    %end

run:
    mplex -c rpc.rb rpc.hmpl -o rpc.h

### Makefile

source tree:
    README
    src/
	src/subdir/
    src/Makefile.am
    src/mplex          # put mplex script here
    src/myapp.hmpl     # myapp.hmpl  -> myapp.h
    src/myapp.ccmpl    # myapp.ccmpl -> myapp.cc

Makefile.am:
    MPLEX = ruby $(abs_srcdir)/mplex
    export MPLEX
    
    PREP_SOURCE = myapp.hmpl myapp.ccmpl
    PREP_TARGET = $(PREP_SOURCE:mpl=)
    EXTRA_DIST = $(PREP_SOURCE)
    
    %.h: %.hmpl
    	$(MPLEX) $< -o $@
    
    %.cc: %.ccmpl
    	$(MPLEX) $< -o $@
    
    prep: $(PREP_TARGET)
    	cd subdir && $(MAKE) prep
    
    prepc:
    	rm -f $(PREP_TARGET)
    	cd subdir && $(MAKE) prepc

## License

    Copyright (c) 2009-2011 FURUHASHI Sadayuki
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

