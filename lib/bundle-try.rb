require 'bundle_try/gemfile_generator'
require 'thor'

module BundleTry
  class Cli < Thor
    include Thor::Actions

    desc "try [OPTIONS]", "Try a gem"
    long_desc <<-D
    Some reallt long description
    D
    #method_option "gemspec", :type => :string, :banner => "Use the specified .gemspec to create the Gemfile"
    def help
      puts "A helping hand"
    end
  end
end
