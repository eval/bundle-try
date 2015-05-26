require 'mustache'

module BundleTry
  VERSION_LIKE_RE = [Gem::Requirement::PATTERN, /v?\d+\.\d+/, /^\h+$/].freeze

  def self.parse_args(args)
    args.each_with_object([]) do |arg, obj|
      matches_arg = arg.method(:match).to_proc
      if VERSION_LIKE_RE.detect(&matches_arg)
        obj[-1] << arg
      else
        obj << [arg]
      end
    end
  end

  def self.argv_to_gemlines(argv)
    parse_args(argv).map {|args| Gemline.new(*args) }
  end

  class Gemline
    REQUIREMENTS = {
      'rails' => %w(rails/all active_support/all),
      'activerecord' => %w(active_record),
      'activesupport' => %w(active_support/all),
    }.freeze

    attr_reader :versionlike, :namelike

    def initialize(namelike, versionlike = nil)
      @namelike = namelike
      @versionlike = versionlike
    end

    def name
      case
      when namelike[/@/]
        namelike.split('@').first
      when github?
        github.split('/').last
      when gist?
        raise ArgumentError, "Provide the name of the gem that is contained in the gist. e.g. 'awesome_gem@#{namelike}'"
        namelike.split('@').first
      else
        namelike
      end
    end

    def ref
      github? && versionlike
    end

    def github?
      namelike[/\/\/github\.com|gh:/]
    end

    def gist?
      namelike[/gist\.github\.com/]
    end

    def regular?
      namelike == name
    end

    def gist
      namelike[/gist\.github\.com\/(.*)$/, 1]
    end

    def github
      namelike[/(?:github\.com\/|gh:)(?:(.*)\.git|(.*))$/]
      $1 || $2
    end

    def requires
      REQUIREMENTS[name].inspect if REQUIREMENTS[name]
    end
  end

  class Gemfile < Mustache
    def template
      <<template
source "https://rubygems.org"

{{#gemlines}}
{{#github?}}
gem '{{ name }}', :github => '{{ github }}'{{#ref}}, :ref => '{{ref}}'{{/ref}}{{#requires}}, :require => {{{requires}}}{{/requires}}
{{/github?}}
{{#gist?}}
gem '{{ name }}', :gist => '{{ gist }}'{{#ref}}, :ref => '{{ref}}'{{/ref}}
{{/gist?}}
{{#regular?}}
gem '{{ name }}'{{#versionlike}}, '{{{ versionlike }}}'{{/versionlike}}{{#requires}}, :require => {{{requires}}}{{/requires}}
{{/regular?}}
{{/gemlines}}
template
    end
  end
end
