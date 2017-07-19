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
生成一个近乎有序的数组
首先生成一个含有[0...n-1]的完全有序数组, 之后随机交换swapTimes对数据
swapTimes定义了数组的无序程度
 */
- (NSMutableArray *)generateNearlyOrderedArray:(int )arrayCount swapTimes:(int )swapTimes{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < arrayCount; i++) {
        [array addObject:@(i)];
    }
    for (int i = 0; i < swapTimes; i++) {
        int posx = arc4random() % arrayCount;
        int posy = arc4random() % arrayCount;
        [array exchangeObjectAtIndex:posx withObjectAtIndex:posy];
    }
    return array;
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
- (NSString *)testSort:(SortType )sortType array:(NSMutableArray *)array{

    NSMutableArray *arrayM = [NSMutableArray array];
    NSString *sortName = @"排序方法";

    CFTimeInterval startTime = CACurrentMediaTime();
    switch (sortType) {
        case SortTypeSelection:
        {
            arrayM =  [self selectionSort:array];
            sortName = @"选择排序";
        }
            break;
        case SortTypeBubble:{
            arrayM = [self bubbleSort:array];
            sortName = @"冒泡排序";

        }
            break;
        case SortTypeInsertion:{
            arrayM = [self insertionSort:array];
            sortName = @"插入排序";

        }
            break;
        case SortTypeMerge:{
            arrayM = [self mergeSort1:array];
            sortName = @"归并排序";
        }
            break;
        case SortTypeMergeOptimize:{
            arrayM = [self mergeSort2:array];
            sortName = @"优化后的归并排序";
        }
            break;
        case SortTypeMergeBottomUp:{
            arrayM = [self mergeSortBU:array];
            sortName = @"自底向上的归并排序";
        }
            break;
        case SortTypeQuick:{
            arrayM = [self quickSort:array];
            sortName = @"快速排序";
        }
            break;
        case SortTypeIdenticalQuick:{
            arrayM = [self quickSort2:array];
            sortName = @"双路快速排序";
        }
            break;
            
        default:
            break;
    }
    CFTimeInterval endTime = CACurrentMediaTime();
    NSAssert([self isSorted:arrayM],@"排序失败");
    CFTimeInterval consumingTime = endTime - startTime;
    NSLog(@"%@:%@ s",sortName, @(consumingTime));
    NSLog(@"***************");
    return [NSString stringWithFormat:@"长度 %ld 的 %@: %f s",arrayM.count,sortName, consumingTime];
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

#pragma mark - ***************归并排序********************

/**
 归并排序1

 @param array array
 @return array
 */
- (NSMutableArray *)mergeSort1:(NSMutableArray *)array{
    //要特别注意边界的情况
    [self _mergeSort:array leftIndex:0 rightIndex:(int)array.count - 1];
    return array;
}

/**
 归并排序2
 
 @param array array
 @return array
 */
- (NSMutableArray *)mergeSort2:(NSMutableArray *)array{
    //要特别注意边界的情况
    [self __mergeSort2:array leftIndex:0 rightIndex:(int)array.count - 1];
    return array;
}


/**
 递归使用归并排序,对array[l...r]的范围进行排序
 
 @param array 排序数组
 @param l 左边界
 @param r 右边界
 */
- (void)_mergeSort:(NSMutableArray *)array leftIndex:(int)l rightIndex:(int)r{
    if (l >= r ) return;
    //数字太大会溢出
    int mid = (l + r) / 2;
    [self _mergeSort:array leftIndex:l rightIndex:mid];
    [self _mergeSort:array leftIndex:mid + 1 rightIndex:r];
    [self __mergeSort1:array leftIndex:l midIndex:mid rightIndex:r];
}

/**
 将array[l...mid]和array[mid+1...r]两部分进行归并
 
 @param array array
 @param l l description
 @param mid mid description
 @param r r description
 */
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
    }
    if (!self.mergeStates) {
        self.mergeStates = [NSMutableArray array];
    }
    [self.mergeStates addObject:array.mutableCopy];
    
    
}


/**
 优化后的归并排序
 
 @param array array
 @param l l
 @param r r
 */
- (void)__mergeSort2:(NSMutableArray *)array leftIndex:(int)l rightIndex:(int)r{
    // 优化2: 对于小规模数组, 使用插入排序
    if (r - l <= 15) {
        [self insertionSort:array leftIndex:l rightIndex:r];
        return;
    }
    int mid = (l + r) / 2;
    [self __mergeSort2:array leftIndex:l rightIndex:mid];
    [self __mergeSort2:array leftIndex:mid + 1 rightIndex:r];
    // 优化1: 对于arr[mid] <= arr[mid+1]的情况,不进行merge
    // 对于近乎有序的数组非常有效,但是对于一般情况,有一定的性能损失
    if ([array[mid] intValue] > [array[mid + 1] intValue]) {
        [self __mergeSort1:array leftIndex:l midIndex:mid rightIndex:r];
    }
    
}

/**
 使用自底向上的归并排序算法

 @param array 需要排序的数组
 */
- (NSMutableArray *)mergeSortBU:(NSMutableArray *)array{
    // Merge Sort Bottom Up 优化
    // 对于小数组, 使用插入排序优化
    for (int i = 0; i < array.count; i+=16) {
        [self insertionSort:array leftIndex:i rightIndex:(int)MIN(i + 15, array.count -1)];
    }
    // sz == 1;  i < n - 1              sz = 2
    // 0---0    1---1     i=0           0-1   2-3
    // 1---1    2---2     i=1           1-2   3-4
    for (int sz = 16; sz < array.count; sz += sz) {
        for (int i = 0; i < array.count - sz; i += sz + sz) {
            if (array[i + sz - 1] > array[i + sz]) {
                [self __mergeSort1:array leftIndex:i midIndex:(i + sz - 1) rightIndex:(int)MIN(i + sz + sz - 1, array.count - 1)];
            }
        }
    }
    return array;
}


/**
 对array[l...r]范围的数组进行插入排序
 @param array array
 @param l l
 @param r r
 */
- (void)insertionSort:(NSMutableArray *)array leftIndex:(int)l rightIndex:(int)r{
    for (int i = l+1; i <= r; i++) {
        int e = [array[i] intValue];
        int j;
        for (j = i; j > l && [array[j - 1] intValue] > e; j--) {
            array[j] = array[j - 1];
        }
        array[j] = @(e);
    }
}


#pragma mark - ***************快速排序********************

- (NSMutableArray *)quickSort:(NSMutableArray *)array{
    [self __quickSort:array indexL:0 indexR:(int)array.count - 1];
    return array;
}

- (NSMutableArray *)quickSort2:(NSMutableArray *)array{
    [self __quickSort2:array indexL:0 indexR:(int)array.count - 1];
    return array;
}

/**
  对arr[l...r]部分进行快速排序

 @param array array
 @param l 左
 @param r 右
 */
- (void)__quickSort:(NSMutableArray *)array indexL:(int)l indexR:(int)r{
    if (l >= r) return;
    int p = [self __partition:array indexL:l indexR:r];
    [self __quickSort:array indexL:l indexR:p-1];
    [self __quickSort:array indexL:p + 1 indexR:r];
}

/**
对arr[l...r]部分进行partition操作
 返回p, 使得arr[l...p-1] < arr[p] ; arr[p+1...r] > arr[p]

 @param array array
 @param l 左
 @param r 右
 @return 返回p
 */
- (int)__partition:(NSMutableArray *)array indexL:(int)l indexR:(int)r{
    
    NSString *v = array[l];
    int j = l;// arr[l+1...j] < v ; arr[j+1...i) > v
    for (int i = l + 1; i <= r ; i++) {
        if ([array[i] intValue] < [v intValue]) {
            j++;
            //交换
            [array exchangeObjectAtIndex:j withObjectAtIndex:i];
        }
    }
    [array exchangeObjectAtIndex:j withObjectAtIndex:l];
    return j;
}

/**
 对arr[l...r]部分进行快速排序
 
 @param array array
 @param l 左
 @param r 右
 */
- (void)__quickSort2:(NSMutableArray *)array indexL:(int)l indexR:(int)r{
    if (l >= r) return;
    //调用双路快速排序的partition
    int p = [self __partition2:array indexL:l indexR:r];
    [self __quickSort:array indexL:l indexR:p-1];
    [self __quickSort:array indexL:p + 1 indexR:r];
}
/**
 双路快速排序的partition
 返回p, 使得arr[l...p-1] < arr[p] ; arr[p+1...r] > arr[p]
 */
- (int)__partition2:(NSMutableArray *)array indexL:(int)l indexR:(int)r{
    
    // 随机在arr[l...r]的范围中, 选择一个数值作为标定点pivot
    [array exchangeObjectAtIndex:l withObjectAtIndex:(arc4random()%(r-l+1))];
    int v = [array[l] intValue];
    
    // arr[l+1...i) <= v; arr(j...r] >= v
    int i = l + 1, j = r;
    while (true) {
    
        while (i <= r && [array[i] intValue] < v)
            i++;
        
        while (j > l + 1 &&[array[j] intValue] > v)
            j--;
        
        if (i > j) {
            break;
        }
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        i++;
        j--;
    }
    [array exchangeObjectAtIndex:l withObjectAtIndex:j];
    return j;
    
}




#pragma mark - ***************插入排序********************
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

#pragma mark - ***************选择排序********************

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
#pragma mark - ***************插入排序********************

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


/**
 获取归并排序的每个状态

 @param array array
 @return 状态机
 */
- (NSMutableArray *)getMergeStates:(NSMutableArray *)array{
    //要特别注意边界的情况
    [self.mergeStates removeAllObjects];
    [self _mergeSort:array leftIndex:0 rightIndex:(int)array.count - 1];
    return self.mergeStates;
}


@end
