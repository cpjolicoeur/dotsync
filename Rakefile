desc 'Installs the standalone binary'
task :install do
  #manifest = "dotsync.rb"

  File.open("dotsync", 'w') do |file|
    file.puts '#!/usr/bin/env ruby'
    file.puts '# encoding: utf-8'
    file.puts 'require "fileutils"'
    file << File.read("dotsync.rb")
    file.puts 'ConfigFile.execute'
    file.chmod 0755
  end

  FileUtils.mkdir_p "./bin"
  FileUtils.mv 'dotsync', "./bin"
end
