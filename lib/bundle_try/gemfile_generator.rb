module BundleTry
  class GemfileGenerator
    def initialize(args)
      @args = args
    end

    def grouped_args
      @args.each_with_object([]) do |arg, obj|
        if arg_is_version?(arg)
          obj[-1] << arg
        else
          obj << [arg]
        end
      end
    end

    def arg_is_version?(arg)
      arg[/v?\d+\.\d+/] ||
      arg[/^\h+$/]       ||
      arg[Gem::Requirement::PATTERN]
    end

    def group2gemline(group)
      result = begin
        case group.first
        when /\/\/github\.com/
          github = group.first[/github\.com\/(.+)(?:\.git)?$/, 1]
          name = if group.first.include?('@')
                   group.first.split('@').first
                 else
                   github.split('/').last
                 end
          { name: name, github: github, ref: group[1] }
        else
          { name: group[0], requirement: group[1] }
        end
      end
      result.delete_if {|_,v| v.nil? }
    end

    def gemlines
      gemlines = grouped_args.map {|g| group2gemline(g) }
      gemlines.map do |line|
        case
        when line[:github]
          s = "gem '#{line[:name]}', github: '#{line[:github]}'"
          s += ", ref: '#{line[:ref]}'" if line[:ref]
          s
        else
          s = "gem '#{line[:name]}'"
          s += ", '#{line[:requirement]}'" if line[:requirement]
          s
        end
      end
    end

    def generate
      return <<-EOF
source "https://rubygems.org"

#{gemlines.join("\n")}
EOF
    end
  end
end
