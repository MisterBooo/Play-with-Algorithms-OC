//
//  CWBaseViewController.h
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/15.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "SortTestHelper.h"
#import "SelectionSort.h"
#import "CWSortNumberView.h"
#import "CWSortModel.h"
@interface CWBaseViewController : QMUICommonViewController
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) NSMutableArray *models;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) BOOL isOrder;

@property(nonatomic, assign) int index;
@property(nonatomic, strong) NSMutableArray *stateArray;
@property(nonatomic, assign) SortType sortType;
- (void)reloadData;
@end
