Feature: The try subcommand
  In order to quickly try out a gem
  I want to start a repl with `gem try foo`

  Scenario Outline: Getting help
    When I run bundle try "<arg>"
    Then I should see the usage-instructions

    Examples:
      | arg    |
      | help   |
      | -h     |
      | --help |
      |        |

  Scenario: A simple gem
    When I run bundle try "some_gem"
    Then the generated Gemfile contains a line "gem 'some_gem'"

  Scenario: Multiple gems
    When I run bundle try "some_gem some_other_gem"
    Then the generated Gemfile contains a line "gem 'some_gem'" and a line "gem 'some_other_gem'"

  Scenario: Gem versions
    When I run bundle try "some_gem 1.2"
    Then the generated Gemfile contains a line "gem 'some_gem', '1.2'"

  Scenario: Gem versions and non-versioned gem
    When I run bundle try "some_gem 1.2 some_other_gem"
    Then the generated Gemfile contains a line "gem 'some_gem', '1.2'" and a line "gem 'some_other_gem'"

  Scenario Outline: Github gem
    When I run bundle try "<repos>"
    Then the generated Gemfile contains a line "gem 'sequel', :github => 'jeremyevans/sequel'"

    Examples:
     | repos                                     | comment         |
     | https://github.com/jeremyevans/sequel     | url of page     |
     | https://github.com/jeremyevans/sequel.git | clone url       |
     | gh:jeremyevans/sequel                     | short notation  |

  Scenario: Github gem with tag
    When I run bundle try "https://github.com/jeremyevans/sequel 4.14.0"
    Then the generated Gemfile contains a line "gem 'sequel', :github => 'jeremyevans/sequel', :ref => '4.14.0'"

  Scenario: Github gem with sha
    When I run bundle try "https://github.com/jeremyevans/sequel d9ee20b"
    Then the generated Gemfile contains a line "gem 'sequel', :github => 'jeremyevans/sequel', :ref => 'd9ee20b'"

  Scenario: Github gem with a specific name
    When I run bundle try "redis@https://github.com/redis/redis-rb"
    Then the generated Gemfile contains a line "gem 'redis', :github => 'redis/redis-rb'"

  Scenario: Github gem with a specific name using short notation
    When I run bundle try "redis@gh:redis/redis-rb"
    Then the generated Gemfile contains a line "gem 'redis', :github => 'redis/redis-rb'"

  Scenario: Gist with gemname
    When I run bundle try "rot13@https://gist.github.com/eval/66f7bfaf17d364ddd232"
    Then the generated Gemfile contains a line "gem 'rot13', :gist => 'eval/66f7bfaf17d364ddd232'"

  Scenario: Gist without gemname
    When I run bundle try "https://gist.github.com/eval/66f7bfaf17d364ddd232"
    Then the output should contain "ArgumentError"

  Scenario: Start a shell
    When I run bundle try "some_gem --shell" interactively
    Then a shell should start

  Scenario Outline: Special requires
    When I run bundle try "<gem>"
    Then the generated Gemfile contains a line "gem '<gem>', :require => <requires>"

    Examples:
      | gem           | requires                            |
      | rails         | ["rails/all", "active_support/all"] |
      | activerecord  | ["active_record"]                   |
      | activesupport | ["active_support/all"]              |

