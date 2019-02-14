#
# Be sure to run `pod lib lint PeanutLabs-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PeanutLabs-iOS'
  s.version          = '1.0.0'
  s.summary          = 'PeanutLabs iOS SDK pod'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Pod handles setting up and loading surveys on a custom view'

  s.homepage         = 'https://github.com/peanut-labs/publisher-ios-v2-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Konrad Winkowski' => 'konrad.winkowski@dynata.com',
                         'Derek Mordarski' => 'derek.mordarski@dynata.com'
  }
  s.source           = { :git => 'https://github.com/peanut-labs/publisher-ios-v2-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'PeanutLabs-iOS/**/*.{swift,h,xib}'
  
  # s.resource_bundles = {
  #   'PeanutLabs-iOS' => ['PeanutLabs-iOS/Assets/*.png']
  # }
  
end
