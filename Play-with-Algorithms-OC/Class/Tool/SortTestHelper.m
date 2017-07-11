//
//  SortTestHelper.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SortTestHelper.h"

@implementation SortTestHelper

static SortTestHelper *_instance;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


/**
 生成有n个元素的随机数组,每个元素的随机范围为[rangeL, rangeR]
 
 @param number 元素个数
 @param rangeL 左区间
 @param rangeR 右区间
 @return 数组
 */
- (NSMutableArray *)generateRandomArrayNumber:(int )number rangeL:(int )rangeL rangeR:(int)rangeR{

    NSAssert(rangeL <= rangeR, @"右区间必须不小于左区间");
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < number; i++) {
        [arrayM addObject:@(arc4random_uniform(rangeR - rangeL) + rangeL)];
    }
    
    return arrayM;
}
/**
 判断array数组是否有序
 
 @param array array
 @return 结果
 */
- (BOOL)isSorted:(NSArray *)array{
    
    NSInteger number = array.count - 1;
    
    for (NSInteger i = 0; i < number ; i++) {
        if ([array[i] integerValue] > [array[i + 1] integerValue]) {
            return false;
        }
    }
    return true;
}
/**
 测试sort排序算法排序arr数组所得到结果的正确性和算法运行时间
 @param sortType 排序算法
 @param array 测试数组
 */
- (void)testSort:(SortType )sortType array:(NSMutableArray *)array{
    
    __block NSMutableArray *arrayM = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *sortName = @"";
        clock_t startTime = clock();
        switch (sortType) {
            case SortTypeSelection:
            {
                arrayM =  [self selectionSort:array];
            }
                break;
            case SortTypeMerge:{
                
            }
                break;
            case SortTypeInsertion:{
                
            }
                break;
            default:
                break;
        }
        clock_t endTime = clock();
        
        NSAssert([self isSorted:arrayM],@"排序失败");
        
        NSLog(@"%@ :%lf s",sortName,(double)(endTime - startTime) / CLOCKS_PER_SEC );

    });
}





- (NSMutableArray *)selectionSort:(NSMutableArray *)array{
    for(int i = 0 ; i < array.count ; i ++){
        int minIndex = i;
        for( int j = i + 1 ; j < array.count ; j ++ ){
            if( [array[j] intValue] < [array[minIndex] intValue] ){
                minIndex = j;
            }
        }
        [array exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return array;
}




@end
