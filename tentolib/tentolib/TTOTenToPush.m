//
//  TenToPush.m
//  iostentopushsdk
//
//  Created by 10to1 on 16/04/14.
//  Copyright (c) 2014 10to1. All rights reserved.
//

#import "TTOTenToPush.h"
#import <UIKit/UIApplication.h>
#import "TTOInstall.h"
#import <SVHTTPRequest.h>

@implementation TTOTenToPush

+ (instancetype)shared
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


//Default app configurations. Package name + secret key received from 10to1.
- (void)setupWithIdentifier:(NSString *)packageName token:(NSString *)secret{
    [self setPackageName:packageName];
    [self setSecretKey:secret];
    [self setInstall:[[TTOInstall alloc] init]];
        
}

// Register with tokens.
- (void) registerTenToPush:(UIApplication *)application withInitializers:(UIRemoteNotificationType) types{
    [application registerForRemoteNotificationTypes: types];
}

//Default way of registering.
- (void) registerTenToPush:(UIApplication *)application{
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

//Register device token with 10to1 push server.
- (void)registerDeviceToken:(NSString *) deviceToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uniqueApid = [defaults objectForKey:@"deviceToken"];
    if(uniqueApid == nil){
        NSString *preparedDeviceToken = [self prepareDeviceToken:deviceToken];
        [defaults setObject:preparedDeviceToken forKey:@"deviceToken"];
        [defaults synchronize];
        NSLog(@"Data saved");
        NSLog(@"devicetoken");
        [self sendToBackEnd:preparedDeviceToken];
    }
}

//Delete all whitespaces and brackets from the device token for clean send to server.
- (NSString *) prepareDeviceToken: (NSString *)deviceToken
{
    NSString *dt = [deviceToken description];
    NSString *whiteSpaceString = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *first = [whiteSpaceString substringFromIndex:1];
    NSString *out = [first substringToIndex:first.length-(first.length>0)];
    return out;
}

//Returns device token.
- (NSString *) deviceToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *otherdevicetoken = [defaults objectForKey:@"deviceToken"];
    return otherdevicetoken;
}

//Returns unique apid.
- (NSString *) uniqueApid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *apid = [defaults objectForKey:@"uniqueApid"];
    return apid;
    
}

//Post to Installs API.
- (void) sendToBackEnd:(NSString *) deviceToken{
    
    NSLog(@"backend");
    
    [[SVHTTPClient sharedClient] setBasePath:@"http://push.maggie.10to1apps.be/"];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:@"api/installs" parameters: [[self install] jsonDictionary:deviceToken packageName:[self packageName] secretKey:[self secretKey]]
                           completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                               if(response != nil)
                               {
                                   NSLog(@"%@",response);
                                   NSString *apid =  [response valueForKey:@"unique_apid"];
                                   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                   [defaults setObject:apid forKey:@"uniqueApid"];
                                   [defaults synchronize];
                               }
                               else
                               {
                                    #ifdef DEBUG
                                    #define MyLog(str) NSLog(str,error);
                                    #endif
                               }
                           }];
    
}


@end
