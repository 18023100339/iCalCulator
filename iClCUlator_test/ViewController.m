//
//  ViewController.m
//  iClCUlator_test
//
//  Created by Liu_zc on 2019/7/18.
//  Copyright © 2019 Liu_zc. All rights reserved.
//

#import "ViewController.h"
#import "Calculate.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import <AVFoundation/AVFoundation.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#define Width    [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

NSString *collectID = @"CollectionView";
float font;
BOOL nagetive = NO;

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UILabel *EquationLabel;
//@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) NSArray *sign;
@property (nonatomic, strong) NSString *Equ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.Equ = @"";
    [self loadCollectionView];

    [self loadResult];

    [self loadEquation];
}


- (void) loadCollectionView {
    CGFloat toBotSpace = Height * 0.05;
    CGFloat space = Height * (1 - 0.618);
    CGFloat ColHeight = Height - space  - toBotSpace;
    CGFloat ColWidth = Width - (Width * 0.0869);
//    if (ColHeight > ColWidth)
    CGFloat cellSizeWidth = Width * 0.186;
    CGFloat cellSizeHeigh = cellSizeWidth;
    self.sign = [NSArray array];
    self.sign = @[@"AC",@"(",@")",@"÷",
                  @"7",@"8",@"9",@"×",
                  @"4",@"5",@"6",@"-",
                  @"1",@"2",@"3",@"+",
                  @"0",@"√(",@".",@"="];
    
    UICollectionViewFlowLayout *Layout = [[UICollectionViewFlowLayout alloc] init];  //布局方式
    Layout.minimumLineSpacing = (ColHeight - 5 * cellSizeHeigh)/4 ; //行距
    Layout.minimumInteritemSpacing = 8;  //列距
    Layout.itemSize = CGSizeMake(cellSizeWidth, cellSizeHeigh); //每个cell的尺寸
    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 380, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:Layout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 88, 88) collectionViewLayout:Layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewLayout = Layout;
    self.collectionView.backgroundColor = RGB(0, 0, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectID];

    self.collectionView.sd_layout.topSpaceToView(self.view, space).widthIs(ColWidth).heightIs(ColHeight).centerXIs(Width/2);
    
}

- (void) loadResult {
    self.resultLabel = [UILabel new];
    [self.view addSubview:self.resultLabel];
    self.resultLabel.sd_layout.bottomSpaceToView(self.collectionView, 15).widthIs(Width - 40).heightIs(Height * 0.1116).centerXIs(Width/2);
    
    self.resultLabel.backgroundColor = RGB(0, 0, 0);
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    self.resultLabel.textAlignment = NSTextAlignmentRight;
    self.resultLabel.font = [UIFont fontWithName:@"PingFangTC-Light" size:Height * 0.1];
    self.resultLabel.textColor = RGB(254, 254, 254);
    self.resultLabel.text = @"0";
}

- (void) loadEquation {
    self.EquationLabel = [UILabel new];
    [self.view addSubview:self.EquationLabel];
    self.EquationLabel.sd_layout.bottomSpaceToView(self.collectionView, Height * 0.1116 + 15 + Height * 0.0279).leftSpaceToView(self.view, 0).widthIs(Width).heightIs(Height * 0.1339);
    
    font = Height * 0.11;
    self.EquationLabel.backgroundColor = RGB(1, 1, 1);
    self.EquationLabel.adjustsFontSizeToFitWidth = YES;
    self.EquationLabel.textAlignment = NSTextAlignmentRight;
    self.EquationLabel.font = [UIFont fontWithName:@"PingFangTC-Light" size:font];
    self.EquationLabel.textColor = RGB(254, 254, 254);
    self.EquationLabel.text = @"";
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20; //个数
}
///
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *playImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width * 0.186, Width * 0.186)];
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width * 0.126, Width * 0.126)];
    [cell addSubview:playImage];
    [cell addSubview:signLabel];
    ///设置圆
    playImage.contentMode = UIViewContentModeScaleAspectFit;
    playImage.layer.cornerRadius = playImage.frame.size.width/2; //把这个jpeg削圆
    ///设置符号
    signLabel.backgroundColor = [UIColor clearColor];
    signLabel.sd_layout.centerYEqualToView(cell).centerXEqualToView(cell);
    signLabel.text = self.sign[indexPath.row];
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UIFont fontWithName:@"PingFangTC-Semibold" size:Width * 0.0773];
    ///设置颜色
    if (indexPath.row - 3 < 0) {
    playImage.backgroundColor = RGB(144, 144, 144);  //这里测色计测出来是36，36，36？
        signLabel.textColor = RGB(0, 0, 0);
    } else if ((indexPath.row + 1)%4 == 0) {
    playImage.backgroundColor = RGB(255, 126, 0);
        signLabel.textColor = RGB(255, 255, 255);
    } else {
    playImage.backgroundColor = RGB(40, 40, 40);
        signLabel.textColor = RGB(255, 255, 255);
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   static BOOL isSelect = YES;
    
    if (indexPath.row == 0) {
        self.Equ = @"";
        self.resultLabel.text = @"0";
        font = Height * 0.11;
        self.EquationLabel.text = self.Equ;
        isSelect = YES;
    
    
    }  else if (indexPath.row != 19){

        
        
        if ((indexPath.row + 1)%4 == 0) {
//        if ((indexPath.row == 3 || indexPath.row == 3) {
        
            if (indexPath.row == 11) {
                self.Equ = [self.Equ stringByAppendingString:self.sign[indexPath.row]];
            } else {
            if (isSelect == NO) {
            self.Equ = [self.Equ stringByAppendingString:self.sign[indexPath.row]];
            }
            isSelect = YES;
            }
            
        } else {
            self.Equ = [self.Equ stringByAppendingString:self.sign[indexPath.row]];
            isSelect = NO;
        }

    } else {
            ///等于号的事件
        if (isSelect == NO) {
            Calculate *clu = [[Calculate alloc] init];
            NSLog(@"点了等于号%@",self.Equ);
            NSString *stringFloat = [NSString stringWithFormat:@"%f",[clu clculate:self.Equ]];
            self.resultLabel.text = [self removeFloatAllZeroByString:stringFloat];
            isSelect = NO;
        }
        
    }
    self.EquationLabel.text = self.Equ;
}
- (NSString*)removeFloatAllZeroByString:(NSString *)testNumber{
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}
//- (void)handleDeviceOrientationChange:(NSNotification *)notification{
//
//
//}


- (void)viewWillLayoutSubviews{
    
    //1.获取到屏幕旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //2.根据屏幕旋转方向布局子视图
    switch (orientation) {
            //竖直方向
        case UIDeviceOrientationPortrait:
            //倒立
        case UIDeviceOrientationPortraitUpsideDown:
        {
            
        }
            break;
            
            //右横屏
        case UIDeviceOrientationLandscapeRight:
        {
//            self.resultLabel.sd_resetLayout.bottomSpaceToView(self.collectionView, 15).heightIs(Width - 40).widthIs(Height * 0.1116).centerXIs(Width/2);
            
        }
            break;
            //左横屏
        case UIDeviceOrientationLandscapeLeft:
        {
            
            
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
