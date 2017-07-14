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
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *arrayM = [NSMutableArray array];
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
        NSLog(@"%ld :耗时：%@ s",sortType, @(consumingTime));
    });
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
        case SortTypeBubble:
        {
            states = [self bubbleSortFromModels:models];
        }
            break;
        case SortTypeSheel:{
            states = [self shellSortFromModels:models];
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




- (NSMutableArray *)bubbleSort:(NSMutableArray *)arr{
    bool swapped;
    //int newn; // 理论上,可以使用newn进行优化,但实际优化效果较差
    NSInteger n = arr.count;
    do{
        swapped = false;
        //newn = 0;
        for( int i = 1 ; i < n ; i ++ )
            if( arr[i-1] > arr[i] ){
                [arr exchangeObjectAtIndex:i - 1 withObjectAtIndex:i];
                swapped = true;
                
                // 可以记录最后一次的交换位置,在此之后的元素在下一轮扫描中均不考虑
                // 实际优化效果较差,因为引入了newn这个新的变量
                //newn = n;
            }
        
        //n = newn;
        
        // 优化,每一趟Bubble Sort都将最大的元素放在了最后的位置
        // 所以下一次排序,最后的元素可以不再考虑
        // 理论上,newn的优化是这个优化的复杂版本,应该更有效
        // 实测,使用这种简单优化,时间性能更好
        n --;
        
    }while(swapped);
    
    return arr;
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

/**
 插入排序

 @param models 数据
 @return 排序数组
 */
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
- (NSMutableArray *)shellSortFromModels:(NSMutableArray *)models{
    NSMutableArray *sheelArray = [NSMutableArray array];
//    
//    
//    
//    NSInteger gap,i;
//    for ( gap = models.count/2; gap > 0; gap /=2) {
//        for ( i = gap; i < models.count; i++) {
//            CWSortModel *model_i = models[i];
//            CWSortModel *model_i_gap = models[i-gap];
//            if (model_i.numberText.integerValue < model_i_gap.numberText.integerValue ) {
//                NSInteger target = model_i.numberText.integerValue;
//                NSInteger j = i - gap;
//                while (j >= 0 ) {
//                    CWSortModel *model_j = models[j];
//                    if (model_j.numberText.integerValue > target) {
//                        models[j+gap] = model_j;
//                        j -= gap;
////                        [sheelArray addObject:[self setStateMachine:models indexI:i indexJ:j]];
//                        for (int k = 0; k < models.count; k++) {
//                            CWSortModel *model = models[k];
//                            NSLog(@"%@",model.numberText);
//                        }
//                        NSLog(@"******");
//
//                    }
//                }
//                CWSortModel *model_gap = [[CWSortModel alloc] init];
//                model_gap.numberText = [NSString stringWithFormat:@"%ld",target];
//                models[j+gap] = model_gap;
//            }
//            
//        }
//        
//    }
    

    // 计算 increment sequence: 1, 4, 13, 40, 121, 364, 1093...
    int h = 1;
    while( h < models.count / 3 )
        h = 3 * h + 1;
    
    while( h >= 1 ){
        
        // h-sort the array
        for( int i = h ; i < models.count ; i ++ ){
            
            // 对 arr[i], arr[i-h], arr[i-2*h], arr[i-3*h]... 使用插入排序
            CWSortModel *model_e = models[i];
            int j;
            for( j = i ; j >= h  ; j -= h ){
                CWSortModel *model_j_h = models[j-h];
                CWSortModel *model_j = models[j];
               
                if (model_e.numberText.intValue > model_j_h.numberText.intValue ) {
                    [sheelArray addObject:[self setStateMachine:models indexI:j indexJ:j-h] ];
                    break;
                }else{
                    model_j.numberText = model_j_h.numberText;
                    [sheelArray addObject:[self setStateMachine:models indexI:j indexJ:j-h] ];

                }

            }
            CWSortModel *model_j = models[j];
            model_j.numberText = model_e.numberText;
        }
        h /= 3;
    }
    return sheelArray;
}

/**
 冒泡排序

 @param models 数据
 @return 排序数组
 */
- (NSMutableArray *)bubbleSortFromModels:(NSMutableArray *)models{
    NSMutableArray *bubbleArray = [NSMutableArray array];
    bool swapped;
    do {
        swapped = false;
        for (int i = 1; i < models.count; i++) {
            CWSortModel *model_i = models[i];
            CWSortModel *model_i_1 = models[i-1];
            if (model_i.numberText.intValue < model_i_1.numberText.intValue) {
                swapped = true;
                [models exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
           [bubbleArray addObject: [self setStateMachine:models indexI:i-1 indexJ:i ]];
        }
        [models removeLastObject];
    } while (swapped);
    return bubbleArray;
}

/**
 保存排序的状态
 */
- (NSMutableArray *)setStateMachine:(NSMutableArray *)models indexI:(int)i indexJ:(int)j {
    //添加一个存储状态的数组
    //状态机
    NSArray *modelsCopy = models.copy;
    NSMutableArray *array = [NSMutableArray array];
    for (int k = 0; k < modelsCopy.count; k++) {
        CWSortModel *model_k = [[CWSortModel alloc] init];
        CWSortModel *model = modelsCopy[k];
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
