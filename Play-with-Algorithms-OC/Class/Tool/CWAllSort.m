//
//  CWAllSort.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/13.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWAllSort.h"

@implementation CWAllSort

static CWAllSort *_instance;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)showArraySort:(NSMutableArray *)array{
    
}




@end
