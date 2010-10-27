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

require 'addressable/uri'
require 'rill/object'
require 'rill/object_types'

module Rill
  module ObjectTypes
    class Note < ::Rill::Object
      def content
        return @content ||= nil
      end

      def content=(new_content)
        if !new_content.respond_to?(:to_str)
          raise TypeError, "Expected String, got #{new_content.class}."
        end
        @content = new_content.to_str
      end

      def parse_json(data)
        super(data)
        if data['content']
          self.content = data['content']
        end
        return self
      end
    end
  end
end

::Rill::ObjectTypes['note'] = ::Rill::ObjectTypes::Note
