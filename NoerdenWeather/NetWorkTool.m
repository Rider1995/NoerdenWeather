//
//  NetWorkTool.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/15.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "NetWorkTool.h"



@implementation NetWorkTool


+(void)PublicMethodRequestWith:(NSString*)urlStr
                withParameters:(NSDictionary*)parametersDic
                      withType:(NSString*)requestType
                  withCallback:(Callback)callback
{
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;//移除null的字符串
    [manager.requestSerializer setTimeoutInterval:15];//15秒超时
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if ([requestType isEqualToString:@"GET"])
    {
        [manager GET:urlStr parameters:parametersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            NSString  * receive = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding ];
            NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            callback(YES,nil,dict);
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSLog(@"%@",error);
            callback(NO,error,nil);
        }];
    }
    
    else if([requestType isEqualToString:@"POST"])
    {
        [manager POST:urlStr parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress)
         {
         }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
             NSString  * receive = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding ];
             NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
             callback(YES,nil,dict);
         }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
             NSLog(@"%@",error);
             callback(NO,error,nil);
         }];
    }
}

#pragma mark - 基础的post网络请求方法，所有网络请求的公共方法
/**
 基础的post网络请求方法
 
 @param urlStr url连接
 @param parametersDic 参数字典
 @param callback 返回值
 */
+(void)POSTRequestWith:(NSString*)urlStr withParameters:(NSDictionary*)parametersDic withCallback:(Callback)callback
{
    [self PublicMethodRequestWith:urlStr
                   withParameters:(NSDictionary*)parametersDic
                         withType:@"POST"
                     withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,error,result);
         }
     }];
}

#pragma mark - 基础的get网络请求方法

+(void)GETRequestWith:(NSString*)urlStr withParameters:(NSDictionary*)parametersDic withCallback:(Callback)callback
{
    [self PublicMethodRequestWith:urlStr
                   withParameters:(NSDictionary*)parametersDic
                         withType:@"GET"
                     withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,error,result);
         }
         else
         {
             callback(NO,error,result);
         }
     }];
}

@end
