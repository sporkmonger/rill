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

require 'json'

require 'rill/stream'

module Rill
  module JSONParser
    def self.parse(data)
      # TODO(bobaman): Maybe do some intelligent switching to figure out
      # if this data is a stream, a single activity, or just an object.
      return ::Rill::Stream.parse_json(data)
    end
  end
end
