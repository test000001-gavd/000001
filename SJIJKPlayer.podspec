Pod::Spec.new do |s|
  s.name             = 'SJIJKPlayer'
  s.version          = '1.0.0'
  s.summary          = 'IJKPlayer 独立模块'
  s.homepage         = 'https://github.com/test000001-gavd/000001'
  s.source           = { :git => 'https://github.com/test000001-gavd/000001.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'IJKPlayer/**/*.{h,m}'
  s.dependency 'IJKMediaFramework'  # 核心依赖:cite[6]

  s.author       = { "Your Name" => "your.email@example.com" } 
  s.license      = { :type => "MIT", :file => "LICENSE" }
end
