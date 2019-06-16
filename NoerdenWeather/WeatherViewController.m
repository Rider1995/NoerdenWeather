//
//  WeatherViewController.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "WeatherViewController.h"
#import "SnowEmitterLayer.h"
#import "RainEmitterLayer.h"
#import "CloudEmitterLayer.h"

@interface WeatherViewController ()
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)SnowEmitterLayer *snowEL;
@property (nonatomic, strong)RainEmitterLayer *rainEL;
@property (nonatomic, strong)CloudEmitterLayer *cloudEL;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imgView];
    
    // 下雪（雨夹雪、小雪、中雪、大雪）
    self.imgView.image = [UIImage imageNamed:@"weather_snow_day_static.jpg"];
    [self.view.layer addSublayer:self.snowEL];
    
    // 下雨（阵雨、雷阵雨、小雨、中雨、大雨）
    //     self.imgView.image = [UIImage imageNamed:@"weather_rain_day_static.jpg"];
    //     [self.view.layer addSublayer:self.rainEL];
    
    // 云（白天少云、白天多云、夜间少云，夜间多云）
    //    self.imgView.image = [UIImage imageNamed:@"weather_sunny_night_static.jpg"];
    //    [self.view.layer addSublayer:self.cloudEL];
    
    //    self.imgView.image = [UIImage imageNamed:@"weather_sunny_day_static.jpg"];
    //    [self.view.layer addSublayer:self.cloudEL];
}

#pragma mark - get/set

- (SnowEmitterLayer *)snowEL{
    if (!_snowEL) {
        _snowEL = [SnowEmitterLayer instanceWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) snowType:SNOW_SLEET_TYPE];
    }
    return _snowEL;
}

- (RainEmitterLayer *)rainEL{
    if (!_rainEL) {
        _rainEL = [RainEmitterLayer instanceWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) rainType:RAIN_LITTER_TYPE];
    }
    return _rainEL;
}

- (CloudEmitterLayer *)cloudEL{
    if (!_cloudEL) {
        _cloudEL = [CloudEmitterLayer instanceWithFrame:CGRectMake(0, 0, 1, self.view.frame.size.height) cloudType:CLOUD_MUCH_DAY_TYPE];
    }
    return _cloudEL;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        _imgView.image = [UIImage imageNamed:@"weather_na_static.jpg"];
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgView;
}

@end
