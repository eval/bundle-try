## 1.6.1

### Fixed

 * Generated Gemfile is ruby 1.9.3 compatible
 * Output of `bundle install` appeared in the generated Gemfile.

## 1.6.0

### Added

 * instead of a repl you can now start a shell:

        $ bundle try rake --shell
        Bundling...
        bash> bundle exec rake --version

## 1.5.0

### Fixed

 * Massive refactor

### Added

 * the changelog
 * gist-support

        $ bundle try rot13@https://gist.github.com/eval/66f7bfaf17d364ddd232
        Bundling...
        > "123".rot13

