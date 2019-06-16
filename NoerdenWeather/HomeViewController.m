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

@interface HomeViewController ()<GMSMapViewDelegate>
@property(nonatomic,strong) GMSMapView *googleMapView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getWeather];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadUserLocation:) name:@"Notify_ChangeUserLocation" object:nil];
}

-(void)setupUI{
    GMSMapView *googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 200)];
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
    [self.view addSubview:citySelectView];
    [citySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(120);
    }];
    
}


-(void)uploadUserLocation:(NSNotification *)noti{
        self.googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:_MapServiceMgr.userLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
}


-(void)getWeather{
    [NetWorkTool GETRequestWith:@"https://api.weather.gov/gridpoints/LOT/84,56/forecast" withParameters:@{} withCallback:^(BOOL success, NSError * _Nonnull error, id  _Nonnull result) {
        if (success) {
            NoerdenWeatherModel *model = [NoerdenWeatherModel mj_objectWithKeyValues:result];
            NSLog(@"1");
        }
    }];
}


@end
