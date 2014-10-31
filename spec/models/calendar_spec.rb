require 'spec_helper'

describe Calendar do
  let(:user) { FactoryGirl.create(:user) }
before { @calendar = user.calendars.build(content: "Lorem ipsum") }
subject { @calendar }
it { should respond_to(:content) }
it { should respond_to(:user_id) }

it { should be_valid }

describe "when user_id is not present" do
before { @calendar.user_id = nil }
it { should_not be_valid }
end
end
