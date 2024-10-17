Pod::Spec.new do |spec|
  spec.name         = "LiteAutoLayout"
  spec.version      = "1.0.0"
  spec.summary      = "LiteAutoLayout is a simple and useful library for you to create layout constraint for the views."
  s.homepage     = "https://github.com/MellongLau/LiteAutoLayout"
  s.screenshots  = "https://raw.github.com/MellongLau/LiteAutoLayout/master/Screenshots/screenshot.gif"
  s.license      = {:type => 'MIT', :file => 'LICENSE.md'}
  s.author       = {'Mellong Lau' => 'tendencystudio@gmail.com'} 
  s.source       = {:git => 'https://github.com/MellongLau/LiteAutoLayout.git', :tag => '1.0.0'}
  s.platform     = :ios, '12.0'
  s.source_files = 'LiteAutoLayout/*.{swift}'
  s.requires_arc = true
end
