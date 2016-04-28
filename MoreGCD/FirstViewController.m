//
//  FirstViewController.m
//  MoreGCD
//
//  Created by chenyufeng on 16/4/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //同步操作
#if 0
    //dispatch_queue_t 也可以自己定义，如果要自定义，可以用dispatch_queue_create方法。
    dispatch_queue_t syncQueue = dispatch_queue_create("my.concurrent.syncQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(syncQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    
    NSLog(@"4");
#endif

    //异步操作
#if 0
    dispatch_queue_t asyncQueue = dispatch_queue_create("my.concurrent.asyncQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(asyncQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    NSLog(@"4");
#endif

#if 0
    dispatch_queue_t syncQueue = dispatch_queue_create("my.concurrent.syncQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(syncQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    NSLog(@"4");
#endif

#if 0
    dispatch_queue_t asyncQueue = dispatch_queue_create("my.concurrent.asyncQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    //第一个参数是指定了一个GCD队列，第二个参数是分配事务到该队列。
    dispatch_async(asyncQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    NSLog(@"4");
#endif

#if 0
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //进入另一个线程

        dispatch_async(dispatch_get_main_queue(), ^{
            //返回主线程

        });
    });
#endif


#if 0
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
#endif


#if 0
    //GCD的高级用法 线程组
   __block int i;
   __block int j;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        i = 1;
    });

    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        j = 2;
    });

    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%d",i+j);
    });
#endif

    /**
     *  dispatch queue共有三种：
     （1）运行在主线程的Main Queue,通过dispatch_get_main_queue获得。
     */




}

@end
