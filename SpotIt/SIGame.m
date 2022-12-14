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
    NSArray *arr = @[@"đ§ââī¸",@"đ§",@"đ§ââī¸",@"đ§đģââī¸",@"đ§đģ",@"đ§đģââī¸",@"đ§đģââī¸",@"đ§đģ"];
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
    for (int i = 0; i < count; i++) { // åžĒį¯čŽĄįŽ7įģį´įēŋ
        NSArray *arr = [self generateGroupLines:reference[i] count:count];
        [retArr addObject:arr];
    }
    
    return retArr;
}

// įæä¸įģį´įēŋ
- (NSArray *)generateGroupLines:(NSArray *)singleReference count:(NSUInteger)count{
    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    for (int j = 0; j < count; j++) {
        NSArray *arr = [self generateLines:singleReference count:count index:j];
        [retArr addObject:arr];
    }
    return [retArr copy];
}

// įæä¸æĄį´įēŋ
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

// čŽĄįŽæģåąéčĻįåį´ īŧemojiãåžįīŧ
- (NSUInteger) totoalElementCount:(NSUInteger)elementsPerCards{
    return elementsPerCards +(elementsPerCards - 1) * (elementsPerCards - 1);
}

// įææ´äŊįæ å°čĄ¨
- (NSArray *)generateReference:(NSUInteger)count{
    NSMutableArray *segma = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSArray *segmaForI = [self generateSingleReference:count offset:i];
        [segma addObject:segmaForI];
    }
    return segma;
}

// įæåä¸Ēįæ å°čĄ¨
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
       @[@"đ",@"đĢĻ",@"đĻˇ",@"đ",@"đ",@"đĻģ",@"đ"],
       @[@"đŖ",@"đ",@"đ",@"đĢ",@"đĢ",@"đ§ ",@"đŖ"],
       @[@"đ¤",@"đĨ",@"đĢ",@"đļđģ",@"đ§đģ",@"đ§đģ",@"đĻđģ"],
       @[@"đŠđģ",@"đ§đģ",@"đ¨đģ",@"đŠđģâđĻą",@"đ§đģâđĻą",@"đ¨đģâđĻą",@"đŠđģâđĻ°"],
       @[@"đ§đģâđĻ°",@"đ¨đģâđĻ°",@"đąđģââī¸",@"đąđģ",@"đąđģââī¸",@"đŠđģâđĻŗ",@"đ§đģâđĻŗ"],
       @[@"đ¨đģâđĻŗ",@"đŠđģâđĻ˛",@"đ§đģâđĻ˛",@"đ¨đģâđĻ˛",@"đ§đģââī¸",@"đ§đģ",@"đ§đģââī¸"],
       @[@"đĩđģ",@"đ§đģ",@"đ´đģ",@"đ˛đģ",@"đŗđģââī¸",@"đŗđģ",@"đŗđģââī¸"],
   ];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSArray *sinleLineArr in arr) {
        [temp addObject:sinleLineArr];
    }
    return [temp copy];
}

@end
