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

### Gather remote host inventory

If you login remote server via `ssh example.com`, you can execute:

```sh
$ koma ssh example.com
```

And gather host inventory stdout like [this](stdout_sample.json).

### Gather local host inventory

```sh
$ koma exec
```

### Gather host inventory from multiple hosts

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

### Pro Tip: Gather host inventory from multiple hosts with ssh_config

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

$ cat ssh_config_tmp | koma ssh --key platform,platform_version
```

Use [sconb](https://github.com/k1LoW/sconb) to filter ~/.ssh/config.

```sh
$ sconb dump example_* | sconb restore | koma ssh --key platform,platform_version
```

Gather vagrant host inventory.

```sh
$ vagrant ssh-config | koma ssh --key cpu,kernel
```

### Rum command on remote hosts

```sh
$ koma run-command example.com,example.jp uptime
{
  "example.com": {
    "uptime": {
      "exit_signal": null,
      "exit_status": 0,
      "stderr": "",
      "stdout": " 00:18:10 up 337 days,  4:51,  1 user,  load average: 0.08, 0.02, 0.01\n"
    }
  },
  "example.jp": {
    "uptime": {
      "exit_signal": null,
      "exit_status": 0,
      "stderr": "",
      "stdout": " 00:10:09 up 182 days,  7:34,  1 user,  load average: 0.07, 0.03, 0.01\n"
    }
  }
}
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
