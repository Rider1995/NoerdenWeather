//
//  ViewController.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/15.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "HomeViewController.h"
#import "NoerdenWeatherModel.h"
#import "CitySelectView.h"
#import "WeatherView.h"

@interface HomeViewController ()<GMSMapViewDelegate>
@property(nonatomic,strong) GMSMapView *googleMapView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadUserLocation:) name:@"Notify_ChangeUserLocation" object:nil];
}

-(void)setupUI{
    GMSMapView *googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 150)];
    self.googleMapView = googleMapView;
    googleMapView.delegate = self;
    googleMapView.indoorEnabled = NO;
    googleMapView.settings.rotateGestures = YES;
    googleMapView.settings.tiltGestures = NO;
    googleMapView.settings.myLocationButton = YES;
    googleMapView.myLocationEnabled = YES;
    googleMapView.accessibilityElementsHidden = NO;
    googleMapView.settings.compassButton = YES;
    googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:_MapServiceMgr.userLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
    [self.view insertSubview:googleMapView atIndex:0];
    
    CitySelectView *citySelectView = [[CitySelectView alloc]init];
    WeakSelf;
    citySelectView.Callback = ^(NSInteger index) {
        [weakSelf getWeatherWithIndex:index];
    };
    [self.view addSubview:citySelectView];
    [citySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(googleMapView.mas_bottom);
    }];
    
    
}


-(void)uploadUserLocation:(NSNotification *)noti{
        self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:_MapServiceMgr.userLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
}


-(void)getWeatherWithIndex:(NSInteger )index{
    [NetWorkTool GETRequestWith:@"https://api.weather.gov/gridpoints/LOT/84,56/forecast" withParameters:@{} withCallback:^(BOOL success, NSError * _Nonnull error, id  _Nonnull result) {
        if (success) {
            NoerdenWeatherModel *model = [NoerdenWeatherModel mj_objectWithKeyValues:result];
            WeatherView *weatherView = [[WeatherView alloc]initWithFrame:CGRectMake(0, screenH, screenW, screenH - 100)];
            weatherView.model = model;
            [self.view addSubview:weatherView];

            
        }
    }];
}


@end
