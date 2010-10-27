# Copyright 2010 Google Inc
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'rill/activity'

module Rill
  class Stream
    def initialize
    end

    def items
      @items ||= []
    end

    def items=(new_items)
      if new_items.respond_to?(:to_ary)
        new_items = new_items.to_ary
      else
        raise TypeError, "Expected Array, got #{new_items.class}."
      end
      new_items.each do |item|
        if !item.kind_of?(::Rill::Activity)
          raise TypeError, "Expected Rill::Activity, got #{item.class}."
        end
      end
      @items = new_items
    end

    def self.parse_json(data)
      require 'json'
      if data.respond_to?(:to_str)
        data = JSON.parse(data.to_str)
      elsif !data.kind_of?(Hash)
        raise TypeError, "Expected Hash or String, got #{data.class}."
      end
      stream = ::Rill::Stream.new
      items = (data['items'] || [])
      unless items.kind_of?(Array)
        raise TypeError, "Expected Array, got #{items.class}."
      end
      stream.items = items.map do |item|
        ::Rill::Activity.parse_json(item)
      end
      return stream
    end
  end
end
