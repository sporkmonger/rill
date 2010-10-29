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

require 'rill/object_types/note'
require 'json'


describe Rill::ObjectTypes do
  it 'should have "note" as a registered object type' do
    Rill::ObjectTypes.to_hash['note'].should == Rill::ObjectTypes::Note
  end
end

describe Rill::ObjectTypes::Note, 'with a simple note' do
  before do
    @object = Rill::Object.parse_json({
      'link' => 'http://example.com/a-quick-update',
      'content'  => 'A quick update.',
      'objectType' => 'note'
    })
  end

  it 'should have a permalink' do
    @object.permalink.to_str.should == 'http://example.com/a-quick-update'
  end

  it 'should have content' do
    @object.content.should == 'A quick update.'
  end

  it 'should have the correct object type' do
    @object.should be_kind_of(Rill::ObjectTypes::Note)
  end
end

describe Rill::ObjectTypes::Note, 'with an invalid note' do
  it 'should raise a type error' do
    (lambda do
      Rill::Object.parse_json({
        'content'  => 42,
        'objectType' => 'note'
      })
    end).should raise_error(TypeError)
  end
end
