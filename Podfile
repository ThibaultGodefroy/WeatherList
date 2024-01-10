inhibit_all_warnings!
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.7'

target 'SpaceX' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SpaceX
	pod 'UtilsKit'
	pod 'NetworkUtilsKit'

end

# Configuration
post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			
			if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
				xcconfig_path = config.base_configuration_reference.real_path
				IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
			end
			
			# iOS
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 14.7
			config.build_settings['SWIFT_VERSION'] = '5.9'
			
			# Sign
			config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
			config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
			config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
			
			# Warnings
			config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
			
			config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
			
			# Debug
			if config.name.include?('Debug')
				config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
			end
		end
	end
end

