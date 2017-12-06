Pod::Spec.new do |s|
  s.name         = "BTCustomAlertController"
  s.version      = "0.9.0"
  s.summary      = "One simple nice custom alertview"
  s.description  = "One simple nice custom alertview addtion with cocoapod support."
  s.homepage     = "https://github.com/BulletTrain/BTCustomAlertController"
  s.social_media_url   = "http://blog.iflytek.cc/"
  s.license= { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Rachael" => "bullettrain1433@gmail.com" }
  s.source       = { :git => "https://github.com/BulletTrain/BTCustomAlertController.git", :tag => s.version }
  s.source_files = "BTCustomAlertController/*.{h,m}"
  s.ios.deployment_target = '8.0'
  s.frameworks   = 'UIKit'
  s.requires_arc = true
  s.subspec "CommonElement" do |ss|
    ss.dependency "CommonElement"
    ss.xcconfig = { "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/CommonElement"}
  end

end