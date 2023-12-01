target 'Gaurashtra' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod 'SVProgressHUD'
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'IQKeyboardManagerSwift'
    pod 'SkyFloatingLabelTextField'
    pod 'SWRevealViewController'
    pod 'PushNotifications'
    #pod 'FBSDKLoginKit'
   # pod 'GoogleSignIn'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'PushNotifications'
    pod 'CHIPageControl/Fresno'
    #pod 'YouTubePlayer'
    pod 'razorpay-pod', '1.2.5'
    pod 'Toast-Swift'
    pod 'SwiftSoup'
    #pod 'youtube-ios-player-helper'
    #pod 'IBMMobileFirstPlatformFoundation'
    #pod 'Paytm-Payments'
    #Pods for Gaurashtra
    
end


post_install do |installer|
    xcode_base_version = `xcodebuild -version | grep 'Xcode' | awk '{print $2}' | cut -d . -f 1`

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # For xcode 15+ only
             if config.base_configuration_reference && Integer(xcode_base_version) >= 15
                xcconfig_path = config.base_configuration_reference.real_path
                xcconfig = File.read(xcconfig_path)
                xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
                File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
            end
        end
    end
end
