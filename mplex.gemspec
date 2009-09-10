Gem::Specification.new do |s|
  s.name = "mplex"
  s.version = "0.0.2"
  s.summary = "mplex"
  s.author = "FURUHASHI Sadayuki"
  s.email = "frsyuki@users.sourceforge.jp"
  #s.homepage = "http://.../"
  #s.rubyforge_project = "clx"
  s.require_paths = ["lib"]
  s.executables << "mplex"
	s.files = ["bin/**/*", "lib/**/*"].map {|g| Dir.glob(g) }.flatten +
		%w[README.md]
end
