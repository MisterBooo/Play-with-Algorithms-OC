# 在 Object-C中学习数据结构与算法
## 排序算法

* 选择排序
* 插入排序
* 冒泡排序
* 归并排序
* 快速排序

### 选择排序
### 插入排序
### 冒泡排序
### 归并排序
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
            }else if([aux[i-l] intValue] < [aux[j-l] intValue]){// 左半部分所指元素 < 右半部分所指元素
                array[k] = aux[i-l];
                i++;
            }else{
                array[k] = aux[j-l];
                j++;
            }
        }
}

```
### 快速排序
