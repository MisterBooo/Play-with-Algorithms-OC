//
//  CWMergeSortViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/15.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWMergeSortViewController.h"
#import "CWSortNumberView.h"
#import "UIColor+CWRandom.h"
#import <math.h>
#import "SortTestHelper.h"
@interface CWMergeSortViewController ()
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, assign) BOOL isOrder;
//排序完成标识
@property(nonatomic, assign) BOOL animtionEndFlag;

//存放状态
@property(nonatomic, strong) NSMutableArray *views;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) int index;
@property(nonatomic, strong) NSMutableArray *numbers;
@property(nonatomic, strong) NSMutableArray *mergeStates;
@property(nonatomic, strong) UIView *stateView;

@end

@implementation CWMergeSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadData];
}

- (void)reloadData{
    self.index = 0;
    CGFloat width = 35;
    CGFloat height = width;
    CGFloat padding = 8;
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    self.animtionEndFlag = false;
    [self.dataSource removeAllObjects];
    [self.numbers removeAllObjects];
    [_timer invalidate];
    _timer = nil;

   
    
    int count = 8;
    int state = 3 ;//取以②为底count的对数
    
    //随机化数字
    for (int i = 0; i < count; i++) {
        int number = arc4random_uniform(100);
        [self.numbers addObject:[NSString stringWithFormat:@"%d",number]];
    }
    
    for (int i = 0; i < state + 2; i++ ) {
        UIView *stateView = [UIView new];
        [self.view addSubview:stateView];
        stateView.frame = CGRectMake(2 * padding, 100 + (padding * 3 + height ) * i, self.view.frame.size.width - 4 * padding , height);
        CGFloat magin = (stateView.frame.size.width - count * width) / (count  + 2);
        if ( i > 0) {
        //先暂时隐藏
            stateView.alpha = 0;
            [self.dataSource addObject:stateView];
        }else{
            self.stateView = stateView;

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

    //保存归并排序状态机
    self.mergeStates = [[SortTestHelper shareInstance] getMergeStates:self.numbers];
    NSLog(@"self.mergeStates:%@",self.mergeStates);
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(megerSortAction) userInfo:nil repeats:YES];
    [timer fire];
    _timer = timer;
  
}
- (void)megerSortAction{
    if (self.index > self.dataSource.count - 1) {
        if (self.animtionEndFlag) {
            [_timer invalidate];
            _timer = nil;
            [QMUITips showSucceed:@"排序成功" inView:self.view hideAfterDelay:2];
        }else{
            //显示归并排序动画
            if (self.index - 4 >= self.mergeStates.count) {
                self.animtionEndFlag = YES;
                return;
            }
           
            UIView *statesView = self.stateView;
            NSArray *numbers = self.mergeStates[self.index - 4];
          
            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                for (int i = 0; i < statesView.subviews.count; i++) {
                    CWSortNumberView *numberView = statesView.subviews[i];
                    CWSortModel *model = [CWSortModel new];
                    model.backgroundColor = UIColorRed;
                    model.numberText = numbers[i];
                    numberView.model = model;
                }
            } completion:^(BOOL finished) {
                self.index += 1;
            }];
            
        }
    }else{
        //显示View
        UIView *stateView = self.dataSource[self.index];
        UIView *endView = self.dataSource.lastObject;
        NSInteger count = self.numbers.count;

        //画线
        
        //线的条数
        int linesCount = (int) pow(2.0, self.index * 1.0);
        NSLog(@"linesCount:%d",linesCount);
        //保存分割线
        NSMutableArray *lines = [NSMutableArray array];
        //分割线所在的位置满足最小二叉树
        /*
                  4                 0
              2       6             1
            1   3   5   7           2
         
        */
        NSMutableArray *tree = [NSMutableArray array];
        if (linesCount == 1) {
            [tree addObject:@"4"];
        }else if (linesCount == 2){
            [tree addObject:@"2"];
            [tree addObject:@"6"];
        }else if (linesCount == 4){
            [tree addObject:@"1"];
            [tree addObject:@"3"];
            [tree addObject:@"5"];
            [tree addObject:@"7"];
        }else if (linesCount == 8){
            for (int i = 0; i < 8; i++) {
                [tree addObject:[NSString stringWithFormat:@"%d",i + 1]];
            }
        }
        
        for (int i = 0; i < linesCount; i++) {
            CWSortNumberView *numberView = stateView.subviews[[tree[i] intValue] - 1];
            
            CGFloat lineX = CGRectGetMaxX(numberView.frame) + 4;
            UIView *line = [UIView new];
            line.tag = 999;
            line.frame = CGRectMake(lineX, 0, 1, CGRectGetMaxY(endView.frame) - CGRectGetMinY(stateView.frame));
            [stateView addSubview:line];
            [lines addObject:line];
            line.backgroundColor = UIColorRed;
            line.alpha = 0;
  
        }
        
        [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //显示状态视图
            stateView.alpha = 1;
            for (UIView *line in lines) {
                //显示分割线
                line.alpha = 1;
            }
         } completion:^(BOOL finished) {
            self.index += 1;
       }];
    }
    
    
   
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}

- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [NSMutableArray array];
    }
    return _numbers;
}
- (BOOL)canPopViewController{
    [_timer invalidate];
    _timer = nil;
    return YES;
}
- (NSMutableArray *)mergeStates{
    if (!_mergeStates) {
        _mergeStates = [NSMutableArray array];
    }
    return _mergeStates;
}
@end
