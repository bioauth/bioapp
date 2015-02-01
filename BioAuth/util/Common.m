//
//  Common.m
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (Common *)sharedInstance {
    static Common *sharedInstance;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[Common alloc] init];
        }
        
        return sharedInstance;
    }
}

@end
