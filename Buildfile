require 'bundler/setup'

$:.push File.expand_path("../lib", __FILE__)
require "jfastaes/version"

# add maven repositories
repositories.remote << 'http://www.ibiblio.org/maven2'
repositories.remote << 'http://repo1.maven.org/maven2'

define 'jfastaes' do
  project.version = JFastAES::VERSION
    
  # package our shiny little bidder jar
  package :jar, :file => _("lib/java/jfastaes-#{JFastAES::VERSION}.jar")
  
  task :setup => [ :clean, :compile, :package ]
end
