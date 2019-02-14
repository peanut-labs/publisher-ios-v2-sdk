# PeanutLabs-iOS

[![CI Status](https://img.shields.io/travis/WinkowskiKonrad/PeanutLabs-iOS.svg?style=flat)](https://travis-ci.org/WinkowskiKonrad/PeanutLabs-iOS)
[![Version](https://img.shields.io/cocoapods/v/PeanutLabs-iOS.svg?style=flat)](https://cocoapods.org/pods/PeanutLabs-iOS)
[![License](https://img.shields.io/cocoapods/l/PeanutLabs-iOS.svg?style=flat)](https://cocoapods.org/pods/PeanutLabs-iOS)
[![Platform](https://img.shields.io/cocoapods/p/PeanutLabs-iOS.svg?style=flat)](https://cocoapods.org/pods/PeanutLabs-iOS)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PeanutLabs-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PeanutLabs-iOS'
```


# Peanut Labs Reward Center - Publisher iOS SDK

Peanut Labs connects your users with thousands of paid online surveys from big brands and market researchers. This SDK allows you to integrate our Reward Center within your iOS application. 

# The Reward Center

The Reward Center lists surveys and offers best suited for each of your members. It is highly customizable and positively engaging.

You get paid whenever your members complete a listing, and get to reward them back in the virtual currency of your choice.

All of this and much more is configured  and monitored through our Publisher Dashboard. To learn more and get access to our full set of tools, get in touch with us at publisher.integration@peanutlabs.com

# Integration

Check out <a href="http://peanut-labs.github.io/publisher-doc/" target="_blank">our integration guide</a> for step by step instructions on getting up and running with our Reward Center within your iOS application.

# Changelog

v2.0
- Code redesigned using swift and cocopod

v0.6
- Add program id support into ios SDK

v0.5
- Updated iOS SDK bar behavior
1. Hide sdk bar for profiler modal
2. Hide sdk bar for pre-screener modal
3. Hide sdk bar for survey landing page
4. 'Back' button for main reward center page sdk bar update

v0.4
- Changed "Done" button to "Home" button and replaced into right side
- Replaced "X" button to "Exit" and moved it to the right side
- After done with survey "Done" button led back to the application, changed it into lead back to rewards center
- Supports custom url parameters
- Supports date of birth url parameter
- Supports gender url parameter
- Automatically sets locale for rewards center depends on device locale

v0.3
- Activity Indicator does not cover the toolbar anymore
- Fixing the frequent connectivity error issue

v0.2
- Always generate new user Id if the user switches account
- Support for all orientations on the iPhone

## Initialize SDK

**If you are using the 'default' SDK manager, we reccomend initializing the sdk in the applications 'didFinishLaunchingWithOptions'**

``` Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let config = PeanutLabsConfig(appId: 'your app Id', appKey: 'your app key',
                                  endUserId: 'unique end user id', programId: 'program id (can be nil)')
                              
    // set isDebug to true if you want to get logs from the SDK
    PeanutLabsManager.default.isDebug = true                              

    PeanutLabsManager.default.initialize(with: config)

    return true
}
```

``` Objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    PeanutLabsManager *plManager = [PeanutLabsManager default];
    PeanutLabsConfig *config = [[PeanutLabsConfig alloc] initWithAppId:'your app id'
    appKey:'your app key'
    endUserId:'unique end user id'
    programId:'program id (can be nil)'];

    # set isDebug to true if you want to get logs from the SDK
    [plManager setIsDebug:true];

    [plManager initializeWith:config];

    return YES;
}

```

### Open Rewards Center.

**If you want to control which view controller the rewards center is presented on use:**

``` Swift
PeanutLabsManager.default.presentRewardsCenter(on: self, with: self)
```

``` Objective-c
[[PeanutLabsManager default] presentRewardsCenterOn:self with:self];
```

**If you want to present the rewards center just on top of your application use:**

``` Swift
PeanutLabsManager.default.presentRewardsCenterOnRoot(with: self)
```

``` Objective-c
[[PeanutLabsManager default] presentRewardsCenterOnRootWith:self];
```

### Add dob and gender as a parameter

``` Swift
Setting Dob // MM-DD-YYYY
PeanutLabsManager.default.dob = "MM-DD-YYYY"

Setting gender // PeanutLabsGenderMale or PeanutLabsGenderFemale
PeanutLabsManager.default.gender = PeanutLabsGender(.male|.female)
```

``` Objective-c
Setting gender // PeanutLabsGenderMale or PeanutLabsGenderFemale
[[PeanutLabsManager default] setGenderWithGender:PeanutLabsGenderMale|PeanutLabsGenderFemale];

Setting Dob // MM-DD-YYYY
[[PeanutLabsManager default] setDob:@"MM-DD-YYYY"];
```

### Adding a custom parameter

``` Swift
PeanutLabsManager.default.add(customVariable: "YOUR VALUE", forKey: "YOUR KEY")
```

``` Objective-c
[[PeanutLabsManager default] addWithCustomVariable:@"YOUR VALUE" forKey:@"YOUR KEY"];
```

## Author

Konrad Winkowski, konrad.winkowski@dynata.com
Derek Mordarski, derek.mordarski@dynata.com

## License

PeanutLabs-iOS is available under the MIT license. See the LICENSE file for more info.
