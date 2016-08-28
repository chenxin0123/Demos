//
//  sort.m
//  D3
//
//  Created by CX on 8/27/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "sort.h"
#import <mach/mach_time.h>

#define SWAP(_A_,_B_) do{ typeof(_A_) _TMP_ = _A_; _A_ = _B_; _B_ = _TMP_; } while(0);

/**
 *    从右向左遍历数组，比较相邻的两个元素。经过一次遍历，我们可以保证最小的元素(泡泡)处于最左边的位置
      最多可能进行n-1此遍历
 */
void bubbleSort(int arr[], int arr_len) {
    int sign;
    for (int j = 0; j < arr_len-1; j++) {
        sign = 0;
        for(int i = arr_len-1; i > j; i--) {
            if(arr[i-1] > arr[i]) {
                sign = 1;
                SWAP(arr[i], arr[i-1]);
            }
        }
        if (sign == 0) break;
    }
}

/**
 *    插入第N个元素，往前遍历遍历比较相邻元素。
      进行了n-1次遍历
 */
void insertionSort(int arr[], int arr_len) {
    for (int i=1; i<arr_len; i++) {
        for (int j=i-1; j>=0; j--) {
            if (arr[j] > arr[j+1]) {
                SWAP(arr[j], arr[j+1])
            }
        }
    }
}

/**
 *    选择排序是先找到起始数组中最小的元素，将它交换到i=0；然后寻找剩下元素中最小的元素，将它交换到i=1的位置…… 直到找到第二大的元素
 */
void selectionSort(int arr[], int arr_len) {
    int minIdx;
    for (int i=0; i<arr_len-1; i++) {
        minIdx = i;
        for (int j=i; j<arr_len; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }
        if (minIdx != i) {
            SWAP(arr[i], arr[minIdx]);
        }
    }
}

/**
 我们在冒泡排序中,最坏的情况发生在大的元素位于数组的起始。这些位于数组起始的大元素需要多次遍历，才能交换到队尾。这样的元素被称为乌龟(turtle)。(小的元素位于队尾，被称为兔子(rabbit)元素，它们可以很快的交换到队首。)希尔排序是以更大的间隔来比较和交换元素，这样，大的元素在交换的时候，可以向右移动不止一个位置，从而更快的移动乌龟元素。
 
 比如，可以将数组分为4个子数组（i=4k, i=4k+1, i=4k+2, i=4k+3），对每个子数组进行冒泡排序。比如子数组i=0，4，8，12...。此时，每次交换的间隔为4。
 
 完成对四个子数组的排序后，数组的顺序并不一定能排列好。希尔排序会不断减小间隔，重新形成子数组，并对子数组冒泡排序…… 当间隔减小为1时，就相当于对整个数组进行了一次冒泡排序。
 
 希尔排序不止可以配合冒泡排序，还可以配合其他的排序方法完成。
 Shell Sorting依赖于间隔(step)的选取。一个常见的选择是将本次间隔设置为上次间隔的1/1.3
 */
void shellSort(int arr[], int arr_len) {
    int step;
    int nsub;
    int *sub;
    
    step = arr_len;
    while(step > 1) {
        //step无限接近1 当step为1时
        step = step/1.3;
        for(int i=0; i<step; i++) {
            //i+(nsub-1)*step <= arr_len - 1
            nsub = (arr_len - i - 1)/step + 1;
            sub = (int *) malloc(sizeof(int)*nsub);
            for(int j=0; j<nsub; j++) {
                sub[j] = arr[i+j*step];
            }
            
            bubbleSort(sub, nsub);
            
            for(int j=0; j<nsub; j++) {
                arr[i+j*step] = sub[j];
            }
            
            free(sub);
        }    
    }
}

/**
 *    从两堆已拍好序的牌中，假设最小的在上面，从这两堆取最小的一张，继续取最小的一张，再继续。。。
 */
void mergeSort(int arr[], int arrLen) {
    if (arrLen <= 1) { return; }
    
    int leftSubLen, rightSubLen, leftCount, rightCount;
    int *container;
    
    leftSubLen = arrLen / 2;
    rightSubLen = arrLen - leftSubLen;
    
    mergeSort(arr, leftSubLen);
    mergeSort(arr+leftSubLen, rightSubLen);
    
    container = (int *)malloc(sizeof(int)*arrLen);
    
    leftCount = 0, rightCount = 0;
    while (leftCount+rightCount < arrLen) {
        if (leftCount < leftSubLen && rightCount < rightSubLen) {
            if (arr[leftCount] < arr[rightCount+leftSubLen]) {
                container[leftCount+rightCount] = arr[leftCount];
                leftCount++;
            } else {
                container[leftCount+rightCount] = arr[rightCount+leftSubLen];
                rightCount++;
            }
        } else if (leftCount < leftSubLen) {
            container[leftCount+rightCount] = arr[leftCount];
            leftCount++;
        } else if (rightCount < rightSubLen) {
            container[leftCount+rightCount] = arr[rightCount+leftSubLen];
            rightCount++;
        }
    }
    
    memcpy(arr, container, arrLen*sizeof(int));
    free(container);
}

/**
 *    随便跳出一个元素，以该元素为参考,让小于该元素的待在左边，大于该元素的待在右边.对左边/右边的数组一样处理...
 */
void quickSort(int arr[], int arrLen) {
    int pivot = 1;
    SWAP(arr[0], arr[arrLen/2]);
    for (int i=0; i<arrLen; i++) {
        if (arr[i] < arr[0]) {
            SWAP(arr[pivot], arr[i]);
            pivot++;
        }
    }
    SWAP(arr[0], arr[pivot-1]);
    
    if (arrLen <= 3) {
        return;
    } else {
        quickSort(arr, pivot);
        quickSort(arr+pivot, arrLen-pivot);
    }
}

/**
 若在输出堆顶的最小值之后，使得剩余n-1个元素的序列重又建成一个堆，则得到n个元素的次小值。如此反复执行，便能得到一个有序序列，这个过程称之为堆排序。
 一般用数组来表示堆，若根结点存在序号0处， i结点的父结点下标就为(i-1)/2 【(i-1)/2或(i-2)/2 = (i-1)/2(i>=0 右节点为偶数)】。i结点的左右子结点下标分别为2*i+1和2*i+2。
 
 实现堆排序需要解决两个问题：
 　　　　1.如何由一个无序序列建成一个堆？
 　　　　2.如何在输出堆顶元素之后，调整剩余元素成为一个新的堆？
 先考虑第二个问题，一般在输出堆顶元素之后，视为将这个元素排除，然后用表中最后一个元素填补它的位置，自上向下进行调整：首先将堆顶元素和它的左右子树的根结点进行比较，把最小的元素交换到堆顶；然后顺着被破坏的路径一路调整下去，直至叶子结点，就得到新的堆。我们称这个自堆顶至叶子的调整过程为“筛选”。从无序序列建立堆的过程就是一个反复“筛选”的过程.
 
 排序开始,，将堆顶元素和最后一个元素交换，这样，第n个位置（即最后一个位置）作为有序区，前n-1个位置仍是无序区，对无序区进行调整，得到堆之后，再交换堆顶和最后一个元素，这样有序区长度变为2...
 
 若想得到升序，则建立大顶堆，若想得到降序，则建立小顶堆
 */

void minHeapFixdown(int arr[], int pos,int arrLen) {
    int j;
    j = 2 * pos + 1;
    while (j < arrLen) {
        if (j+1 < arrLen && arr[j] > arr[j+1]) {
            j++;
        }
        
        if (arr[j] >= arr[pos]) {
            break;
        }
        SWAP(arr[pos], arr[j])
        pos = j;
        j = 2 * pos + 1;
    }
}

void maxHeapFixdown(int arr[], int pos,int arrLen) {
    int j;
    j = 2 * pos + 1;
    while (j < arrLen) {
        if (j+1 < arrLen && arr[j] < arr[j+1]) {
            j++;
        }
        
        if (arr[j] <= arr[pos]) {
            break;
        }
        SWAP(arr[pos], arr[j])
        pos = j;
        j = 2 * pos + 1;
    }
}

void makeMaxHeap(int arr[], int arrLen) {
    for (int i=(arrLen-1-1)/2; i>=0; i--) {
        maxHeapFixdown(arr, i, arrLen);
    }
}

void makeMinHeap(int arr[], int arrLen) {
    for (int i=(arrLen-1-1)/2; i>=0; i--) {
        minHeapFixdown(arr, i, arrLen);
    }
}


void heapSort(int arr[], int arrLen) {
    makeMaxHeap(arr,arrLen);
    for (int i=arrLen-1; i>0; i--) {
        SWAP(arr[0], arr[i])
        maxHeapFixdown(arr,0,i);
    }
}


void printArr(int arr[], int arr_len) {
    for (int i=0; i<arr_len; i++) {
        printf(" %d",arr[i]);
    }
    printf("\n");
}

void randomShuffle(int arr[], int arr_len) {
    for (int i=0; i<arr_len; i++) {
        arr[i] = rand()%(MIN(arr_len*10, INT_MAX));
    }
}

double mach_absolute_time_interval(uint64_t startTime, uint64_t endTime) {
    uint64_t difference = endTime - startTime;
    static double conversion = 0.0;
    if(conversion == 0.0) {
        mach_timebase_info_data_t info;
        kern_return_t err = mach_timebase_info(&info);
        if(err == 0)
            conversion = 1e-9 * (double) info.numer / (double) info.denom;
    }
    return difference * conversion;
}


/*
Shell Sort:(len:10000000 time:16.343695)
Merge Sort:(len:10000000 time:3.330578)
Quick Sort:(len:10000000 time:2.095063)
Heap Sort:(len:10000000 time:4.627448)
*/
void sortTest() {
    srand((unsigned)time(NULL));
    uint64_t startTime;
    uint64_t endTime;
    const int len = 10000000;
    int *arr = (int *)malloc(sizeof(int)*len);
    
#define MACH_TIME_INTERVAL(_NAME_,_EXPRESSION_) \
do {\
    randomShuffle(arr,len);\
    startTime = mach_absolute_time(); _EXPRESSION_; endTime = mach_absolute_time();\
    printf(#_NAME_":(len:%d time:%f)\n",len,mach_absolute_time_interval(startTime, endTime));\
}while(0);
    
    MACH_TIME_INTERVAL(Bubble Sort,bubbleSort(arr, len);)
    MACH_TIME_INTERVAL(Insertion Sort,insertionSort(arr, len);)
    MACH_TIME_INTERVAL(Selection Sort,selectionSort(arr, len);)
    MACH_TIME_INTERVAL(Shell Sort,shellSort(arr, len);)
    MACH_TIME_INTERVAL(Merge Sort,mergeSort(arr, len);)
    MACH_TIME_INTERVAL(Quick Sort,quickSort(arr, len);)
    MACH_TIME_INTERVAL(Heap Sort,heapSort(arr, len);)
    
#undef MACH_TIME_INTERVAL
    free(arr);
}