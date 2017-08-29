#
# Be sure to run `pod lib lint SpecTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpecTools'
  s.version          = '0.1.0'
  s.summary          = 'Library that helps you write less code when testing interface in your iOS apps.'


  s.description      = 'Library that helps you write less code when testing interface in your iOS apps.
It contains a set of tools split in a few categories that have very specific helpers functionality only for relevant elements.'

  s.homepage         = 'https://github.com/manGoweb/SpecTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ondrej Rafaj' => 'dev@mangoweb.cz' }
  s.source           = { :git => 'https://github.com/manGoweb/SpecTools.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rafiki270'

  s.ios.deployment_target = '9.1'

  s.source_files = 'SpecTools/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SpecTools' => ['SpecTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
