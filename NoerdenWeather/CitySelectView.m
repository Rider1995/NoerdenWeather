//
//  CitySelectView.m
//  NoerdenWeather
//
//  Created by 梁磊 on 2019/6/16.
//  Copyright © 2019 梁磊. All rights reserved.
//

#import "CitySelectView.h"

@interface CitySelectCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@implementation CitySelectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    titleLabel.font = TextFont(12);
    titleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
        make.bottom.centerX.equalTo(self);
    }];
    
}



@end



@interface CitySelectView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *cityNames;
@property (nonatomic, strong) NSArray *cityImages;
@property (nonatomic, strong) NSMutableArray<UIButton *> *cityButtons;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CitySelectView

-(NSArray *)cityNames{
    if (!_cityNames) {
        _cityNames = @[@"Chicago",@"New York",@"Miami",@"San Francisco"];
    }
    return _cityNames;
}

-(NSArray *)cityImages{
    if (!_cityImages) {
        _cityImages = @[@"Chicago",@"New York",@"Miami",@"San Francisco"];
    }
    return _cityImages;
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

    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(80, 100);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 15;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[CitySelectCell class] forCellWithReuseIdentifier:@"Cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
    }];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CitySelectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.cityNames[indexPath.row];
    cell.iconImageView.image = ImageNamed(self.cityImages[indexPath.row]);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.Callback(indexPath.row);
}


@end
