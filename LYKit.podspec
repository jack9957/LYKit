#
#  Be sure to run `pod spec lint LYKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LYKit"
  s.version      = "1.0.1"
  s.summary      = "LYKit for iOS App"
  s.homepage     = "https://github.com/liyang123/LYKit.git"
  s.license      = "MIT"
  s.author             = { "liyang.github.io" => "995720636@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/liyang123/LYKit.git", :tag => "1.0.1" }
  s.source_files  =  "LYKit", "LY_UIView/**/*.{h,m}", "LY_Object/**/*.{h,m}" 
  s.framework  = "UIKit"
    # s.dependency "JSONKit", "~> 1.4"

end
