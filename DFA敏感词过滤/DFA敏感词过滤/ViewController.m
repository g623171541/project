//
//  ViewController.m
//  DFA敏感词过滤
//
//  Created by 谷幸东 on 2021/3/26.
//

#import "ViewController.h"
#import "DFAFilter.h"
#import "FunctionRunTime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat time = [FunctionRunTime runTimeBlock:^{
            DFAFilter *dfaFilter = [[DFAFilter alloc] init];
            [dfaFilter parseSensitiveWords:nil];
            NSString *message = @"小明骂小王是个王八蛋，小王骂小明是个王八羔子！";
            NSLog(@"message == %@",message);
            NSString *result = [dfaFilter filterSensitiveWords:message replaceKey:nil];
            NSLog(@"result == %@",result);
        }];
        NSLog(@"总共耗时: %f \n\n", time);  // 总共耗时: 0.593791
    });
    
    
    // 运行在iPhoneX上内存会暴增4M左右，过后会恢复。
}


@end
