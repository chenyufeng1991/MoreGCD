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
    //当然也可以使用系统提供的global_queue,main_queue
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
    //注意传入的第二个参数，如果是serial或者NULL，表示是串行队列；如果是concurrent，表示是并行队列。
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
    dispatch_queue_t syncQueue = dispatch_queue_create("my.serial.syncQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_sync(syncQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    NSLog(@"4");
    dispatch_release(syncQueue);
#endif

#if 0
    dispatch_queue_t asyncQueue = dispatch_queue_create("my.serial.asyncQueue", DISPATCH_QUEUE_SERIAL);
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
        //进入另一个线程,处理耗时的代码块

        dispatch_async(dispatch_get_main_queue(), ^{
            //返回主线程刷新

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
    //GCD的高级用法 线程组;线程组和信号量机制都可以实现队列的同步。
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


#if 0
    //信号量
    /**
     *  创建一个信号量。参数指定信号量的起始值。这个数字是你可以访问的信号量，不需要先去增加它的数量（增加信号量也叫作发射信号量）。
     
     初始value = 0时，信号量--，小于0，wait线程阻塞。然后执行signal，信号量++，激活wait线程。
     *
     */
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"chen");
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSLog(@"yu");
        dispatch_semaphore_signal(sema);
    });
#endif


#if 0
    //后台执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //后台执行

    });

    //主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
        //主线程执行

    });
#endif

#if 0
    //dispatch_barrier_async,对于同一个队列中的不同任务而言，在dispatch_barrier_async之前的先执行，在dispatch_barrier_async后面的后执行
    //如下面的代码所示：1和2的执行顺序不一定，但一定在dispatch_barrier_async之前执行，3和4的执行顺序不一定，但一定在dispatch_barrier_async之后执行。
    //注意dispatch_barrier_async的同步控制和线程组、信号量的同步机制粒度大小是不一样的，dispatch_barrier_async是对于同一个队列中的不同任务而言的，线程组和信号量是对于不同线程而言的。
    dispatch_queue_t queue = dispatch_queue_create("my.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });

    dispatch_async(queue, ^{
        NSLog(@"2");
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
    });

    dispatch_async(queue, ^{
        NSLog(@"3");
    });

    dispatch_async(queue, ^{
        NSLog(@"4");
    });
#endif


#if 0
    //dispatch_apply是把某个代码块执行N遍
    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zu",index);
    });
#endif

}

- (IBAction)buttonClicked:(id)sender
{
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
