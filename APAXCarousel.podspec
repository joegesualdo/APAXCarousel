Pod::Spec.new do |s|
  s.name             = 'APAXCarousel'
  s.version          = '0.1.0'
  s.summary          = 'A simple to implement carousel for iOS'
 
  s.description      = <<-DESC
A simple to implement carousel for iOS.
                       DESC
 
  s.homepage         = 'https://github.com/joegesualdo/APAXCarousel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joe Gesualdo' => 'joegesualdo@gmail.com' }
  s.source           = { :git => 'https://github.com/joegesualdo/APAXCarousel.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'APAXCarousel/APAXCarouselController.swift'
 
end
