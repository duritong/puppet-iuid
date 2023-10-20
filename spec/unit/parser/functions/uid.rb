#! /usr/bin/env ruby


require File.dirname(__FILE__) + '/../../../spec_helper'

require 'fileutils'

def randomfilename
  filename = nil
  while filename.nil? || (filename && File.exist?(filename)) do
    filename = "/tmp/iuid.#{(rand*100).to_i}"
  end
  filename
end

describe "the iuid function" do

  before :each do
    @scope = Puppet::Parser::Scope.new
  end

  it "should exist" do
    Puppet::Parser::Functions.function('iuid').should == 'function_iuid'
  end

  it "should raise a ParseError if no argument is passed" do
    lambda { @scope.function_iuid }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if there is only one arguments" do
    lambda { @scope.function_iuid("foo") }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if there is more than 2 arguments" do
    lambda { @scope.function_iuid("foo", "bar", 'bad') }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if the configuration file does not exist" do
    puppet_confdir = randomfilename
    Dir.mkdir puppet_confdir
    File.exist?(File.join(puppet_confdir,'iuid.yaml')).should_not be_true

    lambda { @scope.function_iuid("foo", "bar") }.should( raise_error(Puppet::ParseError) ) 
    Dir.rmdir puppet_confdir
  end
end
