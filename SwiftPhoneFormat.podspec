Pod::Spec.new do |s|

  s.name         = "SwiftPhoneFormat"
  s.version      = "1.0.0"
  s.summary      = "A framework for formatting phone numbers in Swift for iOS projects."
  s.description  = "A phone number string formatting framework designed and built for iOS in Swift."
  s.homepage     = "https://github.com/appteur/phoneformat.git"
  s.license      = { :type => 'INTERNAL', :file => 'LICENSE' }
  s.author       = "Seth Arnott"
  s.platform     = :ios, "10.0"
  s.source          = { :git => 'https://github.com/appteur/phoneformat.git', :tag => "#{s.version}" }
  s.source_files = 'SwiftPhoneFormat/*.{h,m,swift}', 'UIWidgetKit/**/*.{h,m,swift}'
#  s.resources = 'SwiftPhoneFormat/*.{storyboard,xib,xcassets}'
  s.swift_version = '4.1'
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }

#s.static_framework = true
  
end
  
