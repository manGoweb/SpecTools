#
# Be sure to run `pod lib lint SpecTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpecTools'
  s.version          = '1.0.1'
  s.summary          = 'Library that helps you write less code when testing your iOS apps.'

  s.description      = 'Write less test code, this library contains a set of tools that are split in a few categories which have very specific helper functionality. All these are only available to their relevant elements.'

  s.homepage         = 'https://github.com/manGoweb/SpecTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ondrej Rafaj' => 'dev@mangoweb.cz' }
  s.source           = { :git => 'https://github.com/manGoweb/SpecTools.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rafiki270'

  s.ios.deployment_target = '10.3'

  s.source_files = 'SpecTools/Classes/**/*'

  s.requires_arc = true
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
