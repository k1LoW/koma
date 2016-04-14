# Koma [![Gem](https://img.shields.io/gem/v/koma.svg)](https://rubygems.org/gems/koma) [![Build Status](https://travis-ci.org/k1LoW/koma.svg?branch=master)](https://travis-ci.org/k1LoW/koma)

Koma gather host inventory without agent.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koma'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install koma
```

## Usage

If you login remote server via `ssh example.com`, you can execute:

```sh
$ koma ssh example.com
```

And get stdout like [this](stdout_sample.json).

### Multi host gathering

```sh
$ koma ssh example.com,example.jp
{
  "example.com" : {
    ...
  },
  "example.jp" : {
    ...
  }
}
```

## Host inventory keys

```sh
$ koma keys
memory
ec2
hostname
domain
fqdn
platform
platform_version
filesystem
cpu
virtualization
kernel
block_device
package
user
group
service
```

## Contributing

1. Fork it ( https://github.com/k1LoW/koma/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
