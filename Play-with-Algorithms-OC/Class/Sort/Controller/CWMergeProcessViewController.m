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
@property(nonatomic, strong) NSMutableArray *colors;

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
    self.index = 0;
    [self.colors  removeAllObjects];
    [self.stateArray removeAllObjects];
    self.timer = nil;

    int count = 8;
    int state = 2 ;
    
    //最后一步归并过程数据
    self.numbers = [NSMutableArray arrayWithArray:@[@"2",@"3",@"6",@"8",@"1",@"4",@"5",@"7"]];
    
    
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
            model.backgroundColor = UIColorGreen;
            
            numberView.model = model;
            [stateView addSubview:numberView];
        }
    }
    
    CWSortNumberView *numberView = self.compareStateView.subviews[3];
    
    CGFloat lineX = CGRectGetMaxX(numberView.frame) + 4;
    UIView *line = [UIView new];
    line.tag = 999;
    
    line.frame = CGRectMake(lineX + CGRectGetMinX(self.compareStateView.frame), CGRectGetMinY(self.compareStateView.frame), 1, numberView.frame.size.height);
    
    [self.view addSubview:line];
    line.backgroundColor = UIColorRed;

}
- (void)sortAnimation{
    NSLog(@"sortAnimation");
    //保存归并排序的各个状态
    [self __mergeSort1:self.numbers leftIndex:0 midIndex:3 rightIndex:7];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(mergeAction) userInfo:nil repeats:YES];
    [timer fire];
    self.timer = timer;
    
}
- (void)mergeAction{

    if (self.index >= self.colors.count) {
        [self.timer invalidate];
        self.timer = nil;
        [QMUITips showSucceed:@"归并完成" inView:self.view hideAfterDelay:2];
        return;
    }
    NSArray *colors = self.colors[self.index];
    NSArray *numbers = self.stateArray[self.index];
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (int i = 0; i < self.compareStateView.subviews.count; i++) {
            CWSortNumberView *numberView = self.compareStateView.subviews[i];
            numberView.backgroundColor = colors[i];
        }
        for (int i = 0; i < self.originStateView.subviews.count; i++) {
            CWSortNumberView *numberView = self.originStateView.subviews[i];
            numberView.contentLabel.text = numbers[i];
            numberView.backgroundColor = i > self.index ? UIColorGreen : UIColorBlue;
        }
        
    } completion:^(BOOL finished) {
        self.index += 1;
    }];
}

- (void)__mergeSort1:(NSMutableArray *)array leftIndex:(int)l midIndex:(int)mid rightIndex:(int)r{
    // r-l+1的空间
    // 开辟新的空间
    NSMutableArray *aux = [NSMutableArray arrayWithCapacity:r-l+1];
    for (int i = l; i <= r ; i++) {
        aux[i-l] = array[i];
    }
    
    // 初始化，i指向左半部分的起始索引位置l；j指向右半部分起始索引位置mid+1
    int i = l, j = mid + 1;
  
    for ( int k = l; k <= r; k++) {
        NSMutableArray *colors = [NSMutableArray array];

        for (int m = 0; m < array.count; m++) {
            [colors addObject:UIColorGreen];
        }
        colors[i] = UIColorRed;
        colors[j] = UIColorRed;
        if (i > mid) { // 如果左半部分元素已经全部处理完毕
            array[k] = aux[j-l];
            j++;
        }else if(j > r){// 如果右半部分元素已经全部处理完毕
            array[k] = aux[i-l];
            i++;
        }else if([aux[i-l] intValue] < [aux[j-l] intValue]){// 左半部分所指元素 < 右半部分所指元素
            array[k] = aux[i-l];
            i++;
        }else{
            array[k] = aux[j-l];
            j++;
        }
        NSLog(@"array:%@",array);
        [self.stateArray addObject:array.copy];
        [self.colors addObject:colors];
    }
}


- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [NSMutableArray array];
    }
    return _numbers;
}
- (NSMutableArray *)colors{
    if (!_colors) {
        _colors = [NSMutableArray array];
    }
    return _colors;
}
@end
