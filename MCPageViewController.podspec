#
# Be sure to run `pod lib lint MCPageViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
    s.name         = "MCPageViewController"
    s.version      = "3.1"
    s.summary      = "MCPageViewController for Swift.Public"
    s.homepage     = "https://github.com/mancongiOS/MCPageViewController"
    s.license      = "MIT"
    s.author             = { "MC" => "562863544@qq.com" }
    s.platform     = :ios, "7.0"
    s.source       = { :git => "https://github.com/mancongiOS/MCPageViewController.git", :tag => "#{s.version}" }
    s.source_files = 'MCPageViewController/Classes/**/*'
    s.swift_version = '4.2'
    s.ios.deployment_target = '8.0'
    
    s.dependency 'SDWebImage'
    s.dependency 'SDWebImage/GIF'
    
    
end
