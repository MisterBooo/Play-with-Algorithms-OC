# 在 Object-C 中学习算法与数据结构
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-15-Snip20170715_24.png)

> 前言：本文是笔者开始学习算法与数据机构中的一些笔记，打算将学习过程中的一些心得体会以及理解用动画效果描述，配合[Demo 在 Object-C 中学习算法与数据结构](https://github.com/CoderWooo/Play-with-Algorithms-OC)阅读更佳

# 目录
* 排序基础  **（完成）**
* 高级排序算法 **（完成）**
* 堆和堆排序
* 二分搜索树
* 并查集
* 图的基础
* 最小生成树
* 最短路径

## 排序基础
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-20-Snip20170720_5.png)

* 选择排序
* 插入排序
* 冒泡排序


### 选择排序
#### 每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，以此循环，直至排序完毕。
选择排序算法是一种原址比较排序算法。选择排序算法的思路是：找到数据结构中的最小值并 将其放置在第一位，接着找到第二小的值并将其放在第二位，以此类推。

#### 代码示例：
```
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
```

#### 动画演示
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-14-%E9%80%89%E6%8B%A9%E6%8E%92%E5%BA%8F%E5%8A%A8%E7%94%BB.gif)

### 插入排序
#### 将一个数据插入到已经排好序的有序数据中，从而得到一个新的、个数加一的有序数据

插入排序是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。此算法适用于少量数据的排序，在**归并排序的优化**可以使用插入排序进行一定性能的提升。

#### 代码示例：
```
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

```
#### 动画演示
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-14-%E6%8F%92%E5%85%A5%E6%8E%92%E5%BA%8F%E5%8A%A8%E7%94%BB.gif)
### 冒泡排序
#### 比较任何两个相邻的项，如果第一个比第二个大，则交换它们；元素项向上移动至正确的顺序，好似气泡上升至表面一般，因此得名。
人们开始学习排序算法时，通常都先学冒泡算法，因为它在所有排序算法中最简单。然而， 从运行时间的角度来看，冒泡排序是最差的一个，接下来你会知晓原因。

冒泡排序比较任何两个相邻的项，如果第一个比第二个大，则交换它们。元素项向上移动至 正确的顺序，就好像气泡升至表面一样，冒泡排序因此得名。

#### 代码示例
```
/**
 冒泡排序
 @param array array
 @return array
 */
- (NSMutableArray *)bubbleSort:(NSMutableArray *) array{
    bool swapped;
    NSInteger n = array.count;
    do{
        swapped = false;
        for( int i = 1 ; i < n ; i ++ )
            if( array[i-1] > arr[i] ){
                [array exchangeObjectAtIndex:i - 1 withObjectAtIndex:i];
                swapped = true;
            }
        // 优化,每一趟Bubble Sort都将最大的元素放在了最后的位置
        // 所以下一次排序,最后的元素可以不再考虑
        // 实测,使用这种简单优化,时间性能更好
        n --;
    }while(swapped);
    return array;
}
```

#### 动画演示
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-14-%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F%E5%8A%A8%E7%94%BB.gif)



## 高级排序算法
* 归并排序
* 快速排序

### 归并排序
#### 将原始序列切分成较小的序列，只到每个小序列无法再切分，然后执行合并，即将小序列归并成大的序列，合并过程进行比较排序，只到最后只有一个排序完毕的大序列。

归并排序是创建在归并操作上的一种有效的排序算法，该算法是采用分治法（Divide and Conquer）的一个非常典型的应用，且各层分治递归可以同时进行。

#### 归并操作
* 1. 自顶向下的归并排序
* 2. 自底向上的归并排序

#### 代码示例
#### 1.自顶向下的归并排序
```
/**
 归并排序
 @param array array
 @return array
 */
- (NSMutableArray *)mergeSort:(NSMutableArray *)array{
    //要特别注意边界的情况
    [self _mergeSort:array leftIndex:0 rightIndex:(int)array.count - 1];
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
            }else if([aux[i-l] intValue] < [aux[j-l] intValue]){
                // 左半部分所指元素 < 右半部分所指元素
                array[k] = aux[i-l];
                i++;
            }else{
                array[k] = aux[j-l];
                j++;
            }
        }
}

```
#### 动画演示
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-16-%E5%BD%92%E5%B9%B6%E8%BF%87%E7%A8%8B%E6%8E%92%E5%BA%8F.gif)

##### 归并排序的优化
**优化1** 对于arr[mid] <= arr[mid+1]的情况,不进行merge。对于近乎有序的数组非常有效,但是对于一般情况,有一定的性能损失

**优化2** 对于小规模数组, 使用插入排序 在后面的对排序算法的优化中经常使用这种优化


##### 代码示例
```
/**
 优化后的归并排序

 @param array array
 @param l l
 @param r r
 */
- (void)__megerSort2:(NSMutableArray *)array leftIndex:(int)l rightIndex:(int)r{
     // 优化2: 对于小规模数组, 使用插入排序
    if (r - l <= 15) {
        [self insertionSort:array leftIndex:l rightIndex:r];
        return;
    }
    int mid = (l + r) / 2;
    [self __megerSort2:array leftIndex:l rightIndex:mid];
    [self __megerSort2:array leftIndex:mid + 1 rightIndex:r];
    // 优化1: 对于arr[mid] <= arr[mid+1]的情况,不进行merge
    // 对于近乎有序的数组非常有效,但是对于一般情况,有一定的性能损失
    if ([array[mid] intValue] > [array[mid + 1] intValue]) {
        [self __mergeSort1:array leftIndex:l midIndex:mid rightIndex:r];
    }
    
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
```
##### 优化后的效果对比
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-15-Snip20170715_23.png)

#### 2. 自底向上的归并排序
Merge Sort BU 也是一个O(nlogn)复杂度的算法，虽然只使用两重for循环
所以，Merge Sort BU也可以在1秒之内轻松处理100万数量级的数据

**注意：不要轻易根据循环层数来判断算法的复杂度，Merge Sort BU就是一个反例**

比较Merge Sort和Merge Sort Bottom Up两种排序算法的性能效率

整体而言, 两种算法的效率是差不多的。但是如果进行仔细测试, 自底向上的归并排序会略胜一筹。

更详细的测试, 可以[参考这个问题](http://coding.imooc.com/learn/questiondetail/3208.html)


##### 代码示例
```
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

```
##### 效果
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-17-Snip20170718_25-1.png)


### 快速排序
#### 过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行上述递归排序，以此达到整个数据变成有序序列

#### 快速排序的基本过程：

 
##### 接下来主要分析三种快速排序的思路与实现
* 原始快排：原始的快排。 
* 双路快排：为制造适合高效排序环境而事先打乱数组顺序的快排。
* 三路快排：为数组内大量重复值而优化的三向切分快排。



##### 原始快排的思路
理解快速排序的关键点在于理解**partition**操作

##### partition操作





##### 代码示例
```
#pragma mark - ***************快速排序********************

- (NSMutableArray *)quickSort:(NSMutableArray *)array{
    [self __quickSort:array indexL:0 indexR:(int)array.count - 1];
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
```
##### 双路快排的思路
出发点：解决近乎有序数组的排序

![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-19-Snip20170719_2.png)

 * 1. 首先，从数组中选择中间一项作为主元
 * 2. 创建两个指针，左边一个指向数组第一个项，右边一个指向数组最后一个项。移动左指针直到我们找到一个比主元大的元素，接着，移动右指针直到找到一个比主元小的元素，然后交换它们，重复这个过程，直到左指针超过了右指针。这个过程将使得比主元小的值都排在主元之前，而比主元大的值都排在主元之后。这一步叫作划分操作。
 * 3. 接着，算法对划分后的小数组（较主元小的值组成的子数组，以及较主元大的值组成的 子数组）重复之前的两个步骤，直至数组已完全排序。

##### 代码示例
```
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
```
注意：

##### 双路快排与原始快排的对比

*在近乎有序的数据中进行排序 双路快排的速度大于原始快排*

![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-20-Snip20170720_4-1.png)

##### 三路快排

对于拥有大量重复元素的数组，使用三路快速排序。

思路：

![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-20-Snip20170720_7.png)

 * 1. 首先在l到r的范围中，随机选取一个数值作为标定点pivot
 * 2. 
