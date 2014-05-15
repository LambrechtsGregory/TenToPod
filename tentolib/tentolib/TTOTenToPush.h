//
//  TenToPush.h
//  iostentopushsdk
//
//  Created by 10to1 on 16/04/14.
//  Copyright (c) 2014 10to1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#import "TTOInstall.h"
#import <SVHTTPRequest.h>

@interface TTOTenToPush : NSObject{
    
}

@property TTOInstall *install;
@property NSString *packageName;
@property NSString *secretKey;


+ (TTOTenToPush *)shared;
- (NSString *) deviceToken;
- (void)setupWithIdentifier:(NSString *)packageName token:(NSString *)secret;
- (void)registerTenToPush:(UIApplication *)application withInitializers:(UIRemoteNotificationType) types;
- (void)registerTenToPush:(UIApplication *)application;
- (void)registerDeviceToken:(NSString *) deviceToken;
- (NSString *) uniqueApid;
@end