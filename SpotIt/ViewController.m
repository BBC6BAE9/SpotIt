//
//  ViewController.m
//  SpotIt
//
//  Created by huang on 2022/9/4.
//

#import "ViewController.h"
#import "SIGame.h"
#import "NSArray+String.h"

@interface ViewController ()
@property(nonatomic, strong)NSArray *cardArr;
@property(nonatomic, strong)UILabel *lb1;
@property(nonatomic, strong)UILabel *lb2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenW = self.view.frame.size.width;
    CGFloat screenH = self.view.frame.size.height;
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,screenW, screenH / 2)];
    self.lb1 = lb1;
    lb1.font = [UIFont systemFontOfSize:30];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.backgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, screenH / 2,screenW, screenH / 2)];
    self.lb2 = lb2;
    lb2.font = [UIFont systemFontOfSize:30];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lb2];
    
    SIGame *game = [[SIGame alloc] init];
    NSArray *cardArr = [game getAllCard:8];
    self.cardArr = cardArr;
    [self refresh];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self refresh];
}

- (void)refresh{
    NSUInteger rand1 = [self random:self.cardArr.count];
    NSUInteger rand2 = [self random:self.cardArr.count];
    
    self.lb1.text = [self.cardArr[rand1] stringValue];
    self.lb2.text = [self.cardArr[rand2] stringValue];
}

- (NSUInteger)random:(NSUInteger)cardNo{
    return arc4random() % cardNo;
}

@end
