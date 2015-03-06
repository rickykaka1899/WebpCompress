Pod::Spec.new do |s|  
  s.name             = "myWebpCompress"
  s.version          = "1.0.0"  
  s.summary          = "A demo to use webp format."
  s.description      = <<-DESC  
                       It is a marquee view used on iOS, which implement by Objective-C.  
                       DESC  
  s.homepage         = "https://github.com/rickykaka1899/WebpCompress"
  s.license          = 'MIT'  
  s.author           = { "houlzh" => "houlzh@yonyou.com" }
  s.source           = { :git => "https://github.com/rickykaka1899/WebpCompress.git" }
  s.platform     = :ios, '7.0'
  s.requires_arc = false
  
  s.source_files = 'ImageCompress/*'

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
