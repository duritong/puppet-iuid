#! /usr/bin/env ruby


require File.dirname(__FILE__) + '/../../../spec_helper'

require 'fileutils'

describe "the iuid_set function" do

  before :each do
    @scope = Puppet::Parser::Scope.new
  end

  it "should exist" do
    Puppet::Parser::Functions.function('iuid_set').should == 'function_iuid_set'
  end

  it "should raise a ParseError if no argument is passed" do
    lambda { @scope.function_iuid_set }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if there is only one arguments" do
    lambda { @scope.function_iuid_set("foo") }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if there is more than 2 arguments" do
    lambda { @scope.function_iuid_set("foo", "bar", 'bad') }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if the configuration file does not exist" do
    File.exist?('/tmp/iud.XXXXXX/iuid.yaml').should_not be_true

    lambda { @scope.function_iuid_set("foo", "bar") }.should( raise_error(Puppet::ParseError) ) 
  end
end
