//
//  TTOInstall.h
//  tentopod
//
//  Created by 10to1 on 16/04/14.
//  Copyright (c) 2014 10to1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTOInstall : NSObject

- (NSDictionary*)jsonDictionary:(NSString *) deviceToken packageName:(NSString*)packageName secretKey:(NSString*) secretKey;


@end
