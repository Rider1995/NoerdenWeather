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
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];//允许返回的结果可改
    
    //    [manager.requestSerializer setValue:signStr forHTTPHeaderField:@"Signature"];
    
    
    //设置请求内容的类型
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if ([requestType isEqualToString:@"GET"])
    {
        [manager GET:urlStr parameters:parametersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            callback(YES,nil,responseObject);
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSLog(@"%@",error);
            callback(NO,nil,error);
        }];
    }
    
    else if([requestType isEqualToString:@"POST"])
    {
        [manager POST:urlStr parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress)
         {
         }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
             callback(YES,nil,responseObject);
         }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
             NSLog(@"%@",error);
             callback(NO,error,nil);
         }];
    }
}

@end