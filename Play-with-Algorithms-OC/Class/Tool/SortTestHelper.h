//
//  SortTestHelper.h
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWSortModel.h"
typedef NS_ENUM(NSInteger,SortType){
    SortTypeSelection,
    SortTypeBubble,
    SortTypeMerge,
    SortTypeInsertion,
};


@interface SortTestHelper : NSObject

+ (instancetype)shareInstance;

@property(nonatomic, assign) SortType sortType;


/**
 生成有n个元素的随机数组,每个元素的随机范围为[rangeL, rangeR]

 @param number 元素个数
 @param rangeL 左区间
 @param rangeR 右区间
 @return 数组
 */
- (NSMutableArray *)generateRandomArrayNumber:(int )number rangeL:(int )rangeL rangeR:(int)rangeR;


/**
 数组是否排序

 @param array array
 @return 结果
 */
- (BOOL)isSorted:(NSArray *)array;


/**
 测试sort排序算法排序arr数组所得到结果的正确性和算法运行时间
 @param sortType 排序算法
 @param array 测试数组
 */
- (double)testSort:(SortType )sortType array:(NSMutableArray *)array;



/**
 根据数据获取排序时的各个状态

 @param models models
 @param type 排序类型
 @return 状态机
 */
- (NSMutableArray *)statesWithModels:(NSMutableArray *)models type:(SortType )type;
@end
