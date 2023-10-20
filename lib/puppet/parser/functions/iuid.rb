Puppet::Parser::Functions::newfunction(:iuid, :type => :rvalue, :doc =>
  "Provides an easy way to query (and generate) uids (by category) that are centrally
   stored.
   iuid will either retrieve an existing uid for a category/key or generate the next available
   uid. If this uid collides with a range of the next category an exception is raised.
   For each category a starting uid is configured, which will then also set the max uid by the
   next category. The global max uid is 4294967295 but can be configured via the configuration
   option `max_uid`.
   Further exceptions are raised if the the config file does not exist or a category is not configured.

   Example:

     user{'foo':
       uid => iuid('user1','webhosting');
     }
") do |*args|
    args = args[0] if args[0].is_a?(Array)
    raise Puppet::ParseError, "Wrong number of arguments" unless args.length == 2

    configfile = File.join(File.dirname(Puppet.settings[:config]), "iuid.yaml")
    raise Puppet::ParseError, "Configuration file does not exist" unless File.exist?(configfile)

    require 'iuid'

    Iuid.new(configfile).create(args[0],args[1])
end
