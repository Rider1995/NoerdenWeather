//
//  WeatherView.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/17.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "WeatherView.h"
#import "SnowEmitterLayer.h"
#import "RainEmitterLayer.h"
#import "CloudEmitterLayer.h"


@interface WeatherViewHeader : UIView

@property (nonatomic, strong) Periods *periods;
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *shortForecastLabel;
@property (nonatomic, strong) UILabel *windLabel;
@property (nonatomic, strong) UILabel *windDirectionLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation WeatherViewHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    UILabel *cityNameLabel = [[UILabel alloc]init];
    self.cityNameLabel = cityNameLabel;
    cityNameLabel.font = TextFont(18);
    cityNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:cityNameLabel];
    [cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self).offset(25);
    }];
    
    UILabel *temperatureLabel = [[UILabel alloc]init];
    self.temperatureLabel = temperatureLabel;
    temperatureLabel.font = TextFont(60);
    temperatureLabel.textColor = [UIColor whiteColor];
    [self addSubview:temperatureLabel];
    [temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cityNameLabel);
        make.top.equalTo(cityNameLabel.mas_bottom).offset(15);
    }];
    
    UILabel *shortForecastLabel = [[UILabel alloc]init];
    self.shortForecastLabel = shortForecastLabel;
    shortForecastLabel.font = TextFont(15);
    shortForecastLabel.textColor = [UIColor whiteColor];
    [self addSubview:shortForecastLabel];
    [shortForecastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cityNameLabel);
        make.top.equalTo(temperatureLabel.mas_bottom).offset(25);
    }];
    
    UIImageView *windImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"windspeed")];;
    [self addSubview:windImageView];
    [windImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cityNameLabel);
        make.top.equalTo(shortForecastLabel.mas_bottom).offset(5);
    }];
    
    UILabel *windLabel = [[UILabel alloc]init];
    self.windLabel = windLabel;
    windLabel.font = TextFont(15);
    windLabel.textColor = [UIColor whiteColor];
    [self addSubview:windLabel];
    [windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(windImageView);
        make.leading.equalTo(windImageView.mas_trailing).offset(10);
    }];
    
    UIImageView *windDirectionImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"direction")];
    [self addSubview:windDirectionImageView];
    [windDirectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(windImageView);
        make.leading.equalTo(windLabel.mas_trailing).offset(20);
    }];
    
    UILabel *windDirectionLabel = [[UILabel alloc]init];
    windDirectionLabel.font = TextFont(15);
    windDirectionLabel.textColor = [UIColor whiteColor];
    self.windDirectionLabel = windDirectionLabel;
    [self addSubview:windDirectionLabel];
    [windDirectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(windLabel);
        make.leading.equalTo(windDirectionImageView.mas_trailing).offset(10);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    contentLabel.font = TextFont(14);
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cityNameLabel);
        make.trailing.lessThanOrEqualTo(@-15);
        make.top.equalTo(windImageView.mas_bottom).offset(30);
        make.bottom.equalTo(self).offset(-25);
    }];
    
}

-(void)setPeriods:(Periods *)periods{
    _periods = periods;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@%@",periods.temperature,periods.temperatureUnit];
    self.shortForecastLabel.text = periods.shortForecast;
    self.windLabel.text = periods.windSpeed;
    self.windDirectionLabel.text = periods.windDirection;
    self.contentLabel.text = periods.detailedForecast;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self];
    
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    
    self.superview.transform = CGAffineTransformTranslate(self.superview.transform, 0, offsetY);
    
}

@end




@interface WeatherViewCell : UITableViewCell
@property (nonatomic, strong) Periods *periods;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

@implementation WeatherViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    titleLabel.font = TextFont(14);
    titleLabel.textColor = UIColorFromRGB(0x666666);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(25);
    }];
    
    UILabel *temperatureLabel = [[UILabel alloc]init];
    self.temperatureLabel = temperatureLabel;
    temperatureLabel.font = TextFont(14);
    temperatureLabel.textColor = UIColorFromRGB(0x666666);
    [self addSubview:temperatureLabel];
    [temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.trailing.equalTo(self).offset(-15);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = UIColorFromRGB(0x666666);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
}


-(void)setPeriods:(Periods *)periods{
    _periods = periods;
    self.titleLabel.text = periods.name;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@%@",periods.temperature,periods.temperatureUnit];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:periods.icon]];
}



@end

@interface WeatherView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) WeatherViewHeader *header;
@property (nonatomic, strong)SnowEmitterLayer *snowEL;
@property (nonatomic, strong)RainEmitterLayer *rainEL;
@property (nonatomic, strong)CloudEmitterLayer *cloudEL;
@property (nonatomic, strong) NSArray *cityNames;
@end

@implementation WeatherView

-(NSArray *)cityNames{
    if (!_cityNames) {
        _cityNames = @[@"Chicago",@"New York",@"Miami",@"San Francisco"];
    }
    return _cityNames;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame
            ];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setModel:(NoerdenWeatherModel *)model{
    _model = model;
    self.header.cityNameLabel.text = self.cityNames[self.index];
    self.header.periods = self.model.properties.periods.firstObject;
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self heightForString:self.model.properties.periods.firstObject.detailedForecast fontSize:14 andWidth:screenW - 40] + 280);
    }];
    
    if ([self.model.properties.periods.firstObject.shortForecast containsString:@"Cloudy"]) {
        // 云（白天少云、白天多云、夜间少云，夜间多云）
        self.imgView.image = [UIImage imageNamed:@"weather_sunny_night_static.jpg"];
        [self.layer addSublayer:self.cloudEL];
    }else if ([self.model.properties.periods.firstObject.shortForecast containsString:@"Sunny"]){
        self.imgView.image = [UIImage imageNamed:@"weather_sunny_day_static.jpg"];
        [self.layer addSublayer:self.cloudEL];
    }else if ([self.model.properties.periods.firstObject.shortForecast containsString:@"Showers"]){
        // 下雨（阵雨、雷阵雨、小雨、中雨、大雨）
        self.imgView.image = [UIImage imageNamed:@"weather_rain_day_static.jpg"];
        [self.layer addSublayer:self.rainEL];
    }else if ([self.model.properties.periods.firstObject.shortForecast containsString:@"Showers"]){
        // 下雪（雨夹雪、小雪、中雪、大雪）
        self.imgView.image = [UIImage imageNamed:@"weather_snow_day_static.jpg"];
        [self.layer addSublayer:self.snowEL];
    }
    
    [self.tableView reloadData];
}


-(void)setupUI{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, screenH - 180, screenW, screenH - 100);
    }];
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.imgView];
    
    
    self.backgroundColor = [UIColor lightGrayColor];
    WeatherViewHeader *header = [[WeatherViewHeader alloc]init];
    header.backgroundColor = [UIColor clearColor];
    self.header = header;
    header.cityNameLabel.text = self.cityNames[self.index];
    header.periods = self.model.properties.periods.firstObject;
    [self addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.mas_equalTo(200);
    }];
    
    
    
    UIButton *closeButton = [[UIButton alloc]init];
    closeButton.layer.shadowOffset = CGSizeMake(0, 0);
    closeButton.layer.shadowColor = UIColorFromRGB(0x333333).CGColor;
    closeButton.layer.shadowOpacity = 1;
    [closeButton setImage:ImageNamed(@"btn_tanchuang_quxiao_nor") forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self);
        make.width.height.mas_equalTo(50);
    }];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    tableView.layer.cornerRadius = 10;
    tableView.layer.masksToBounds = YES;
    tableView.layer.borderWidth = 1;
    tableView.layer.borderColor = [UIColorFromRGB(0x999999) CGColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 20;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[WeatherViewCell class] forCellReuseIdentifier:@"Cell"];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_bottom).offset(15);
        make.bottom.equalTo(self).offset(-20);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
    }];
    
    
    
}

#pragma mark - UITableViewDelegate&UITableViewDataSource代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.properties.periods.count - 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.periods = self.model.properties.periods[indexPath.row + 1];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)closeButtonClick:(UIButton *)button{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, screenH, screenW, screenH - 100);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - get/set

- (SnowEmitterLayer *)snowEL{
    if (!_snowEL) {
        _snowEL = [SnowEmitterLayer instanceWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) snowType:SNOW_SLEET_TYPE];
    }
    return _snowEL;
}

- (RainEmitterLayer *)rainEL{
    if (!_rainEL) {
        _rainEL = [RainEmitterLayer instanceWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) rainType:RAIN_LITTER_TYPE];
    }
    return _rainEL;
}

- (CloudEmitterLayer *)cloudEL{
    if (!_cloudEL) {
        _cloudEL = [CloudEmitterLayer instanceWithFrame:CGRectMake(0, 0, 1, self.frame.size.height) cloudType:CLOUD_MUCH_DAY_TYPE];
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


- (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width

{
    
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return sizeToFit.height;
    
}

@end
