#
# Be sure to run `pod lib lint PeanutLabs-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PeanutLabs-iOS'
  s.version          = '0.1.0'
  s.summary          = 'PeanutLabs iOS SDK pod'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Pod handles sewtting up and loading surveys on a custom view'

  s.homepage         = 'https://github.com/peanut-labs/publisher-ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WinkowskiKonrad' => 'konrad.winkowski@surveysampling.com' }
  s.source           = { :git => 'https://github.com/peanut-labs/publisher-ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'PeanutLabs-iOS/**/*.{swift}'
  
  # s.resource_bundles = {
  #   'PeanutLabs-iOS' => ['PeanutLabs-iOS/Assets/*.png']
  # }
  
end
