//
//  NSArray+String.m
//  SpotIt
//
//  Created by huang on 2022/9/5.
//

#import "NSArray+String.h"

@implementation NSArray (String)

- (NSString *)stringValue{
    NSString *str = @"";
    for (id item in self) {
        str = [NSString stringWithFormat:@"%@ %@", str, item];
    }
    return str;
}

@end
