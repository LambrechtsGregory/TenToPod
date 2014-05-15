Pod::Spec.new do |s|
  s.name             = "tentopod"
  s.version          = "0.1.0"
  s.summary          = "A library used to receive and register push messages from the 10topush webserver."
  s.homepage         = 'https://github.com/LambrechtsGregory/TenToPod'
  s.license          = 'MIT'
  s.author           = { "Gregory Lambrechts" => "lambrechts_gregory@hotmail.com" }
  s.requires_arc     = true
  s.source_files     = 'tentolib/tentolib/*.{h,m}'
  s.dependency 'SVHTTPRequest'
end
