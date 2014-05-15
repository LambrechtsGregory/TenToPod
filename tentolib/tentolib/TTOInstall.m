//
//  Install.m
//  iostentopushsdk
//
//  Created by 10to1 on 16/04/14.
//  Copyright (c) 2014 10to1. All rights reserved.
//

#import "TTOInstall.h"
#import <SVHTTPRequest.h>

@implementation TTOInstall

-(id) init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
    }
    return self;
}

//Post to Installs API.
- (NSDictionary*)jsonDictionary:(NSString *) deviceToken packageName:(NSString*)packageName secretKey:(NSString *)secretKey{
    NSDictionary* out;
    NSDictionary* params;
    
    out = @{ @"package_name" : packageName, @"secret_key" : secretKey, @"install" : params =@{
                                                            @"type" : @"IosInstall",
                                                            @"unique_apid" : @"",
                                                            @"device_token" : deviceToken,}};
    
    return out;
}



@end

