//
//  SIGame.h
//  SpotIt
//
//  Created by huang on 2022/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIGame : NSObject

/// 生成卡片数组
/// - Parameter itemNumPerCard: 每张卡片展示的元素数
- (NSArray *)getAllCard:(NSUInteger)itemNumPerCard;

- (NSArray *)generateReference:(NSUInteger)elementsPerCards;

- (NSArray *)generateSingleReference:(NSUInteger)elementsPerCards offset:(NSUInteger)offset;

- (NSUInteger)totoalElementCount:(NSUInteger)elementsPerCards;

@end

NS_ASSUME_NONNULL_END
