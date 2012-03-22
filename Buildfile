require 'bundler/setup'

$:.push File.expand_path("../lib", __FILE__)
require "jfast_aes/version"

# add maven repositories
repositories.remote << 'http://www.ibiblio.org/maven2'
repositories.remote << 'http://repo1.maven.org/maven2'

define 'jfast_aes' do
  project.version = JFastAES::VERSION
  
  # package our shiny little bidder jar
  package :jar, :file => _("lib/java/jfastaes-#{JFastAES::VERSION}.jar")
  
  desc 'copy all dependent jars to lib folder'
  task :copy_dependencies do
    cp project.compile.dependencies.collect(&:to_s), project.path_to('lib/java') 
  end
  
  task :setup => [ :clean, :compile, :package, :copy_dependencies ]
end
