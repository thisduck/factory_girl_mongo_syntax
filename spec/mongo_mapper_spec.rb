require "spec_helper"

require 'mongo_mapper'
require "factory_girl/syntax/mongo_mapper"

RSpec.configure do |config|
  MongoMapper.database = "factory_girl_mongomapper"
end

class User
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
  key :email, String
end

Factory.sequence(:email) { |n| "somebody#{n}@example.com" }
User.blueprint do
  first_name { 'Bill'                       }
  last_name  { 'Nye'                        }
  email      { FactoryGirl.generate(:email) }
end

describe "a mongo_mapper blueprint" do
  describe "after making an instance" do
    before do
      @instance = FactoryGirl.create(:user, :last_name => 'Rye')
    end

    it "should use attributes from the blueprint" do
      @instance.first_name.should == 'Bill'
    end

    it "should evaluate attribute blocks for each instance" do
      @instance.email.should =~ /somebody\d+@example.com/
      FactoryGirl.create(:user).email.should_not == @instance.email
    end
  end
end

describe "a factory using make syntax" do

  describe "after make" do
    before do
      @instance = User.make(:last_name => 'Rye')
    end

    it "should use attributes from the factory" do
      @instance.first_name.should == 'Bill'
    end

    it "should use attributes passed to make" do
      @instance.last_name.should == 'Rye'
    end

    it "should build the record" do
      @instance.should be_new_record
    end
  end

  describe "after make!" do
    before do
      @instance = User.make!(:last_name => 'Rye')
    end

    it "should use attributes from the factory" do
      @instance.first_name.should == 'Bill'
    end

    it "should use attributes passed to make" do
      @instance.last_name.should == 'Rye'
    end

    it "should save the record" do
      @instance.should_not be_new_record
    end
  end
end
