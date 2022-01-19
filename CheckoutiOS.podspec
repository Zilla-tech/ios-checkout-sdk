#
#  Be sure to run `pod spec lint CheckoutiOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "CheckoutiOS"
  spec.version      = "0.0.1"
  spec.summary      = "Zilla Checkout SDK."

  spec.description  = <<-DESC
        Zilla checkout is an easy, fast and secure way for your users to buy now and pay later from your app. It is a drop in framework that allows you host the Zilla checkout application within your iOS application and allow customers make payments using any of the available payment plans.
                   DESC

  spec.homepage     = "https://zilla.africa"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Team Zilla" => "CheckoutiOS", "Zilla" => "boost@zilla.africa" }
  spec.platform     = :ios
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"
  spec.source = { :git => "https://github.com/Zilla-tech/ios-checkout-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "CheckoutiOS", "CheckoutiOS/**/*.{h,m,swift}"
  spec.exclude_files = "CheckoutiOS/Exclude"
  spec.public_header_files = "CheckoutiOS/**/*.h"
  spec.framework = "UIKit"
  spec.dependency 'Alamofire'

end
