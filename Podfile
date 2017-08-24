source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/KurioApp/Specs.git'

# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'CuckooTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
    pod 'KurioLogger' #, :path => '../../Kurio-iPad/Kurio-iOS-Logger'
    pod 'KurioSDK'#, :path => '../kurio-ios-sdk'

  # Pods for CuckooTest

  target 'CuckooTestTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'Quick', :inhibit_warnings => true
    pod 'Nimble', :inhibit_warnings => true
    #Cuckoo stable version
    pod 'Cuckoo', :inhibit_warnings => true
    #Cuckoo issue https://github.com/Brightify/Cuckoo/issues/132
  end

  target 'CuckooTestUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
