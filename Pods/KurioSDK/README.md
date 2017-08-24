# KurioSDK

[![CI Status](http://img.shields.io/travis/hendych/KurioSDK.svg?style=flat)](https://travis-ci.org/hendych/KurioSDK)
[![Version](https://img.shields.io/cocoapods/v/KurioSDK.svg?style=flat)](http://cocoapods.org/pods/KurioSDK)
[![License](https://img.shields.io/cocoapods/l/KurioSDK.svg?style=flat)](http://cocoapods.org/pods/KurioSDK)
[![Platform](https://img.shields.io/cocoapods/p/KurioSDK.svg?style=flat)](http://cocoapods.org/pods/KurioSDK)

## Requirements
Swift 3.0

## Installation

KurioSDK is available through [CocoaPods](http://cocoapods.org). <br />
<strong>(Don't forget to add the source specs, ask the author if you don't have
access to the Specs repo and kurio-ios-sdk repo)</strong> <br /> <br />
To install it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/KurioApp/Specs.git'

pod "KurioSDK"
```

## Development

KurioSDK will need accessToken for Authorization mechanism in Kurio Rest API.
You can use following access token "1228a8f7285c4037a5d6e029fe8abdad" for dummy access token.
How to set access token?
in your `AppDelegate.swift` insert this on following line :
```swift
func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        ServiceManager.api.accessToken = "1228a8f7285c4037a5d6e029fe8abdad"        
}
```

## Author

Hendy Christianto <br />
Email: hendy@kurio.co.id <br />
Facebook: hendy.christianto 

## License

KurioSDK is not available under any license.

Copyright (c) 2016 PT Kurio All Rights Reserved.

The software, documentation and any fonts accompanying this License
whether on disk, in read only memory, on any other media or in any other form (collectively
the “Software”) are licensed, not sold, to you by PT. Kurio.
(“Kurio”) for use only under the terms of this License, and Kurio reserves all rights
not expressly granted to you. The rights granted herein are limited to Kurio’s intellectual
property rights in the Kurio Software and do not include any other patents or
intellectual property rights. You own the media on which the Kurio Software is
recorded but Kurio and/or Kurio’s licensor(s) retain ownership of the Software
itself.

