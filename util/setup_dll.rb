require 'ffi'

lib_path = nil

candidates = [
  File.expand_path('../../.cache/spin/packages/raylib-bindings-0.0.0/lib', __dir__),
  File.expand_path('../lib', __dir__),
]

candidates.each do |dir|
  dir = File.expand_path(dir)
  if File.exist?(File.join(dir, 'raylib.rb'))
    $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
    require 'raylib'
    so = Dir.glob(File.join(dir, 'libraylib.*')).sort
    lib_path = so.last if so.any?
    break
  end
end

unless lib_path
  require 'raylib'
  spec = Gem::Specification.find_by_name('raylib-bindings')
  lib_path = Dir.glob(File.join(spec.full_gem_path, 'lib', 'libraylib.*')).sort.last
end

raise 'Could not find libraylib' unless lib_path
Raylib.load_lib(lib_path)
include Raylib
