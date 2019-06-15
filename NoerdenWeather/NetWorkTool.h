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

@end

NS_ASSUME_NONNULL_END
