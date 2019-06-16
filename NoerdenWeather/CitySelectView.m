//
//  CitySelectView.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "CitySelectView.h"

@interface CitySelectView()
@property (nonatomic, strong) NSArray *cityNames;
@property (nonatomic, strong) NSMutableArray<UIButton *> *cityButtons;
@end

@implementation CitySelectView

-(NSArray *)cityNames{
    if (!_cityNames) {
        _cityNames = @[@"Chicago",@"New-York",@"Miami",@"San Francisco"];
    }
    return _cityNames;
}

-(NSMutableArray<UIButton *> *)cityButtons{
    if (!_cityButtons) {
        _cityButtons = [[NSMutableArray alloc]init];
    }
    return _cityButtons;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (NSString *cityName in self.cityNames) {
        UIButton *cityButton = [[UIButton alloc]init];
        [cityButton setTitle:cityName forState:UIControlStateNormal];
        [cityButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [cityButton.titleLabel setFont:TextFont(14)];
        [self addSubview:cityButton];
        [cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(30);
            if ([cityName isEqual:self.cityNames.firstObject]) {
                make.top.equalTo(self);
            }else{
                make.top.equalTo(self.cityButtons.lastObject.mas_bottom);
            }
        }];
        [self.cityButtons addObject:cityButton];
        
        if (![cityName isEqual:self.cityNames.lastObject]) {
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = UIColorFromRGB(0xf5f5f5);
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self).offset(5);
                make.trailing.equalTo(self).offset(-5);
                make.top.equalTo(cityButton.mas_bottom);
                make.height.mas_equalTo(1);
            }];
        }
    }

}

@end
