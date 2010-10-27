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

require 'time'

require 'rill/object'

module Rill
  class Activity
    def initialize
    end

    def actor
      return @actor ||= nil
    end

    def actor=(new_actor)
      if !new_actor.kind_of?(::Rill::Object)
        raise TypeError, "Expected Rill::Object, got #{new_actor.class}."
      end
      @actor = new_actor
    end

    def verb
      return @verb ||= 'post'
    end

    def verb=(new_verb)
      if !new_verb.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_verb.class}."
      end
      @verb = new_verb.to_str
    end

    def object
      return @object ||= nil
    end

    def object=(new_object)
      if !new_object.kind_of?(::Rill::Object)
        raise TypeError, "Expected Rill::Object, got #{new_object.class}."
      end
      @object = new_object
    end

    def target
      return @target ||= nil
    end

    def target=(new_target)
      if !new_target.kind_of?(::Rill::Object)
        raise TypeError, "Expected Rill::Object, got #{new_target.class}."
      end
      @target = new_target
    end

    def time
      return @time ||= nil
    end

    def time=(new_time)
      # Not a big fan of this solution, but it's less awful than most of the
      # other options.
      if new_time.respond_to?(:iso8601)
        @time = Time.parse(new_time.iso8601)
      elsif new_time.respond_to?(:to_str)
        @time = Time.parse(new_time.to_str)
      else
        raise TypeError, "Expected Time or String, got #{new_time.class}."
      end
    end

    def generator
      return @generator ||= nil
    end

    def generator=(new_generator)
      if !new_generator.kind_of?(::Rill::Object)
        raise TypeError, "Expected Rill::Object, got #{new_generator.class}."
      end
      @generator = new_generator
    end

    def provider
      return @provider ||= nil
    end

    def provider=(new_provider)
      if !new_provider.kind_of?(::Rill::Object)
        raise TypeError, "Expected Rill::Object, got #{new_provider.class}."
      end
      @provider = new_provider
    end

    def title
      return @title ||= nil
    end

    def title=(new_title)
      if !new_title.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_title.class}."
      end
      @title = new_title.to_str
    end

    def body
      return @body ||= nil
    end

    def body=(new_body)
      if !new_body.respond_to?(:to_str)
        raise TypeError, "Expected String, got #{new_body.class}."
      end
      @body = new_body.to_str
    end

    def parse_json(data)
      require 'json'
      if data.respond_to?(:to_str)
        data = JSON.parse(data.to_str)
      elsif !data.kind_of?(Hash)
        raise TypeError, "Expected Hash or String, got #{data.class}."
      end
      if data['actor']
        self.actor = ::Rill::Object.parse_json(data['actor'])
      end
      if data['verb']
        self.verb = data['verb']
      end
      if data['object']
        self.object = ::Rill::Object.parse_json(data['object'])
      end
      if data['target']
        self.target = ::Rill::Object.parse_json(data['target'])
      end
      if data['postedTime']
        self.time = data['postedTime']
      end
      if data['generator']
        self.generator = ::Rill::Object.parse_json(data['generator'])
      end
      if data['provider']
        self.provider = ::Rill::Object.parse_json(data['provider'])
      end
      if data['title']
        self.title = data['title']
      end
      if data['body']
        self.body = data['body']
      end
      return self
    end

    def self.parse_json(data)
      return ::Rill::Activity.new.parse_json(data)
    end
  end
end
