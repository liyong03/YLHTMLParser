Pod::Spec.new do |s|
  s.name         = "YLHTMLParser"
  s.version      = "0.11"
  s.summary      = "HTML parser for OHAttributedLabel."
  s.homepage     = "https://github.com/liyong03/YLHTMLParser.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "liyong03" => "liyong03@gmail.com" }
  s.source       = { :git => "https://github.com/liyong03/YLHTMLParser.git", :tag => s.version.to_s }
  s.platform     = :ios, '6.0'
  s.source_files =  'YLHTMLParser'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end
