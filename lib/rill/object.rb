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

require 'rill/object_types'

module Rill
  class Object
    def initialize
    end

    def id
      return @id ||= nil
    end

    def id=(new_id)
      if !new_id.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_id.class}."
      end
      @id = new_id.to_str
    end

    def name
      return @name ||= nil
    end

    def name=(new_name)
      if !new_name.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_name.class}."
      end
      @name = new_name.to_str
    end

    def summary
      return @summary ||= nil
    end

    def summary=(new_summary)
      if !new_summary.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_summary.class}."
      end
      @summary = new_summary.to_str
    end

    def permalink
      return @permalink ||= nil
    end

    def permalink=(new_permalink)
      if !new_permalink.respond_to?(:to_str)
        raise TypeError,
          "Expected Addressable::URI or String, got #{new_permalink.class}."
      end
      @permalink = Addressable::URI.parse(new_permalink)
    end

    def parse_json(data)
      require 'json'
      if data.respond_to?(:to_str)
        data = JSON.parse(data.to_str)
      elsif !data.kind_of?(Hash)
        raise TypeError, "Expected Hash or String, got #{data.class}."
      end
      if data['id']
        self.id = data['id']
      end
      if data['displayName']
        self.name = data['displayName']
      end
      if data['summary']
        self.summary = data['summary']
      end
      if data['link']
        self.permalink = data['link']
      end
      return self
    end

    def self.parse_json(data)
      require 'json'
      if data.respond_to?(:to_str)
        data = JSON.parse(data.to_str)
      elsif !data.kind_of?(Hash)
        raise TypeError, "Expected Hash or String, got #{data.class}."
      end
      if data['objectType'] && ::Rill::ObjectTypes[data['objectType']]
        object = ::Rill::ObjectTypes[data['objectType']].new
      else
        object = ::Rill::Object.new
      end
      object.parse_json(data)
      return object
    end
  end
end
