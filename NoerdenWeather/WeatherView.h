//
//  WeatherView.h
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/17.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoerdenWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherView : UIView
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NoerdenWeatherModel *model;
@property (nonatomic, strong) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
