# Bundle Try

Open a REPL with the gems you want to try.  
Inspired by [lein-try](https://github.com/rkneufeld/lein-try).

## Usage

Pick a gem, any gem:

```
$ bundle try redis
... some bundling ...
irb(main):001:0> Redis
=> Redis
```

Multiple gems:

```
$ bundle try redis rake
```

Specific version:

```
$ bundle try redis '3.1.0'
```

...or any requirement that would be understood by bundler:

```
$ bundle try redis '~> 3.1.0'
```

Mix and match with gems you don't care about the version:

```
$ bundle try redis '~> 3.1.0' rake gem3 '1.0'
```

Github repository:

```
$ bundle try https://github.com/jeremyevans/sequel # or the clone-url with .git
```

Specific github version:

```
$ bundle try https://github.com/jeremyevans/sequel 4.21.0
```

Prepend the gem-name when it can't be derived from the url:

```
$ bundle try redis@https://github.com/redis/redis-rb
```

No Gemfile will be saved, so it's save to run from an existing project-folder.
But if you need it:

```
$ bundle try rake > Gemfile
```

## Installation

```
gem install bundle-try
```

