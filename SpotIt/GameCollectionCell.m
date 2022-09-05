//
//  GameCollectionCell.m
//  SpotIt
//
//  Created by huang on 2022/9/5.
//

#import "GameCollectionCell.h"

@implementation GameCollectionCell

//重写初始化方法
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 70, 40)];
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.myLabel];
        //可以设置圆角
        self.layer.cornerRadius = 30;
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.myLabel.frame = CGRectMake(0, 0, w, h);
    self.myLabel.font = [UIFont systemFontOfSize:h / 3 * 2];
}
@end
