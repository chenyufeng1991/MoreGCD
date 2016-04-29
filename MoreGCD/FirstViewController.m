//
//  FirstViewController.m
//  MoreGCD
//
//  Created by chenyufeng on 16/4/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FirstViewController.h"
#import "ThirdViewController.h"

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
    dispatch_release(syncQueue);//最好需要释放

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
    dispatch_release(asyncQueue);
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
    dispatch_release(syncQueue);
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
    dispatch_release(asyncQueue);
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
    //在该应用声明周期内，下面的代码只会被执行一次。并且是线程安全的。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"仅会被执行一次");
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
     （1）运行在主线程的Main Queue,通过dispatch_get_main_queue获得。其实dispatch_get_main_queue也是一种dispatch_queue_t.
      (2) 并行队列global dispatch queue ,通过dispatch_get_global_queue 获得。
     （3）串行队列，一般用于顺序同步访问，可以创建任意数量的串行队列，每个串行队列之间是并发的。serial queue可以通过dispatch_queue_create创建。
     */


#if 0
    NSLog(@"1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟3s执行这里");
    });
#endif



    dispatch_async(dispatch_get_global_queue(0, 0), ^{

    });






}

- (IBAction)buttonClicked:(id)sender
{
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
