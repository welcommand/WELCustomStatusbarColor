Pod::Spec.new do |s|
  s.name         = "WELCustomStatusbarColor"
  s.version      = "1.0.4"
  s.summary      = "Custom Statusbar Color."
  s.homepage     = "https://github.com/welcommand/WELCustomStatusbarColor"
  s.author       = { "WELCommand" => "ios_programming@163.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/welcommand/WELCustomStatusbarColor.git", :tag => s.version }
  s.source_files  = "WELCustomStatusbarColor/*"
  s.framework  = "UIKit","Foundation"
  s.library   = "objc"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
end
