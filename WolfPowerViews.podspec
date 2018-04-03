#
# Be sure to run `pod lib lint WolfPowerViews.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WolfPowerViews'
  s.version          = '0.2'
  s.summary          = 'A collection of views and view controllers that make app development more convenient.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A collection of views and view controllers that make app development more convenient. This was broken out from WolfCore, as many apps will not make use of this functionality. It is however, dependent on WolfCore.
                       DESC

  s.homepage         = 'https://github.com/wolfmcnally/WolfPowerViews'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wolfmcnally' => 'wolf@wolfmcnally.com' }
  s.source           = { :git => 'https://github.com/wolfmcnally/WolfPowerViews.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wolfmcnally'

  s.swift_version = '4.1'
  s.dependency 'SwiftLint'
  s.source_files = 'WolfPowerViews/Classes/**/*'

  s.ios.deployment_target = '9.3'

  # s.resource_bundles = {
  #   'WolfPowerViews' => ['WolfPowerViews/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'WolfCore', '~> 2.2'
end
