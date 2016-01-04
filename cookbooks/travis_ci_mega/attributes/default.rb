default['travis_ci_mega']['prerequisite_packages'] = %w(
  cron
  curl
  git
  sudo
  wget
)

override['travis_system_info']['commands_file'] = \
  '/var/tmp/system-info-commands.yml'

override['travis_php']['multi']['versions'] = %w(
  5.6.15
  5.5.30
  5.4.45
)
override['travis_php']['multi']['aliases'] = {
  '5.4' => '5.4.45',
  '5.5' => '5.5.30',
  '5.6' => '5.6.15'
}
override['travis_php']['composer']['github_oauth_token'] = \
  '2d8490a1060eb8e8a1ae9588b14e3a039b9e01c6'

override['travis_perlbrew']['perls'] = [
  { name: '5.10', version: 'perl-5.10.1' },
  { name: '5.12', version: 'perl-5.12.5' },
  { name: '5.14', version: 'perl-5.14.4' },
  { name: '5.16', version: 'perl-5.16.3' },
  { name: '5.18', version: 'perl-5.18.4' },
  { name: '5.20', version: 'perl-5.20.0' },
  { name: '5.20-extras', version: 'perl-5.20.3',
    arguments: '-Duseshrplib -Duseithreads', alias: '5.20-shrplib' },
  { name: '5.22', version: 'perl-5.22.0' },
  { name: '5.22-extras', version: 'perl-5.22.0',
    arguments: '-Duseshrplib -Duseithreads', alias: '5.22-shrplib' },
  { name: '5.8', version: 'perl-5.8.8' }
]
override['travis_perlbrew']['modules'] = %w(
  Dist::Zilla
  Dist::Zilla::Plugin::Bootstrap::lib
  ExtUtils::MakeMaker
  LWP
  Module::Install
  Moose
  Test::Exception
  Test::Most
  Test::Pod
  Test::Pod::Coverage
)
override['travis_perlbrew']['prerequisite_packages'] = []

gimme_versions = %w(
  1.0.3
  1.1.2
  1.2.2
  1.3.3
  1.4.3
  1.5.2
  1.6beta1
)

override['gimme']['versions'] = gimme_versions
override['gimme']['default_version'] = gimme_versions.max

override['java']['jdk_version'] = '8'
override['java']['install_flavor'] = 'oracle'
override['java']['oracle']['accept_oracle_download_terms'] = true
override['java']['oracle']['jce']['enabled'] = true

override['travis_java']['default_version'] = 'oraclejdk8'
override['travis_java']['alternate_versions'] = %w(
  openjdk6
  openjdk7
  openjdk8
  oraclejdk7
  oraclejdk9
)

override['leiningen']['home'] = '/home/travis'
override['leiningen']['user'] = 'travis'

node_versions = %w(
  0.6.21
  0.8.28
  0.10.40
  0.11.16
  0.12.7
  4.1.2
)

override['nodejs']['versions'] = node_versions
override['nodejs']['aliases']['0.10'] = '0.1'
override['nodejs']['aliases']['0.11.16'] = 'node-unstable'
override['nodejs']['default'] = node_versions.max

pythons = %w(
  2.6.9
  2.7.10
  3.2.6
  3.3.6
  3.4.3
  3.5.0
  pypy-2.6.1
  pypy3-2.4.0
)

# Reorder pythons so that default python2 and python3 come first
# as this affects the ordering in $PATH.
%w(3 2).each do |pyver|
  pythons.select { |p| p =~ /^#{pyver}/ }.max.tap do |py|
    pythons.unshift(pythons.delete(py))
  end
end

def python_aliases(full_name)
  nodash = full_name.split('-').first
  return [nodash] unless nodash.include?('.')
  [nodash[0, 3]]
end

override['travis_python']['pyenv']['pythons'] = pythons
pythons.each do |full_name|
  override['travis_python']['pyenv']['aliases'][full_name] = \
    python_aliases(full_name)
end

rubies = %w(
  jruby-9.0.1.0
  1.9.3-p551
  2.0.0-p647
  2.1.7
  2.2.3
)

override['travis_build_environment']['default_ruby'] = rubies.reject { |n| n =~ /jruby/ }.max
override['travis_build_environment']['rubies'] = rubies

override['travis_kerl']['releases'] = %w(
  17.0
  17.1
  17.3
  17.4
  17.5
  R14B02
  R14B03
  R14B04
  R15B
  R15B01
  R15B02
  R15B03
  R16B
  R16B01
  R16B02
  R16B03
  R16B03-1
)

override['travis_build_environment']['update_hostname'] = false
override['travis_build_environment']['use_tmpfs_for_builds'] = false
override['travis_packer_templates']['job_board']['languages'] = %w(
  c
  c++
  clojure
  cplusplus
  cpp
  crystal
  csharp
  d
  dart
  default
  elixir
  erlang
  go
  groovy
  haxe
  java
  julia
  node_js
  perl
  php
  pure_java
  python
  r
  ruby
  rust
  scala
)
