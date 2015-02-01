//
//  NymiKit.h
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "ncl.h"

@interface NymiKit : NSObject

@property (nonatomic) BOOL correctNclEventReceived;
@property (nonatomic) NclEventType waitOnEventType;
@property (nonatomic) NclEvent currentEvent;

- (id)init;

- (void)setEventTypeToWaitFor:(NclEventType)eventType;
- (void)waitNclForEvent;
- (void)discoverNymiBand;
- (void)agreeNymiBand:(int)withHandle;
- (void)provisionNymiBand:(int)withHandle;
- (void)findNymiBand;
- (void)validateNymiBand:(int)withHandle;
- (void)disconnectNymiBand:(int)withHandle;
- (void)stopScan;

@end
