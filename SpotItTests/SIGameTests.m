//
//  SIGameTests.m
//  SpotItTests
//
//  Created by huang on 2022/9/4.
//

#import <XCTest/XCTest.h>
#import "SIGame.h"

@interface SIGameTests : XCTestCase

@end

@implementation SIGameTests

- (void)testGenerateSingleReferenceOffsetWithInvalidInput {
    SIGame *game = [[SIGame alloc] init];
    NSArray *ret = [game generateSingleReference:7 offset:8];
    NSArray *want = @[@[],@[]];
    XCTAssertEqualObjects(ret, want);
}

- (void)testGenerateSingleReferenceOffsetWithValidInput {
    SIGame *game = [[SIGame alloc] init];
    // Segma0
    {
        NSArray *ret = [game generateSingleReference:7 offset:0];
        NSArray *want = @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
        ];
        XCTAssertEqualObjects(ret, want);
    }
    // Segma4
    {
        NSArray *ret = [game generateSingleReference:7 offset:4];
        NSArray *want = @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(3),@(4),@(5),@(6),@(0),@(1),@(2)],
        ];
        XCTAssertEqualObjects(ret, want);
    }
    // Segma5
    {
        NSArray *ret = [game generateSingleReference:7 offset:5];
        NSArray *want = @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(2),@(3),@(4),@(5),@(6),@(0),@(1)],
        ];
        XCTAssertEqualObjects(ret, want);
    }
}

- (void)testGenerateReference{
    SIGame *game = [[SIGame alloc] init];
    NSArray *ret = [game generateReference:7];
    NSArray *want = @[
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(6),@(0),@(1),@(2),@(3),@(4),@(5)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(5),@(6),@(0),@(1),@(2),@(3),@(4)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(4),@(5),@(6),@(0),@(1),@(2),@(3)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(3),@(4),@(5),@(6),@(0),@(1),@(2)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(2),@(3),@(4),@(5),@(6),@(0),@(1)],
        ],
        @[
            @[@(0),@(1),@(2),@(3),@(4),@(5),@(6)],
            @[@(1),@(2),@(3),@(4),@(5),@(6),@(0)],
        ]
    ];
    XCTAssertEqualObjects(ret, want);
}

- (void)testTotoalElementCount {
    SIGame *game = [[SIGame alloc] init];
    NSUInteger ret = [game totoalElementCount:8];
    NSUInteger want = 57;
    XCTAssertEqual(ret, want);
}

- (void)testEmoji{
    XCTAssertNotEqualObjects(@"👩🏻‍🦳", @"👩🏻");
}

@end
