require 'java'
require 'jfastaes/version'

# import the jRuby Extension
require File.expand_path("../java/jfastaes-#{JFastAES::VERSION}", __FILE__)
java_import 'org.github.tobsch.jfastaes.JFastAESLibrary'

JFastAESLibrary.new.load(JRuby.runtime, false)

