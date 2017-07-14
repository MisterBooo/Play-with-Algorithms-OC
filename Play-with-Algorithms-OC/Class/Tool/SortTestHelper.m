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
- ( double )testSort:(SortType )sortType array:(NSMutableArray *)array{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    NSString *sortName = @"";
    CFTimeInterval startTime = CACurrentMediaTime();
    
    switch (sortType) {
        case SortTypeSelection:
        {
            arrayM =  [self selectionSort:array];
        }
            break;
        case SortTypeBubble:{
            arrayM = [self bubbleSort:array];
        }
            break;
        case SortTypeInsertion:{
            arrayM = [self insertionSort:array];
        }
            break;
        default:
            break;
    }
    
    CFTimeInterval endTime = CACurrentMediaTime();

    NSAssert([self isSorted:arrayM],@"排序失败");


    CFTimeInterval consumingTime = endTime - startTime;
    NSLog(@"%@ :耗时：%@ s",sortName, @(consumingTime));

    return  consumingTime ;
    
}

/**
 根据数据获取排序时的各个状态
 
 @param models models
 @param type 排序类型
 @return 状态机
 */
- (NSMutableArray *)statesWithModels:(NSMutableArray *)models type:(SortType)type{
    NSMutableArray *states = [NSMutableArray array];
    switch (type) {
        case SortTypeSelection:
        {
            states = [self selectionSortFromModels:models];
        }
            break;
        case SortTypeInsertion:
        {
            states = [self insertionSortFromModels:models];
        }
            break;
            
        default:
            break;
    }
    
    //打印出所有状态
    for (int i = 0; i< states.count; i++) {
        NSMutableArray *array = states[i];
        for (int j = 0; j < array.count; j++) {
            CWSortModel *model = array[j];
            NSLog(@"%@",model.numberText);
        }
        NSLog(@"***********");
    }
    
    return states;
}




- (NSMutableArray *)bubbleSort:(NSMutableArray *)array{
    
    
    return array;
}


/**
 选择排序

 @param array array
 @return array
 */
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

/**
 插入排序

 @param array array
 @return array
 */
- (NSMutableArray *)insertionSort:(NSMutableArray *)array{
    for (int i = 0; i < array.count; i++) {
        int e = [array[i] intValue];
        int j;
        for (j = i; j > 0 && [array[j - 1] intValue] > e; j--) {
            array[j] = array[j - 1];
        }
        array[j] = @(e);
    }
    
    return array;
}


/**
 选择排序

 @param models 数据
 @return 排序数组
 */
- (NSMutableArray *)selectionSortFromModels:(NSMutableArray *)models{
    NSMutableArray *selectionArray = [NSMutableArray array];
    for(int i = 0 ; i < models.count ; i ++){
        int minIndex = i;
        for( int j = i + 1 ; j < models.count ; j ++ ){
            
//            NSMutableArray *array = [NSMutableArray array];
//            for (int k = 0; k < models.count; k++) {
//                CWSortModel *model_k = [[CWSortModel alloc] init];
//                CWSortModel *model = models[k];
//                if (k == j) {
//                    model_k.backgroundColor = UIColorGreen;
//                }else if (k == minIndex){
//                    model_k.backgroundColor = UIColorRed;
//                }else{
//                    model_k.backgroundColor = UIColorYellow;
//                }
//                if (k < i) {
//                    model_k.backgroundColor = UIColorBlue;
//                }
//                model_k.numberText = model.numberText;
//                [array addObject:model_k];
//            }
            
            //添加一个存储状态的数组
            //状态机
            NSMutableArray *array = [self setStateMachine:models indexI:j indexJ:minIndex];
            [selectionArray addObject:array];
            
            CWSortModel *model_j = models[j];
            CWSortModel *model_minIndex = models[minIndex];
            
            if( model_j.numberText.intValue < model_minIndex.numberText.intValue ){
                minIndex = j;
            }
          
        }
        [models exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return selectionArray;
}

- (NSMutableArray *)insertionSortFromModels:(NSMutableArray *)models{
    NSMutableArray *insertionArray = [NSMutableArray array];
    //写法1
    for (int i = 1; i < models.count; i++) {
        //寻找元素models[i]合适的插入位置
        for (int j = i; j > 0; j--) {
            CWSortModel *model_j = models[j];
            CWSortModel *model_j_1 = models[j-1];
            if (model_j.numberText.intValue < model_j_1.numberText.intValue) {
                [models exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                //存储到状态机
                NSMutableArray *array = [self setStateMachine:models indexI:j indexJ:j-1];
                [insertionArray addObject:array];
            }else{
                //存储到状态机
                NSMutableArray *array = [self setStateMachine:models indexI:j indexJ:j-1];
                [insertionArray addObject:array];
                break;
            }
        }
    }
    
    return insertionArray;
}

- (NSMutableArray *)setStateMachine:(NSMutableArray *)models indexI:(int)i indexJ:(int)j {
    //添加一个存储状态的数组
    //状态机
    NSMutableArray *array = [NSMutableArray array];
    for (int k = 0; k < models.count; k++) {
        CWSortModel *model_k = [[CWSortModel alloc] init];
        CWSortModel *model = models[k];
        model_k.backgroundColor = UIColorYellow;
        if (k < i) {
            model_k.backgroundColor = UIColorBlue;
        }
        if (k == i) {
            model_k.backgroundColor = UIColorGreen;
        }else if (k == j){
            model_k.backgroundColor = UIColorRed;
        }
        model_k.numberText = model.numberText;
        [array addObject:model_k];
    }
    return  array;
}




@end
