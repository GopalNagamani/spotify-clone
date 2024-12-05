# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'spotify-clone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for spotify-clone
  pod 'Appirater'
  pod 'SDWebImage'
  pod 'Firebase/Analytics'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
  target 'spotify-cloneTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'spotify-cloneUITests' do
    # Pods for testing
  end

end
