//
//  Common.h
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (Common *)sharedInstance;

@property (nonatomic) int nymiHandle;
@property (strong, nonatomic) NSString *hashedToken;

@end
