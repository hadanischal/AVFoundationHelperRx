#
# Be sure to run `pod lib lint AVFoundationHelperRx.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AVFoundationHelperRx'
  s.version          = '0.1.0'
  s.summary          = "AVFoundation helper classes which uses RxSwift"
  s.description          = 'AVFoundationHelperRx is AVFoundation helper classes which uses RxSwift for managing AVAssets and so on. These are used in turn by iOS specific classes..'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/hadanischal/AVFoundationHelperRx.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hadanischal@gmail.com' => 'hadanischal@gmail.com' }
  s.source           = { :git => 'https://github.com/hadanischal/AVFoundationHelperRx.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/neeschalhada'

  s.swift_version = '5.1'
  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.source_files = 'AVFoundationHelperRx/Classes/**/*'
  
  s.dependency 'RxSwift', '~> 5.0.1'
  s.dependency 'RxCocoa', '~> 5.0.1'

  # s.resource_bundles = {
  #   'AVFoundationHelperRx' => ['AVFoundationHelperRx/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
