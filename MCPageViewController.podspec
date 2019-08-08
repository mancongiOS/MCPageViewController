#
# Be sure to run `pod lib lint MCPageViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
    s.name         = "MCPageViewController"
    s.version      = "5.4.2"
    s.summary      = "分页控制器： 支持分类栏在navigationBar上，滑动置顶等功能。"
    s.homepage     = "https://github.com/mancongiOS/MCPageViewController"
    s.license      = "MIT"
    s.author             = { "MC" => "562863544@qq.com" }
    s.platform     = :ios, "7.0"
    s.source       = { :git => "https://github.com/mancongiOS/MCPageViewController.git", :tag => "#{s.version}" }
    s.source_files = 'MCPageViewController/Classes/**/*'
    s.swift_version = '5.0'
    s.ios.deployment_target = '8.0'
    
    s.dependency 'SnapKit'
    
    
end
