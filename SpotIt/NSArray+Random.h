//
//  NSArray+Random.h
//  SpotIt
//
//  Created by huang on 2022/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Random)

/// 将数组中的元素随机打乱
- (NSArray *)random;
@end

NS_ASSUME_NONNULL_END
