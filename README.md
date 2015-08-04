# Bundle Try

Open a REPL with the gems you want to try.  
Quick weekend-hack inspired by [lein-try](https://github.com/rkneufeld/lein-try).

## Installation

```
gem install bundle-try
```

## Usage

By default `bundle try some_gem` will start a Ruby REPL.  
To open a shell (i.e. to use gem executables) do: `bundle try --shell some_gem`.

Some examples:

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

Combined with gems that don't need a specific version:

```
$ bundle try redis '~> 3.1.0' rake gem_with_version '1.0'
```

Github repository:

```
$ bundle try https://github.com/jeremyevans/sequel # or the clone-url with .git
```

...or via the short notation:

```
$ bundle try gh:jeremyevans/sequel
```

Specific Github version:

```
$ bundle try gh:jeremyevans/sequel 4.21.0
```

Prepend the gem-name when it can't be derived from the url:

```
$ bundle try redis@gh:redis/redis-rb
```

Gem in a gist (see [the gist](https://gist.github.com/eval/66f7bfaf17d364ddd232) as an example of a minimum viable gem):

```
$ bundle try rot13@https://gist.github.com/eval/66f7bfaf17d364ddd232
```

Nothing will be written to the current directory, so it's save to run from an existing project-folder.
But if you need the Gemfile:

```
$ bundle try rake > Gemfile
```

Feeling lucky?

```
# Gemception
$ bundle try bundle-try
```


## Developing

Run the features:

```
$ bundle exec cucumber
```

## Is it any good?

Glad you ask! Yes, it's 'Cloons Approved'. This, as my Ruby-friend [Elizabeth](https://twitter.com/_elsapet) learned me, means that if this gem would've had a slightly bigger budget, there would be a nice Nespresso-like commercial with George himself vowing for this software.  

![image](assets/cloons-approved.png)

Thanks to [Odaeus](https://github.com/Odaeus) for the image.