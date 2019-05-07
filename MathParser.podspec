#
# Be sure to run `pod lib lint MathParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MathParser'
  s.version          = '1.3'
  s.summary          = 'A simple parser for Mathematical Expressions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MathParser is a pod that parses strings to decimal values. It allows addition, subtraction, multiplication, division, and exponent algebra.
                       DESC

  s.homepage         = 'https://github.com/jrosen081/MathParser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jrosen081' => 'jrosen081@gmail.com' }
  s.source           = { :git => 'https://github.com/jrosen081/MathParser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MathParser/Classes/**/*'

  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'MathParser' => ['MathParser/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
