//
//  CWBubbleViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/13.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWBubbleViewController.h"
#import "SortTestHelper.h"
#import "SelectionSort.h"
#import "CWSortNumberView.h"
@interface CWBubbleViewController ()

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) BOOL isOrder;
@property(nonatomic, assign) int delay;
@property(nonatomic, strong) NSMutableArray *sortArray;
@end

@implementation CWBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delay = 0;
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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(sortAction:) userInfo:nil repeats:YES];
    [timer fire];
    _timer = timer;
    
}
- (void)sortAction:(NSTimer *)timer{
    if (self.delay > self.sortArray.count-2) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    CWSortNumberView *tempNumberView = self.sortArray[self.delay];
    if (tempNumberView.tag == 999) {
        self.delay += 1;
    }
    
    CWSortNumberView *minNumberView = self.sortArray[self.delay];
    
    [UIView animateWithDuration:0.5 delay: 0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CWSortNumberView *numberView1 = self.sortArray[self.delay];
        CWSortNumberView *numberView2 = self.sortArray[(self.delay + 1)];
        
        numberView1.backgroundColor = UIColorGreen;
        numberView2.backgroundColor = UIColorGreen;
        
        NSLog(@"%@-%@",numberView1.contentLabel.text,numberView2.contentLabel.text);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 delay: 0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            for (CWSortNumberView *numberView in self.view.subviews) {
                if (numberView.tag != 1000) {
                    numberView.backgroundColor = UIColorBlue;
                }else{
                    numberView.backgroundColor = UIColorRed;
                }
            }
        } completion:^(BOOL finished){
            self.delay += 1;
            CWSortNumberView *numberView1 = self.sortArray[self.delay + 1 ];
            if (numberView1.tag == 999) {
                self.delay += 1;
            }
        }];
    }];
    
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
        //设定标识
        numberView.tag = i;
        numberView.frame = CGRectMake((padding + width) * i + padding, 100, width, height );
        numberView.backgroundColor = UIColorBlue;
        [self.view addSubview:numberView];
        [self.dataSource addObject:numberView];
        
    }
    
    for (int i = 0; i < self.dataSource.count; i++) {
        [self.sortArray addObject:self.dataSource[i]];
        for( int j = i + 1 ; j < self.dataSource.count ; j ++ ){
            [self.sortArray addObject:self.dataSource[j]];
        }
        //添加尾部标识占位
        CWSortNumberView *numberView = [[CWSortNumberView alloc] init];
        numberView.tag = 999;
        numberView.contentLabel.text = @"999";
        
        [self.sortArray addObject:numberView];
    }
    for (int i = 0; i< self.sortArray.count; i++) {
        CWSortNumberView *numberView = self.sortArray[i];
        NSLog(@"numberView:%@",numberView.contentLabel.text);
    }
    
    
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (BOOL)canPopViewController{
    [_timer invalidate];
    _timer = nil;
    return YES;
}

- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}


@end
