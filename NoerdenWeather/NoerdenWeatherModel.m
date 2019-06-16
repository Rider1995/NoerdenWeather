//
//  NoerdenWeatherModel.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "NoerdenWeatherModel.h"

@implementation NoerdenWeatherModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"context" : @"@context",
             };
}
@end

@implementation Geometry

+ (NSDictionary *)objectClassInArray{
    return @{@"geometries" : [Geometries class]};
}

@end


@implementation Geometries

@end


@implementation Properties

+ (NSDictionary *)objectClassInArray{
    return @{@"periods" : [Periods class]};
}

@end


@implementation Elevation

@end


@implementation Periods

@end



