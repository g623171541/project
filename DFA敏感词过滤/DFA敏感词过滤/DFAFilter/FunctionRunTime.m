//
//  FunctionRunTime.m
//  OC_DEMO
//
//  Created by 张福杰 on 2019/10/21.
//  Copyright © 2019 张福杰. All rights reserved.
//

#import "FunctionRunTime.h"

@implementation FunctionRunTime

+ (CGFloat)runTimeBlock:(block)block{
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return - 1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
}

@end
