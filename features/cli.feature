Feature: The try subcommand
  In order to quickly try out a gem
  I want to start a repl with `gem try foo`

  Scenario Outline: Getting help
    When I run `bundle try <arg>`
    Then I should see the usage-instructions

    Examples:
      | arg    |
      | help   |
      | -h     |
      | --help |
      |        |

  Scenario: A simple gem
    When I run `bundle try some_gem`
    Then the generated Gemfile contains a line "gem 'some_gem'"

  Scenario: Multiple gems
    When I run `bundle try some_gem some_other_gem`
    Then the generated Gemfile contains a line "gem 'some_gem'" and a line "gem 'some_other_gem'"

  Scenario: Gem versions
    When I run `bundle try some_gem 1.2`
    Then the generated Gemfile contains a line "gem 'some_gem', '1.2'"

  Scenario: Gem versions and non-versioned gem
    When I run `bundle try some_gem 1.2 some_other_gem`
    Then the generated Gemfile contains a line "gem 'some_gem', '1.2'" and a line "gem 'some_other_gem'"

  Scenario Outline: Github gem
    When I run `bundle try <repos>`
    Then the generated Gemfile contains a line "gem 'sequel', github: 'jeremyevans/sequel'"

    Examples:
     | repos                                     | comment         |
     | https://github.com/jeremyevans/sequel     | url of page     |
     | https://github.com/jeremyevans/sequel.git | clone url       |
     | gh:jeremyevans/sequel                     | short notation  |

  Scenario: Github gem with tag
    When I run `bundle try https://github.com/rails/rails v4.2.1`
    Then the generated Gemfile contains a line "gem 'rails', github: 'rails/rails', ref: 'v4.2.1'"

  Scenario: Github gem with sha
    When I run `bundle try https://github.com/rails/rails f1ccb2e`
    Then the generated Gemfile contains a line "gem 'rails', github: 'rails/rails', ref: 'f1ccb2e'"

  Scenario: Github gem with a specific name
    When I run `bundle try redis@https://github.com/redis/redis-rb`
    Then the generated Gemfile contains a line "gem 'redis', github: 'redis/redis-rb'"

  Scenario: Github gem with a specific name using short notation
    When I run `bundle try redis@gh:redis/redis-rb`
    Then the generated Gemfile contains a line "gem 'redis', github: 'redis/redis-rb'"
