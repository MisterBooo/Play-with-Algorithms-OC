# 在 Object-C中学习数据结构与算法

* 选择排序
* 插入排序
* 冒泡排序
* 归并排序(重点)
* 快速排序(重点)

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

#### 动画效果
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
#### 动画效果
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

#### 动画效果
![](http://oriq21dog.bkt.clouddn.com/bloc/2017-07-14-%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F%E5%8A%A8%E7%94%BB.gif)




### 归并排序
#### 将原始序列切分成较小的序列，只到每个小序列无法再切分，然后执行合并，即将小序列归并成大的序列，合并过程进行比较排序，只到最后只有一个排序完毕的大序列。

归并排序是创建在归并操作上的一种有效的排序算法，该算法是采用分治法（Divide and Conquer）的一个非常典型的应用，且各层分治递归可以同时进行。

#### 归并操作
* 递归法
* 迭代法

#### 代码示例
##### 递归法
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
##### 优化1

##### 优化2

### 快速排序
