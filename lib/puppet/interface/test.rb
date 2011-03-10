require 'puppet/interface'
require 'puppet/tools/module'
require 'puppet/tools/compile'
require 'find'
include Puppet::Tools::Module
include Puppet::Tools::Compile
# inherits from interface b/c they is no indirector
Puppet::Interface.new(:test) do

  # check for any tests that may be missing
  action(:check_tests) do |*args|
    @modulepath = set_modulepath(options[:modulepath])
    code = get_code(@modulepath,
                    :get_tests => true, 
                    :include_modules => options[:include_modules],
                    :exclude_modules => options[:exclude_modules]
                   )[:untested]
  end

  # compile all tests
  action(:compile_tests) do |*args|
    @modulepath = set_modulepath(options[:modulepath])
    @run_noop = options[:run_noop]
    code = get_code(@modulepath, 
                    :get_tests => true,
                    :include_modules => options[:include_modules],
                    :exclude_modules => options[:exclude_modules]
                   )
    results = compile_module_tests(code[:tests], @run_noop)
  end
end
