# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'HongikTimer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint'

  pod 'Firebase/Database'

  pod 'FirebaseAuth'
  pod 'GoogleSignIn'
  pod 'KakaoSDK'

  pod 'Toast-Swift', '~> 5.0.1'

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
  end
end

  # Pods for HongikTimer

  target 'HongikTimerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HongikTimerUITests' do
    # Pods for testing
  end

end
