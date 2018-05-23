Pod::Spec.new do |s|
  s.name         = "ViperKit"
  s.version      = "1.0.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "BradburyLab" => "kubancev@bradburylab.com" }
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.summary      = "ViperKit is a framework for implementing VIPER architecture in iOS application. It is inspired by Objective-C framework - VIPER McFlurry https://github.com/rambler-digital-solutions/ViperMcFlurry"

  s.source       = { :git => "https://github.com/kubancev/viper_kit_swift.git", :tag => "#{s.version}" }
  s.homepage     = 'https://github.com/kubancev/viper_kit_swift'

  s.framework = "UIKit"
  s.requires_arc = true
  s.source_files = "ViperKit/**/*.{swift,h,m}"
end
