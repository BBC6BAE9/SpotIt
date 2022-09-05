//
//  ViewController.m
//  SpotIt
//
//  Created by huang on 2022/9/4.
//

#import "ViewController.h"
#import "SIGame.h"
#import "NSArray+String.h"
#import "UIStyle.h"
#import "GameCollectionCell.h"
#import "UIView+Toast.h"
#import "NSArray+Random.h"

static NSString *cellIdentifier = @"collectioncell";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong)NSArray *cardArr;


@property(nonatomic, strong)UICollectionView *collectionView1;
@property(nonatomic, strong)UICollectionView *collectionView2;
@property(nonatomic, copy) NSArray *card1Arr;
@property(nonatomic, copy) NSArray *card2Arr;

@property(nonatomic, assign)double countPerLine;
@property(nonatomic, strong)UILabel *lb1;
@property(nonatomic, strong)UILabel *lb2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countPerLine = 1;
    UICollectionView *collectionView1 = [self createCollectionView];
    self.collectionView1 = collectionView1;
    collectionView1.backgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:collectionView1];
    
    UICollectionView *collectionView2 = [self createCollectionView];
    self.collectionView2 = collectionView2;
    collectionView2.backgroundColor = [UIColor lightGrayColor];
    collectionView2.frame = CGRectMake(0, NAV_HEIGHT + (SCREEN_HEIGHT - NAV_HEIGHT - mcBottomSafeHeight) / 2, [self collectionW], [self collectionH]);
    [self.view addSubview:collectionView2];
    
    SIGame *game = [[SIGame alloc] init];
    NSArray *cardArr = [game getAllCard:8];
    self.cardArr = cardArr;
    [self refresh];
}

- (UICollectionView *)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, [self collectionW], [self collectionH]) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //UICollectionViewCell 可以自定义
    [collectionView registerClass:[GameCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    return collectionView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self refresh];
}

- (void)refresh{
    NSUInteger rand1 = [self random:self.cardArr.count];
    NSUInteger rand2 = [self random:self.cardArr.count];
    NSArray *card1Arr = self.cardArr[rand1];
    self.card1Arr = [card1Arr random];
    NSArray *card2Arr = self.cardArr[rand2];
    self.card2Arr = [card2Arr random];
    double countPerLine = ceil(sqrt(card1Arr.count));
    self.countPerLine = countPerLine;
    [self refreshCollectionViews];
}

- (void)refreshCollectionViews{
    [self.collectionView1 reloadData];
    [self.collectionView2 reloadData];
}
- (NSUInteger)random:(NSUInteger)cardNo{
    return arc4random() % cardNo;
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.collectionView1){
        return self.card1Arr.count;
    }else{
        return self.card2Arr.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GameCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if(collectionView == self.collectionView1){
        cell.myLabel.text = self.card1Arr[indexPath.row];
    }else{
        cell.myLabel.text = self.card2Arr[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.collectionView1){
        NSString *selectEmoji = self.card1Arr[indexPath.row];
        if([self.card2Arr containsObject:selectEmoji]){
            [self toast:@"😊 匹配成功" completion:^(BOOL didTap) {
                            [self refresh];
            }];
        }else{
            [self toast:@"😫 匹配失败" completion:nil];
        }
    }else{
        NSString *selectEmoji = self.card2Arr[indexPath.row];
        if([self.card1Arr containsObject:selectEmoji]){
            [self toast:@"😊 匹配成功" completion:^(BOOL didTap) {
                [self refresh];
            }];
        }else{
            [self toast:@"😫 匹配失败" completion:nil];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellW = [self collectionW] / _countPerLine;
    CGFloat cellH = [self collectionH] / _countPerLine;
    return CGSizeMake(cellW, cellH);
}



- (CGFloat)collectionW{
    return SCREEN_WIDTH;
}

- (CGFloat)collectionH{
    return (SCREEN_HEIGHT - NAV_HEIGHT - mcBottomSafeHeight) / 2;
}

- (void)toast:(NSString *)str completion:(void(^)(BOOL didTap))completion{
    
    [self.view makeToast:str
                duration:3.0
                position:[NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)]
                   title:nil
                   image:[UIImage imageNamed:@"toast.png"]
                   style:nil
              completion:^(BOOL didTap) {
        if(completion){
            completion(didTap);
        }
    }];
}
@end
