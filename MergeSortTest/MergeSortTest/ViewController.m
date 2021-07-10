//
//  ViewController.m
//  MergeSortTest
//
//  Created by wangxiaoman on 2021/2/23.
//  Copyright © 2021 wangxiaoman. All rights reserved.
//

#import "ViewController.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    int a[10] = {3,2,5,9,1,100,67,6,7,10};
    mergeSort(a, 10);
}

void printArray(int array[],int len)
{
    for(int i=0;i<len;i++)
        printf("%d  ",array[i]);
    printf("\n");
}

void merge(int *a, int start, int mid, int end)
{
    int *tmp = (int*)malloc(sizeof(int)*(end-start+1));
    int i = start;            // 第1个有序区的索引
    int j = mid + 1;          // 第2个有序区的索引
    int k = 0;                // 临时区域的索引
    while(i <= mid && j <= end)
    {
    if (a[i] <= a[j])
        tmp[k++] = a[i++];
    else
        tmp[k++] = a[j++];
    }
   while(i <= mid)tmp[k++] = a[i++];
   while(j <= end)tmp[k++] = a[j++];// 将排序后的元素，全部都整合到数组a中。
   for (i = 0; i < k; i++)a[start + i] = tmp[i];
    free(tmp);
}
void mergeSort(int array[], int len)
{
    for(int seg=1; seg < len; seg+=seg)
    {
        int k =0;
        for(k=0; k+2*seg-1 < len; k+=2*seg)
        {
            merge(array,k,k+seg-1,k+2*seg-1);
        }
        if(k+seg-1<len-1)
            merge(array, k, k+seg-1, len-1);
        printArray(array,len);
    }
}
@end
