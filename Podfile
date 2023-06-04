workspace 'Shopify-ITI.xcworkspace'

# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

project 'Shopify-ITI.xcodeproj'

target 'Shopify-ITI' do
  project 'Shopify-ITI'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
end

post_install do |installer|
  return if !installer
  project = installer.pods_project
  project_deployment_target = project.build_configurations.first.build_settings['IPHONEOS_DEPLOYMENT_TARGET']

  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
    target.build_configurations.each do |config|
      old_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      new_target = project_deployment_target
      next if old_target == new_target || old_target == nil || new_target == nil
      puts "    #{config.name}: #{old_target.yellow} -> #{new_target.green}"
      #config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = new_target
    end
  end
end
