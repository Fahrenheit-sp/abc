# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'ABC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for ABC

  pod 'AppsFlyerFramework'
  pod 'Firebase/Analytics'
  pod 'RevenueCat'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
        config.build_settings['ENABLE_BITCODE'] = 'NO'
      end
    end
  end

end
