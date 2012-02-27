//
//  PMTTYLogger.m
//  LumberJack
//
//  Created by Dave Carlton on 2/24/12.
//  Copyright (c) 2012 PolyMicro Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMTTYLogger.h"

@implementation PMFormatter

- (id)init
{
    if((self = [super init]))
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    return self;
}

NSString *PMExtractFileName(const char *filePath, BOOL copy);
NSString *PMExtractFileName(const char *filePath, BOOL copy) {
    NSString *path = [NSString stringWithCString:filePath encoding:NSUTF8StringEncoding];
    path = [path lastPathComponent];
    if (copy)
		return [[NSString alloc] stringByAppendingFormat:@"%@", path];
	else
		return path;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_FATAL     : logLevel = @"  FATAL"; break;
        case LOG_FLAG_ERROR     : logLevel = @"  ERROR"; break;
        case LOG_FLAG_WARN      : logLevel = @"WARNING"; break;
        case LOG_FLAG_NOTICE    : logLevel = @" NOTICE"; break;
        case LOG_FLAG_INFO      : logLevel = @"   INFO"; break;
        case LOG_FLAG_DEBUG     : logLevel = @"  DEBUG"; break;
        default                 : logLevel = @"    WTF"; break;
    }
    
    NSString *dateAndTime = [dateFormatter stringFromDate:(logMessage->timestamp)];
    
    NSString *logMsg = logMessage->logMsg;
    NSString *tail = @":";
    if ([logMsg length] == 0) {
        tail = @"";
    }
    NSString *rString = [NSString stringWithFormat:@"%@ %@ |", logLevel, dateAndTime];
    
    NSInteger context = (NSInteger)logMessage->logContext;
    switch (context) {
        case 0:
            rString = logMsg;
            break;
        case 1: 
            rString = [rString stringByAppendingFormat:@" %s%@ %@", logMessage->function, tail, logMsg];
            break;
        case 2:
            rString = [rString stringByAppendingFormat:@" %@[%u] %s%@ %@", PMExtractFileName(logMessage->file, NO), logMessage->lineNumber, logMessage->function, tail, logMsg];
            break;
        default:
            rString = logMsg;
            break;
    }    
    return rString;
}

//- (void)dealloc
//{
//    [dateFormatter release];
//    [super dealloc];
//}

@end
