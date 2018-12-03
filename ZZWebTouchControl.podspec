#
# Be sure to run `pod lib lint ZZWebTouchControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZZWebTouchControl"
  s.version          = "0.1.0"
  s.summary          = "仿微信，长按web二维码图片，识别出二维码内容."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "两种webView(UIWebView与WKWebView)的长按图片动作控制类，仿微信长按web二维码图片，解析出二维码内容. \n Two kinds of webView (UIWebView and WKWebView) long-press picture action control class, mimic the length of Wechat according to the web two-dimensional code picture, and parse the two-dimensional code content."

  s.homepage         = 'https://github.com/pengzz/ZZWebTouchControl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "pzz"
  s.source           = { :git => 'https://github.com/pengzz/ZZWebTouchControl.git', :branch => "master", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZZWebTouchControl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZZWebTouchControl' => ['ZZWebTouchControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
