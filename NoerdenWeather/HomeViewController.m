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
    
    
    
    NSMutableString *url = [[NSMutableString alloc]initWithString:@"https://api.weather.gov/gridpoints"];
    switch (index) {
        case 0:
            [url appendString:@"/LOT/84,56/forecast"];
                  self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:CLLocationCoordinate2DMake(41.876009, -87.629595) zoom:15 bearing:0 viewingAngle:0];
            break;
        case 1:
            [url appendString:@"/OKX/32,34/forecast"];
                              self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:CLLocationCoordinate2DMake(40.709002,-74.005850) zoom:15 bearing:0 viewingAngle:0];
            break;
        case 2:
            [url appendString:@"/PSR/214,41/forecast"];
            self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:CLLocationCoordinate2DMake(25.762119, -80.193676) zoom:15 bearing:0 viewingAngle:0];
            break;
        case 3:
            [url appendString:@"/MTR/91,112/forecast"];
                        self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:CLLocationCoordinate2DMake(37.773773,-122.420721) zoom:15 bearing:0 viewingAngle:0];
            break;
            
        default:
            break;
    }
    [NetWorkTool GETRequestWith:url withParameters:@{} withCallback:^(BOOL success, NSError * _Nonnull error, id  _Nonnull result) {
        if (success) {
            NoerdenWeatherModel *model = [NoerdenWeatherModel mj_objectWithKeyValues:result];
            WeatherView *weatherView = [[WeatherView alloc]initWithFrame:CGRectMake(0, screenH, screenW, screenH - 100)];
            weatherView.index = index;
            weatherView.model = model;
            [self.view addSubview:weatherView];
        }
    }];
}


@end
