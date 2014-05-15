# tentopod

[![Version](http://cocoapod-badges.herokuapp.com/v/tentopod/badge.png)](http://cocoadocs.org/docsets/tentopod)
[![Platform](http://cocoapod-badges.herokuapp.com/p/tentopod/badge.png)](http://cocoadocs.org/docsets/tentopod)

## Requirements

## Installation

tentopod is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "tentopod"
To install run:	

	pod install

## Usage
Before you can use the 10topod library in your Xcode project, you first have to import the public header. Place the following line between your imports in your AppDelegate.m file:

	#import <TTOTenToPush.h>
Now the real fun starts. We'll start by registering your device to receive push notifications. Add the following block of code to your didFinishLaunchingWithOptions method. BE CAREFUL! Replace the IDENTIFIER and TOKEN constants with the data 10to1 gave you or the service won't work.

	[[TTOTenToPush shared]setupWithIdentifier:IDENTIFIER token:TOKEN];
    [[TTOTenToPush shared]registerTenToPush:[UIApplication sharedApplication]];
This will set up the push service to receive push messages the default way. For the more adventurous developers: We also built in a method to customize your push messages. Just pass on your default iOS notification badges as demonstrated below:

	[[TenToPush shared ] registerTenToPush: [UIApplication sharedApplication] withInitializers:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
This will do pretty much all the magic so you're almost done. There's just one more thing you have to do if you want to be able to send push messages to the client device. Add the top method to your AppDelegate.m file. This one will make sure that the devices get registered on the 10to1 webserver where the push messages are sent from. The second method is useful for error handling. 

	- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
	{
	    [[TTOTenToPush shared] registerDeviceToken: deviceToken];
    
	}
	
	- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
	{
		NSLog(@"Failed to get token, error: %@", error);
	}
These two methods are not essential for the service to work but they're sure useful if you want to do a bit more with your app than just receive push messages. getUniqueApid returns your unique 10to1 device identifier, getDeviceToken returns your APNS registration ID.

    [[TTOTenToPush shared] getUniqueApid ];
    [[TTOTenToPush shared] getDeviceToken ];


## Author

Gregory Lambrechts, lambrechts_gregory@hotmail.com

## License

tentopod is available under the MIT license. See the LICENSE file for more info.

=======
TenToPod
========

Development version of the iOS library for the 10topush service.
