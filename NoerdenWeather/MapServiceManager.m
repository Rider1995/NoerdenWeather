//
//  MapServiceManager.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/15.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "MapServiceManager.h"

@interface MapServiceManager()<CLLocationManagerDelegate>


@end

@implementation MapServiceManager

+ (MapServiceManager *)sharedInstance {
    static MapServiceManager *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLocationManager];
    }
    return self;
}

-(void)setupLocationManager{
    self.locationManager = [CLLocationManager new];
    
    //每隔多少米定位一次（这里的设置为任何的移动）
    self.locationManager.distanceFilter= kCLDistanceFilterNone;
    //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    
    // 需要 Info.plist 添加KEY
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    
    
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    /**
     *    拿到授权发起定位请求
     
     */
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

// 定位失败后执行此方法
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ( [error code] == kCLErrorDenied ) {
        [self.locationManager stopUpdatingLocation];
    }
    else if ([error code] == kCLErrorHeadingFailure) {
        
    }
}

#pragma mark - CLLocationManagerDelegate -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     * 位置更新时调用
     */
    if (self.userLocation == nil) {
        self.userLocation = locations.firstObject;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Notify_ChangeUserLocation" object:self];
    }else{
        self.userLocation = locations.firstObject;
    }
}


@end
