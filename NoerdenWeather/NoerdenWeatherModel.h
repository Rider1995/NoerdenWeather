//
//  NoerdenWeatherModel.h
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Geometry,Geometries,Properties,Elevation,Periods;
@interface NoerdenWeatherModel : NSObject

@property (nonatomic, strong) Properties *properties;

@property (nonatomic, strong) NSArray *context;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) Geometry *geometry;

@end
@interface Geometry : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray *geometries;

@end

@interface Geometries : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray *coordinates;

@end

@interface Properties : NSObject

@property (nonatomic, copy) NSString *updated;

@property (nonatomic, copy) NSString *forecastGenerator;

@property (nonatomic, copy) NSString *generatedAt;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *validTimes;

@property (nonatomic, strong) Elevation *elevation;

@property (nonatomic, strong) NSArray *periods;

@property (nonatomic, copy) NSString *units;

@end

@interface Elevation : NSObject

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, copy) NSString *unitCode;

@end

@interface Periods : NSObject

@property (nonatomic, copy) NSString *windDirection;

@property (nonatomic, assign) NSInteger temperature;

@property (nonatomic, copy) NSString *windSpeed;

@property (nonatomic, copy) NSString *temperatureTrend;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *temperatureUnit;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *shortForecast;

@property (nonatomic, assign) BOOL isDaytime;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *detailedForecast;

@end


