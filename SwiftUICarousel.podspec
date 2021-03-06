#
# Be sure to run `pod lib lint SwiftUICarousel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftUICarousel'
  s.version          = '0.0.2'
  s.summary          = 'SwiftUI version of Carousel framework (beta)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      =  'SwiftUI version of Carousel. This framework can be used >= ios 13'

  s.homepage         = 'https://github.com/chauchinyiu/SwiftUICarousel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chauchinyiu' => 'chinyiu.chau@gmail.com' }
  s.source           = { :git => 'https://github.com/chauchinyiu/SwiftUICarousel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = "5.0"
  s.source_files = 'SwiftUICarousel/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftUICarousel' => ['SwiftUICarousel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
