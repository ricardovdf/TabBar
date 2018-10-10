Pod::Spec.new do |s|

  s.name         = "TabBar"
  s.version      = "0.0.1"
  s.summary      = "OWOW TabBar."                  
  s.homepage     = "https://github.com/ricardovdf/TabBar"
  s.license      = "MIT"
  s.author       = { "Dennis Dreissen" => "dennis@owow.io" }
  s.platform     = :ios,
  s.ios.deployment_target = "11.0"
  s.requires_arc = true

  # s.source = { :git => "https://github.com/ricardovdf/TabBar.git", :tag => "#{s.version}" }
  # s.source = { :path => '.' }
  s.source_files  = "TabBar", "TabBar/**/*.{h,m,swift}"
  
  s.dependency 'SnapKit', '~> 4.0.0'

end
