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
    
    
}


@end
