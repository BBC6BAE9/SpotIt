//
//  NSArray+Random.m
//  SpotIt
//
//  Created by huang on 2022/9/5.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (NSArray *)random {
    NSArray *arr = [self sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return arr;
}
@end
