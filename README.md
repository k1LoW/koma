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

### Gather multiple hosts

```sh
$ koma ssh example.com,example.jp
{
  "example.com": {
    ...
  },
  "example.jp": {
    ...
  }
}
```

### Pro Tip: Gather multiple hosts with ssh_config

```sh
$ cat <<EOF > ssh_config_tmp
Host example_com
  User k1low
  Hostname example.com
  PreferredAuthentications publickey
  IdentityFile /path/to/example_rsa

Host example_jp
  User someone
  Hostname example.jp
  PreferredAuthentications publickey
  IdentityFile /path/to/more/example_jp_rsa
EOF

$ cat ssh_config_tmp | koma ssh
```

Gather vagrant box host inventory.

```sh
$ vagrant ssh-config | koma ssh --key cpu,kernel
```

Use [sconb](https://github.com/k1LoW/sconb).

```sh
$ sconb dump example.com | sconb restore | koma ssh --key platform,platform_version
```

## Host inventory keys

```sh
$ koma keys
memory
ec2 (disabled)
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
