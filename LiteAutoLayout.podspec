Pod::Spec.new do |spec|
  spec.name         = "LiteAutoLayout"
  spec.version      = "1.0.1"
  spec.summary      = "LiteAutoLayout is a simple and useful library for you to create layout constraint for the views."
  spec.homepage     = "https://github.com/MellongLau/LiteAutoLayout"
  spec.screenshots  = "https://raw.githubusercontent.com/MellongLau/LiteAutoLayout/refs/heads/master/layout_contraints.png"
  spec.license      = {:type => 'MIT', :file => 'LICENSE.md'}
  spec.author       = {'Mellong Lau' => 'tendencystudio@gmail.com'} 
  spec.source       = {:git => 'https://github.com/MellongLau/LiteAutoLayout.git', :tag => '1.0.1'}
  spec.platform     = :ios, '12.0'
  spec.source_files = 'LiteAutoLayout/*.{swift}'
  spec.swift_versions = '5.0'
  spec.requires_arc = true
end
