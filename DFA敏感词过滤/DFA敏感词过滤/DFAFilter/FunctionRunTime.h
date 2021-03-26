//
//  FunctionRunTime.h
//  OC_DEMO
//
//  Created by 张福杰 on 2019/10/21.
//  Copyright © 2019 张福杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <mach/mach_time.h>

typedef void (^block)(void);

@interface FunctionRunTime : NSObject

+ (CGFloat)runTimeBlock:(block)block;

@end
