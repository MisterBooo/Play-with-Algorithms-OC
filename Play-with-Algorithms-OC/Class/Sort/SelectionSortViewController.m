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
@property(nonatomic, strong) NSMutableArray *numbers;



@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) BOOL isOrder;

@property(nonatomic, assign) int delay;
@property(nonatomic, strong) NSMutableArray *sortArray;
@end

@implementation SelectionSortViewController

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

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sortAction:) userInfo:nil repeats:YES];
    [timer fire];
    _timer = timer;

}
- (void)sortAction:(NSTimer *)timer{
    if (self.delay > self.sortArray.count-1) {
        [_timer invalidate];
        _timer = nil;
        for (CWSortNumberView *numberView in self.view.subviews) {
            numberView.backgroundColor = UIColorYellow;
        }
        [QMUITips showSucceed:@"排序成功" inView:self.view hideAfterDelay:2];
        return;
    }

    [UIView animateWithDuration:0.8 delay: 0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        NSArray *states = self.sortArray[self.delay];
        for (int i = 0; i < states.count; i++) {
            CWSortNumberView *numberView_i = states[i];
            CWSortNumberView *numberView = self.dataSource[i];
            numberView.contentLabel.text = numberView_i.contentLabel.text;
            numberView.backgroundColor = numberView_i.backgroundColor;
        }
       
    } completion:^(BOOL finished){
        self.delay += 1;
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
    [self.sortArray removeAllObjects];
    [self.numbers removeAllObjects];
    self.delay = 0;
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
        [self.numbers addObject:numberView.contentLabel.text];
        
    }
    for(int i = 0 ; i < self.numbers.count ; i ++){
        int minIndex = i;
        for( int j = i + 1 ; j < self.numbers.count ; j ++ ){
         
            //添加一个存储状态的数组
            //状态机
            NSMutableArray *array = [NSMutableArray array];
            for (int k = 0; k < self.numbers.count; k++) {
                CWSortNumberView *numberView_k = [[CWSortNumberView alloc] init];
                numberView_k.contentLabel.text = self.numbers[k];
                if (k == j) {
                    numberView_k.backgroundColor = UIColorGreen;
                }else if (k == minIndex){
                    numberView_k.backgroundColor = UIColorRed;
                }else{
                   numberView_k.backgroundColor = UIColorBlue;
                }
                if (k < i) {
                    numberView_k.backgroundColor = UIColorYellow;
                }
                [array addObject:numberView_k];
            }
            int number_j = [self.numbers[j] intValue];
            int number_minIndex = [self.numbers[minIndex] intValue];
            
            if( number_j < number_minIndex ){
                minIndex = j;
            }
            [self.sortArray addObject:array];
            
        }
        [self.numbers exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    
    //打印出所有状态
    for (int i = 0; i< self.sortArray.count; i++) {
        NSMutableArray *array = self.sortArray[i];
        for (int j = 0; j < array.count; j++) {
            CWSortNumberView *numberView = array[j];
            NSLog(@"%@",numberView.contentLabel.text);
        }
        NSLog(@"***********");
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

- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [NSMutableArray array];
    }
    return _numbers;
}


@end
