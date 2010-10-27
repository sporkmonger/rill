# Copyright (C) 2010 Google Inc.
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

require 'spec_helper'

require 'rill/stream'
require 'json'

describe Rill::Stream do
  before do
    @stream = Rill::Stream.new
  end

  it 'should raise a type error if the items collection is invalid' do
    (lambda do
      @stream.items = [42]
    end).should raise_error(TypeError)
    (lambda do
      @stream.items = 42
    end).should raise_error(TypeError)
  end
end

describe Rill::Stream, 'parsed from empty string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Stream.parse_json('')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Stream, 'parsed from invalid JSON string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Stream.parse_json('This is not JSON.')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Stream, 'parsed from invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Stream.parse_json(42)
    end).should raise_error(TypeError)
  end
end

describe Rill::Stream, 'with an empty object' do
  before do
    @stream = Rill::Stream.parse_json({})
  end

  it 'should parse an empty item list' do
    @stream.items.should be_empty
  end
end

describe Rill::Stream, 'with an object that contains invalid items' do
  it 'should raise a type error' do
    (lambda do
      Rill::Stream.parse_json({'items' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Stream, 'with an object that contains an invalid items list' do
  it 'should raise a type error' do
    (lambda do
      Rill::Stream.parse_json({"items" => [42]})
    end).should raise_error(TypeError)
  end
end

describe Rill::Stream, 'with a simple activity' do
  before do
    @stream = Rill::Stream.parse_json({
      'items' => [{
        'actor' => {
          'displayName' => 'Alice'
        },
        'verb' => 'post',
        'object' => {
          'summary' => 'This is an object summary.'
        }
      }]
    })
  end

  it 'should parse an empty item list' do
    @stream.items.first.actor.name.should == 'Alice'
    @stream.items.first.verb.should == 'post'
    @stream.items.first.object.should be_kind_of(::Rill::Object)
    @stream.items.first.object.summary.should == 'This is an object summary.'
  end
end

describe Rill::Stream, 'with a note activity' do
  before do
    @stream = Rill::Stream.parse_json({
      'items' => [{
        'actor' => {
          'displayName' => 'Alice'
        },
        'verb' => 'post',
        'object' => {
          'content' => 'This is a post.',
          'objectType' => 'note'
        }
      }]
    })
  end

  it 'should parse an empty item list' do
    @stream.items.first.actor.name.should == 'Alice'
    @stream.items.first.verb.should == 'post'
    @stream.items.first.object.should be_kind_of(::Rill::ObjectTypes::Note)
    @stream.items.first.object.content.should == 'This is a post.'
  end
end
