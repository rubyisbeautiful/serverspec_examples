require 'spec_helper'

describe 'foo.bar.com' do
  include_examples 'apache::init'
  include_examples 'db::init'
end
