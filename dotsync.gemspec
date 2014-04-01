Gem::Specification.new do |s|
  s.name             = 'dotsync'
  s.version          = '0.0.2'
  s.summary          = 'Sync your dotfiles.'
  s.description      = <<EOF
Easily sync your dotfiles in one place.
EOF

  s.files            = Dir['./*']
  s.executables      = %w(dotsync)
  s.has_rdoc         = false

  s.author           = 'Jay Chae'
  s.email            = 'jaychae2@gmail.com'
  s.homepage         = 'https://github.com/wayfare/dotsync'

  s.add_development_dependency 'rake'
end
