//
//  CWMergeProcessViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/15.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWMergeProcessViewController.h"

@interface CWMergeProcessViewController ()
@property(nonatomic, strong) UIView *originStateView;
@property(nonatomic, strong) UIView *compareStateView;

@property(nonatomic, strong) NSMutableArray *numbers;

@end

@implementation CWMergeProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)reloadData{
    NSLog(@"reloadData");
    CGFloat width = 35;
    CGFloat height = width;
    CGFloat padding = 8;
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    [self.dataSource removeAllObjects];
    [self.numbers removeAllObjects];
    [self.timer invalidate];
    self.timer = nil;

    int count = 8;
    int state = 2 ;
    
    //随机化数字
    for (int i = 0; i < count; i++) {
        int number = arc4random_uniform(100);
        [self.numbers addObject:[NSString stringWithFormat:@"%d",number]];
    }
    
    for (int i = 0; i < state ; i++ ) {
        UIView *stateView = [UIView new];
        [self.view addSubview:stateView];
        stateView.frame = CGRectMake(2 * padding, 100 + (padding * 3 + height ) * i, self.view.frame.size.width - 4 * padding , height);
        CGFloat magin = (stateView.frame.size.width - count * width) / (count  + 2);
        if ( i == 0) {
            //先暂时隐藏
            self.originStateView = stateView;
        }else{
            self.compareStateView = stateView;
            
        }
        for (int j = 0; j < count; j++) {
            int number = [self.numbers[j] intValue];
            CWSortNumberView *numberView = [[CWSortNumberView alloc] init];
            numberView.frame = CGRectMake((magin + width) * j + magin, 0, width, height );
            
            CWSortModel *model = [[CWSortModel alloc] init];
            model.numberText = [NSString stringWithFormat:@"%d",number];
            model.backgroundColor = UIColorBlue;
            
            numberView.model = model;
            [stateView addSubview:numberView];
        }
    }
    
    CWSortNumberView *numberView = self.compareStateView.subviews[3];
    
    CGFloat lineX = CGRectGetMaxX(numberView.frame) + 4;
    UIView *line = [UIView new];
    line.tag = 999;
    line.frame = CGRectMake(lineX, 0, 1, numberView.frame.size.height);
    [self.compareStateView addSubview:line];
    line.backgroundColor = UIColorRed;

}

- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [NSMutableArray array];
    }
    return _numbers;
}

@end
