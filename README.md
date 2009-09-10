mplex
=====
http://github.com/frsyuki/mplex/

## Overview

mplex is an Extended Metaprogramming Library.


## Requirements

  - ruby >= 1.8


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


*Example

  1. Create template file example.mpl:

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


  2. Create context script example.rb:

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


  3. Run mplex with context data

    ./mplex -c example.rb example.mpl -o example.h

    Output will be as following:

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


## License

    Copyright (c) 2009 FURUHASHI Sadayuki
    
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
