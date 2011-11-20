Puppet::Parser::Functions::newfunction(:iuid_set, :type => :rvalue, :doc =>
  "Provides the possibility to set (existing) values into the iuid database. Will return the value that have been set.
Example:

  iuid_set('some_name',1234)

  ") do |*args|
    args = args[0] if args[0].is_a?(Array)
    raise Puppet::ParseError, "Wrong number of arguments" unless args.length == 2

    configfile = File.join(File.dirname(Puppet.settings[:config]), "iuid.yaml")
    raise Puppet::ParseError, "Configuration file does not exist" unless File.exists?(configfile)

    raise(Puppet::ParseError, "You need rubygems to use iuid") unless Puppet.features.rubygems?

    require 'rubygems'
    require 'iuid'

    unless (result = Iuid.new(configfile).get(args[0])) == args[1]
      result = Iuid.new(configfile).set(args[0],args[1].to_i)
    end
    result
end
