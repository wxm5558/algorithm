//
//  ViewController.m
//  HeapSortTest
//
//  Created by wangxiaoman on 2021/2/24.
//  Copyright © 2021 wangxiaoman. All rights reserved.
//

#import "ViewController.h"
#import "MsgForwardTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
    int arr[10]={10,4,2,8,9,7,6,5,1,3};
    swapAndSort(arr,10);
}
- (void)test
{
    MsgForwardTest*t = [MsgForwardTest new];
    [t performSelector:@selector(test)];
}

void printArray(int array[], int len)
{
    for(int i=0; i<len;i++)
    {
        printf("%d ",array[i]);
    }
    printf("\n");
}


void swap(int array[], int i,int j)
{
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

void swapAndSort(int array[], int len)
{
    for(int i = len; i>0;i--)
    {
        heapSort(array,i);
        swap(array, 0, i-1);
        printArray(array,len);
    }
}

void heapSort(int array[], int len)
{
    for(int i = len/2-1; i>=0; i--)
    {
        int l = 2*i+1,r = l+1;
        int largeIndex = i;
        if(l<len && array[i]<=array[l])largeIndex=l;
        if(r<len && array[l]<=array[r])largeIndex=r;
        if(largeIndex!=i){
            swap(array,i,largeIndex);
            int l_large = 2*largeIndex+1,r_large=l_large+1;
            if((l_large<len && array[largeIndex] <= array[l_large])||
               (r_large<len && array[largeIndex] <= array[r_large]))
            {
                heapSort(array, len);
            }
        }
    }
}
@end
