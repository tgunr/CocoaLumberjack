//
//  PMTTYLogger.h
//  LumberJack
//
//  Created by Dave Carlton on 2/24/12.
//  Copyright (c) 2012 PolyMicro Systems. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface PMFormatter : NSObject <DDLogFormatter>
{   
    NSDateFormatter *dateFormatter;
}

@end