//
//  NetWorkTool.h
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/15.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 回调
 
 @param success 成功
 @param error 失败
 @param result 返回结果
 */
typedef void (^Callback)(BOOL success,NSError* error,id result);

@interface NetWorkTool : NSObject

#pragma mark - 基础的post网络请求方法，所有网络请求的公共方法
/**
 基础的post网络请求方法
 
 @param urlStr url连接
 @param parametersDic 参数字典
 @param callback 返回值
 */
+(void)POSTRequestWith:(NSString*)urlStr withParameters:(NSDictionary*)parametersDic withCallback:(Callback)callback;


#pragma mark - 基础的get网络请求方法
/**
 基础的get网络请求方法
 
 @param urlStr url连接
 @param parametersDic 参数字典
 @param callback 返回值
 */
+(void)GETRequestWith:(NSString*)urlStr withParameters:(NSDictionary*)parametersDic withCallback:(Callback)callback;


@end

NS_ASSUME_NONNULL_END
