//
//  SelectionSortViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SelectionSortViewController.h"
#import "SortTestHelper.h"
#import "SelectionSort.h"
#import "CWSortNumberView.h"
@interface SelectionSortViewController ()

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) BOOL isOrder;
@end

@implementation SelectionSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self reloadData];
    
}
- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:self.isOrder ? @"重置" : @"排序" position:QMUINavigationButtonPositionRight target:self action:@selector(handleOrderItemEvent)];
}



- (void)handleOrderItemEvent {
    self.isOrder = !self.isOrder;
    
    //执行动画
    if (self.isOrder) {
        [self sortAnimation];
    }else{
        [self reloadData];
    }
    [self setNavigationItemsIsInEditMode:NO animated:NO];
   
}



- (void)sortAnimation{

    NSLog(@"执行动画");
    NSTimeInterval delay = 1;
    for (int i = 0; i < self.dataSource.count; i++) {
        __block int minIndex = i;
        for( int j = i + 1 ; j < self.dataSource.count ; j ++ ){
            delay += 1;
            NSLog(@"delay:%f",delay);
            [UIView animateWithDuration:1 delay: delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                for (CWSortNumberView *numberView in self.view.subviews) {
                    numberView.backgroundColor = UIColorBlue;
                }
                CWSortNumberView *number_minIndex = self.dataSource[minIndex];
                CWSortNumberView *number_j = self.dataSource[j];
                number_minIndex.backgroundColor = UIColorGreen;
                number_j.backgroundColor = UIColorGreen;
            } completion:nil];
            
        }
    }
    

    
}
- (void)sortAction{
    NSLog(@"执行动画");
    for (int i = 0; i < self.dataSource.count; i++) {
        __block int minIndex = i;
        for( int j = i + 1 ; j < self.dataSource.count ; j ++ ){
            for (CWSortNumberView *numberView in self.view.subviews) {
                numberView.backgroundColor = UIColorBlue;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CWSortNumberView *number_minIndex = self.dataSource[minIndex];
                CWSortNumberView *number_j = self.dataSource[j];
                number_minIndex.backgroundColor = UIColorGreen;
                number_j.backgroundColor = UIColorGreen;
                if ([number_j.contentLabel.text intValue] < [number_minIndex.contentLabel.text intValue]) {
                    minIndex = j;
                    
                }
            });
            
        }
    }
}



- (void)reloadData{
    
    CGFloat width = 32;
    CGFloat height = width;
    CGFloat padding = 8;
    
    for (CWSortNumberView *numberView in self.view.subviews) {
        [numberView removeFromSuperview];
    }
    [self.dataSource removeAllObjects];
    [_timer invalidate];
    _timer = nil;
    
    for (int i = 0; i < 10; i++) {
        int number = arc4random_uniform(100);
        CWSortNumberView *numberView = [[CWSortNumberView alloc] init];
        numberView.contentLabel.text = [NSString stringWithFormat:@"%d",number];
        numberView.frame = CGRectMake((padding + width) * i + padding, 100, width, height );
        numberView.backgroundColor = UIColorBlue;
        [self.view addSubview:numberView];
        [self.dataSource addObject:numberView];
    }
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}



@end
