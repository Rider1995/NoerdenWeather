//
//  CitySelectView.h
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CitySelectCallback)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface CitySelectView : UIView
@property (nonatomic, strong) CitySelectCallback Callback;
@end

NS_ASSUME_NONNULL_END
