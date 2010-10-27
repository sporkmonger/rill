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

require 'rill'
require 'json'

describe Rill, 'with a simple activity' do
  before do
    @stream = Rill.parse_json({
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
