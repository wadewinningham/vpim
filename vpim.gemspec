require 'rubygems'
require 'pp'
require 'rake'

def info(s)
  {
    :author => "Sam Roberts",
    :email => "vieuxtech@gmail.com",
    :homepage => "http://vpim.rubyforge.org",
    :rubyforge_project => "vpim",
  }.each do |k,v|
    s.send(k.to_s+"=", v)
  end
end

spec_vpim = Gem::Specification.new do |s|
  info(s)
  s.name              = "vpim"
  s.version           = "12.4.9" # `ruby stamp.rb`
  s.summary           = "iCalendar and vCard support for ruby"
  s.description       = <<'---'
This is a pure-ruby library for decoding and encoding vCard and iCalendar data
("personal information") called vPim.
---
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "CHANGES", "COPYING", "samples/README.mutt" ]

  candidates = FileList[
    'lib/vpim/**/*.rb',
    'lib/vpim.rb',
    'bin/*',
    'samples/*',
    'test/test_*.rb',
    'COPYING',
    'README',
    'CHANGES',
  ].to_a

  s.files             = candidates
  s.test_files        = Dir.glob("test/test_*.rb")
  s.executables       = FileList["bin/*"].map{|path| File.basename(path)}

  s.require_path      = "lib"
# s.add_dependency("plist")
# s.autorequire       = "vpim"
end

#pp [spec_vpim, spec_vpim.instance_variables]

spec_vpim_icalendar = Gem::Specification.new do |s|
  info(s)
  s.name              = "vpim_icalendar"
  s.version           = "1.1"
  s.summary           = "Virtual gem depending on vPim's iCalendar support for ruby"
  s.description       = <<'---'
This is a virtual gem, it exists to depend on vPim, which provides iCalendar
support for ruby. You can install vPim directly.
---
  s.add_dependency("vpim")
end

#require 'hoe'
#
#Hoe.new(spec_vpim.name, spec_vpim.version) do |p|
#  p.rubyforge_name = "vpim"
#  p.remote_rdoc_dir = '' # Release to root
#end
#

if $0==__FILE__
  Gem::Builder.new(spec_vpim).build
  Gem::Builder.new(spec_vpim_icalendar).build
end

