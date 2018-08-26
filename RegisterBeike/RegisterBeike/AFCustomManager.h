//
//  AFCustomManager.h
//  MA01
//
//  Created by PaddyGu on 2018/8/1.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFCustomManager : NSObject

typedef void (^SuccessBlock) (id responseObject);
typedef void (^FailureBlock) (id error);

// get请求
+(void)get:(NSString *)url reqDic:(NSDictionary *)dic successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

// post请求
+(void)post:(NSString *)url reqDic:(NSDictionary *)dic successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

// 上传图片
+(void)uploadImage:(NSString *)url parameterName:(NSString *)name image:(UIImage *)image successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
