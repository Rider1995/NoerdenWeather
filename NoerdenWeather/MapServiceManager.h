//
//  MapServiceManager.h
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/15.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapServiceManager : NSObject

@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) CLLocation* userLocation;
+(MapServiceManager *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
