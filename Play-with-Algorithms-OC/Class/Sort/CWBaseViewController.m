//
//  CWBaseViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/15.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWBaseViewController.h"

@interface CWBaseViewController ()

@end

@implementation CWBaseViewController

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
    if (self.dataSource.count == 0) {
        return;
    }
    [QMUITips showSucceed:[NSString stringWithFormat:@"本次排序总共进行了 %ld 次计算",self.stateArray.count] inView:self.view hideAfterDelay:1];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sortAction:) userInfo:nil repeats:YES];
    [timer fire];
    _timer = timer;
    
}
- (void)sortAction:(NSTimer *)timer{
    if (self.index > self.stateArray.count-1) {
        [_timer invalidate];
        _timer = nil;
        for (CWSortNumberView *numberView in self.view.subviews) {
            numberView.backgroundColor = UIColorBlue;
        }
        [QMUITips showSucceed:@"排序成功" inView:self.view hideAfterDelay:2];
        return;
    }
    
    [UIView animateWithDuration:0.8 delay: 0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        NSArray *states = self.stateArray[self.index];
        for (int i = 0; i < states.count; i++) {
            CWSortModel *model = states[i];
            CWSortNumberView *numberView = self.dataSource[i];
            numberView.model = model;
        }
        
    } completion:^(BOOL finished){
        self.index += 1;
    }];
    
}



- (void)reloadData{
    
}
- (void)setupStateMachine{
    //子类重写
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

- (NSMutableArray *)stateArray{
    if (!_stateArray) {
        _stateArray = [NSMutableArray array];
    }
    return _stateArray;
}

- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
