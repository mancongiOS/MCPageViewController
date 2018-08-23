Pod::Spec.new do |s|

  s.name         = "MCPageViewController"
  s.version      = "1.1.1"
  s.summary      = "MCPageViewController."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = 'MCPageViewController by MC'

  s.homepage     = "https://github.com/mancongiOS/MCPageViewController"

  s.license      = "MIT"


  s.author             = { "MC" => "562863544@qq.com" }
  s.platform     = :ios


  s.source       = { :git => "https://github.com/mancongiOS/MCPageViewController.git", :tag => "#{s.version}" }

  s.source_files  = "MCPageViewController/*"
# s.exclude_files = "Classes/Exclude"

  s.frameworks = "Foundation", "UIKit"


end
