//
//  AFCustomManager.m
//  MA01
//
//  Created by PaddyGu on 2018/8/1.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import "AFCustomManager.h"

@implementation AFCustomManager

#pragma mark - get请求
+(void)get:(NSString *)url reqDic:(NSDictionary *)dic successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",@"image/png",@"application/json",nil];
    NSLog(@"AFCustomManager URL：%@",url);
    NSLog(@"AFCustomManager request：%@",dic);
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFCustomManager success ---> %@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFCustomManager failure ---> %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

#pragma mark - post请求
+(void)post:(NSString *)url reqDic:(NSDictionary *)dic successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    
    NSLog(@"AFCustomManager URL：%@",url);
    NSLog(@"AFCustomManager request：%@",dic);
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFCustomManager success ---> %@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFCustomManager failure ---> %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+(void)uploadImage:(NSString *)url parameterName:(NSString *)name image:(UIImage *)image successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    
    NSLog(@"AFCustomManager URL：%@",url);
    NSLog(@"AFCustomManager parameterName：%@",name);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",nil];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImagePNGRepresentation(image);
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. URL 的请求参数
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFCustomManager success ---> %@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFCustomManager failure ---> %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
