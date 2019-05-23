#
# Be sure to run `pod lib lint KKWechatPayHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KKWechatPayHelper'
  s.version          = '1.0.0'
  s.summary          = 'KKWechatPayHelper is a Tool for Wechat Pay.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
     KKWechatPayHelper is a Tool for Wechat Pay,Convenient and Fast Inheritance of Payment Function.
                       DESC

  s.homepage         = 'https://github.com/BradBin/KKWechatPayHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BradBin' => '820280738@qq.com' }
  s.source           = { :git => 'https://github.com/BradBin/KKWechatPayHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KKWechatPayHelper/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'KKWechatPayHelper' => ['KKWechatPayHelper/Assets/*.png']
  # }

  s.public_header_files = 'KKWechatPayHelper/Classes/**/*.h'
  s.requires_arc = true
  s.static_framework = true
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'WechatOpenSDK', '~> 1.8.4'
end
