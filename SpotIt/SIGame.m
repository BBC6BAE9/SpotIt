//
//  SIGame.m
//  SpotIt
//
//  Created by huang on 2022/9/4.
//

#import "SIGame.h"

@implementation SIGame

- (NSArray *)getAllCard:(NSUInteger)itemNumPerCard{
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    NSArray *groupArr = [self generateAllGroups:itemNumPerCard - 1];
    NSArray *arr = @[@"🧞‍♀️",@"🧞",@"🧞‍♂️",@"🧜🏻‍♀️",@"🧜🏻",@"🧜🏻‍♂️",@"🧚🏻‍♀️",@"🧚🏻"];
    for (int i = 0; i < groupArr.count; i++) {
        NSArray *singleGroupArr = groupArr[i];
        for (NSArray *card in singleGroupArr) {
            NSMutableArray *newArr = [[NSMutableArray alloc] init];
            [newArr addObject:arr[i]];
            [newArr addObjectsFromArray:card];
            [retArr addObject:newArr];
        }
    }
    [retArr addObject:arr];
    return retArr;
}

- (NSArray *)generateAllGroups:(NSUInteger)count{
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    NSArray *firstGroup = [self getFirstGroup:count];
    NSArray *groupsArr = [self generateGroups:count];
    [retArr addObject:firstGroup];
    [retArr addObjectsFromArray:groupsArr];
    return [retArr copy];
}

- (NSArray *)generateGroups:(NSUInteger)count{
    NSArray *reference = [self generateReference:count];
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) { // 循环计算7组直线
        NSArray *arr = [self generateGroupLines:reference[i] count:count];
        [retArr addObject:arr];
    }
    
    return retArr;
}

// 生成一组直线
- (NSArray *)generateGroupLines:(NSArray *)singleReference count:(NSUInteger)count{
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    for (int j = 0; j < count; j++) {
        NSArray *arr = [self generateLines:singleReference count:count index:j];
        [retArr addObject:arr];
    }
    return [retArr copy];
}

// 生成一条直线
- (NSArray *)generateLines:(NSArray *)singleReference count:(NSUInteger)count index:(NSUInteger)index{
    NSArray *arr = [self getFirstGroup:7];
    NSArray *lastLineReference = singleReference.lastObject;
    int next = -1;
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    
    for (int k = 0; k < arr.count; k++) {
        NSArray *tempArr = arr[k];
        if (-1 == next) {
            next = [lastLineReference[index] intValue];
        }
        NSString *emoji = tempArr[next];
        [retArr addObject:emoji];
        next = [lastLineReference[next] intValue];
    }
    return [retArr copy];
}

// 计算总共需要的元素（emoji、图片）
- (NSUInteger) totoalElementCount:(NSUInteger)elementsPerCards{
    return elementsPerCards +(elementsPerCards - 1) * (elementsPerCards - 1);
}

// 生成整体的映射表
- (NSArray *)generateReference:(NSUInteger)count{
    NSMutableArray *segma = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSArray *segmaForI = [self generateSingleReference:count offset:i];
        [segma addObject:segmaForI];
    }
    return segma;
}

// 生成单个的映射表
- (NSArray *)generateSingleReference:(NSUInteger)count offset:(NSUInteger)offset{
    if(count <= offset){
        return @[@[],@[]];
    }else{
        NSMutableArray *line1Array = [[NSMutableArray alloc] init];
        NSMutableArray *line2Array = [[NSMutableArray alloc] init];
        for (int i = 0; i<count; i++) {
            [line1Array addObject:@(i)];
            if (0 == offset){
                [line2Array addObject:@(i)];
            }else{
                [line2Array addObject:@((i + count - offset) % count)];
            }
            
        }
        return @[line1Array, line2Array];
    }
}

- (NSArray *)getFirstGroup:(NSUInteger)count{
    NSArray *arr = @[
       @[@"👄",@"🫦",@"🦷",@"👅",@"👂",@"🦻",@"👃"],
       @[@"👣",@"👁",@"👀",@"🫀",@"🫁",@"🧠",@"🗣"],
       @[@"👤",@"👥",@"🫂",@"👶🏻",@"👧🏻",@"🧒🏻",@"👦🏻"],
       @[@"👩🏻",@"🧑🏻",@"👨🏻",@"👩🏻‍🦱",@"🧑🏻‍🦱",@"👨🏻‍🦱",@"👩🏻‍🦰"],
       @[@"🧑🏻‍🦰",@"👨🏻‍🦰",@"👱🏻‍♀️",@"👱🏻",@"👱🏻‍♂️",@"👩🏻‍🦳",@"🧑🏻‍🦳"],
       @[@"👨🏻‍🦳",@"👩🏻‍🦲",@"🧑🏻‍🦲",@"👨🏻‍🦲",@"🧔🏻‍♀️",@"🧔🏻",@"🧔🏻‍♂️"],
       @[@"👵🏻",@"🧓🏻",@"👴🏻",@"👲🏻",@"👳🏻‍♀️",@"👳🏻",@"👳🏻‍♂️"],
   ];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSArray *sinleLineArr in arr) {
        [temp addObject:sinleLineArr];
    }
    return [temp copy];
}

@end
