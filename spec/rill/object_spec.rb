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

require 'rill/object'
require 'json'

describe Rill::Object do
  before do
    @object = Rill::Object.new
  end

  it 'should raise a type error for an invalid id' do
    (lambda do
      @object.id = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid name' do
    (lambda do
      @object.name = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid summary' do
    (lambda do
      @object.summary = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid permalink' do
    (lambda do
      @object.permalink = 42
    end).should raise_error(TypeError)
  end

  it 'should correctly handle permalinks as strings' do
    @object.permalink = 'http://example.com/'
    @object.permalink.should === 'http://example.com/'
  end

  it 'should correctly handle permalinks as pre-parsed URIs' do
    @object.permalink = Addressable::URI.parse('http://example.com/')
    @object.permalink.should === 'http://example.com/'
  end
end

describe Rill::Object, 'parsed from empty string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Object.parse_json('')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Object, 'parsed from invalid JSON string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Object.parse_json('This is not JSON.')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Object, 'parsed from invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json(42)
    end).should raise_error(TypeError)
  end
end

describe Rill::Object, 'parsed from empty string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Object.new.parse_json('')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Object, 'parsed from invalid JSON string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Object.new.parse_json('This is not JSON.')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Object, 'parsed from invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.new.parse_json(42)
    end).should raise_error(TypeError)
  end
end

shared_examples_for 'empty object' do
  it 'should parse an empty object' do
    @object.id.should be_nil
    @object.name.should be_nil
    @object.summary.should be_nil
    @object.permalink.should be_nil
  end
end

describe Rill::Object, 'with an empty object' do
  before do
    @object = Rill::Object.parse_json({})
  end

  it_should_behave_like 'empty object'
end

describe Rill::Object, 'with an empty unparsed object' do
  before do
    @object = Rill::Object.parse_json('{}')
  end

  it_should_behave_like 'empty object'
end

describe Rill::Object, 'with an empty object' do
  before do
    @object = Rill::Object.new.parse_json({})
  end

  it_should_behave_like 'empty object'
end

describe Rill::Object, 'with an empty unparsed object' do
  before do
    @object = Rill::Object.new.parse_json('{}')
  end

  it_should_behave_like 'empty object'
end

describe Rill::Object, 'with an object that contains invalid id' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json({'id' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Object, 'with an object that contains invalid name' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json({'displayName' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Object, 'with an object that contains invalid summary' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json({'summary' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Object, 'with an object that contains invalid permalink' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json({'link' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Object, 'with a complex object' do
  before do
    @object = Rill::Object.parse_json({
      'id' => 'urn:uuid:dc0858a0-e218-11df-abfe-d83062fffee6',
      'displayName' => 'Thingy',
      'link' => 'http://example.com/thingy',
      'summary'  => 'A "Thingy".'
    })
  end

  it 'should have an id' do
    @object.id.should == 'urn:uuid:dc0858a0-e218-11df-abfe-d83062fffee6'
  end

  it 'should have a name' do
    @object.name.should == 'Thingy'
  end

  it 'should have a permalink' do
    @object.permalink.to_str.should == 'http://example.com/thingy'
  end

  it 'should have a id' do
    @object.summary.should == 'A "Thingy".'
  end

  # TODO(bobaman) Finish this.
end
