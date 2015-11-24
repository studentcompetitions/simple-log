#!/usr/bin/env ruby

if ARGV.include? '--all'
  system('docker-compose build') and sleep 3
  system('docker-compose run --rm simple-log rake db:create db:migrate') and
  system('docker-compose up -d')
else
  system('docker-compose build simple-log') and
  system('docker-compose run --rm simple-log rake db:migrate') and
  system('docker-compose up -d')
end
