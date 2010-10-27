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

require 'rill/activity'
require 'json'

describe Rill::Activity do
  before do
    @activity = Rill::Activity.new
  end

  it 'should raise a type error for an invalid actor' do
    (lambda do
      @activity.actor = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid verb' do
    (lambda do
      @activity.verb = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid object' do
    (lambda do
      @activity.object = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid target' do
    (lambda do
      @activity.target = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid timestamp' do
    (lambda do
      @activity.time = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid generator' do
    (lambda do
      @activity.generator = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid provider' do
    (lambda do
      @activity.provider = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid title' do
    (lambda do
      @activity.title = 42
    end).should raise_error(TypeError)
  end

  it 'should raise a type error for an invalid body' do
    (lambda do
      @activity.body = 42
    end).should raise_error(TypeError)
  end

  it 'should correctly handle timestamps as strings' do
    @activity.time = '1994-11-05T08:15:30-05:00'
    @activity.time.year.should == 1994
    @activity.time.month.should == 11
    @activity.time.day.should == 5
    @activity.time.hour.should == 13
    @activity.time.min.should == 15
    @activity.time.sec.should == 30
    @activity.time.zone.should == 'UTC'
  end

  it 'should correctly handle timestamps as time objects' do
    @activity.time = Time.parse('1994-11-05T08:15:30-05:00')
    @activity.time.year.should == 1994
    @activity.time.month.should == 11
    @activity.time.day.should == 5
    @activity.time.hour.should == 13
    @activity.time.min.should == 15
    @activity.time.sec.should == 30
    @activity.time.zone.should == 'UTC'
  end
end

describe Rill::Activity, 'parsed from empty string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Activity.parse_json('')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Activity, 'parsed from invalid JSON string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Activity.parse_json('This is not JSON.')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Activity, 'parsed from invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json(42)
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'parsed from empty string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Activity.new.parse_json('')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Activity, 'parsed from invalid JSON string' do
  it 'should raise a JSON parse error' do
    (lambda do
      Rill::Activity.new.parse_json('This is not JSON.')
    end).should raise_error(JSON::ParserError)
  end
end

describe Rill::Activity, 'parsed from invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.new.parse_json(42)
    end).should raise_error(TypeError)
  end
end

shared_examples_for 'empty activity' do
  it 'should parse an empty activity' do
    @activity.actor.should be_nil
    @activity.verb.should == 'post' # Default verb
    @activity.object.should be_nil

    @activity.target.should be_nil
    @activity.time.should be_nil
    @activity.generator.should be_nil
    @activity.provider.should be_nil
    @activity.title.should be_nil
    @activity.body.should be_nil
  end
end

describe Rill::Activity, 'with an empty activity' do
  before do
    @activity = Rill::Activity.parse_json({})
  end

  it_should_behave_like 'empty activity'
end

describe Rill::Activity, 'with an empty unparsed activity' do
  before do
    @activity = Rill::Activity.parse_json('{}')
  end

  it_should_behave_like 'empty activity'
end

describe Rill::Activity, 'with an empty activity' do
  before do
    @activity = Rill::Activity.new.parse_json({})
  end

  it_should_behave_like 'empty activity'
end

describe Rill::Activity, 'with an empty unparsed activity' do
  before do
    @activity = Rill::Activity.new.parse_json('{}')
  end

  it_should_behave_like 'empty activity'
end

describe Rill::Activity, 'with an object that contains invalid actor' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'actor' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid verb' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'verb' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid object' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'object' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid target' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'target' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid time' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'postedTime' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid generator' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'generator' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid provider' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'provider' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid title' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'title' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with an object that contains invalid body' do
  it 'should raise a type error' do
    (lambda do
      Rill::Activity.parse_json({'body' => 42})
    end).should raise_error(TypeError)
  end
end

describe Rill::Activity, 'with a complex activity' do
  before do
    @activity = Rill::Activity.parse_json({
      'actor' => {
        'displayName' => 'Alice'
      },
      'verb' => 'share',
      'object' => {
        'content' => 'This is a shared post.',
        'link' => 'http://www.examples.com/post/12345',
        'objectType' => 'note'
      },
      'target' => {
        'displayName' => 'Bob'
      },
      'postedTime' => '1994-11-05T08:15:30-05:00',
      'generator' => {
        'displayName' => 'ACME Smartphone App'
      },
      'provider' => {
        'displayName' => 'ACME Activity Aggregator',
        'link' => 'http://www.acme.com/activity/aggregator'
      },
      'title' => 'Alice shared a post with Bob.',
      'body' =>
        'Alice shared a post with Bob: ' +
        '<div class="post">This is a shared post.</div> ' +
        'Sent from an ACME Smartphone.'
    })
  end

  it 'should have an actor' do
    @activity.actor.name.should == 'Alice'
  end

  it 'should have a verb' do
    @activity.verb.should == 'share'
  end

  it 'should have an object' do
    @activity.object.content.should == 'This is a shared post.'
    @activity.object.permalink.to_str.should ==
      'http://www.examples.com/post/12345'
  end

  it 'should have an object' do
    @activity.target.name.should == 'Bob'
  end

  it 'should have a timestamp' do
    @activity.time.year.should == 1994
    @activity.time.month.should == 11
    @activity.time.day.should == 5
    @activity.time.hour.should == 13
    @activity.time.min.should == 15
    @activity.time.sec.should == 30
    @activity.time.zone.should == 'UTC'
  end

  it 'should have a generator' do
    @activity.generator.name.should == 'ACME Smartphone App'
  end

  it 'should have a service provider' do
    @activity.provider.name.should == 'ACME Activity Aggregator'
    @activity.provider.permalink.to_str.should ==
      'http://www.acme.com/activity/aggregator'
  end

  it 'should have a title' do
    @activity.title.should == 'Alice shared a post with Bob.'
  end

  it 'should have a body' do
    @activity.body.should ==
      'Alice shared a post with Bob: ' +
      '<div class="post">This is a shared post.</div> ' +
      'Sent from an ACME Smartphone.'
  end
end
