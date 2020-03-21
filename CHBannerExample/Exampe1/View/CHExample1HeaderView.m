//
//  CHExample1HeaderView.m
//  CHBannerExample
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "CHExample1HeaderView.h"
#import <UIView+CustomCornerRadius.h>

@interface CHExample1HeaderView ()

@property (nonatomic, strong) UIView *carView;
@property (nonatomic, strong) UIView *followView;

@end

@implementation CHExample1HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewAndMakeConstraint];
    }
    return self;
}

#pragma mark - Constraint

- (void)addSubviewAndMakeConstraint
{
    [self addSubview:self.carView];
    [self addSubview:self.followView];
    
    [self.carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-(55.0 * 0.5) - 15);
    }];
    
    [self.followView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0);
        make.right.equalTo(self).offset(-15.0);
        make.height.equalTo(@55.0);
        make.centerY.equalTo(self.carView.mas_bottom);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.carView customByRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:25.0];
}

#pragma mark - Getter

- (UIView *)carView
{
    if (!_carView) {
        _carView = [[UIView alloc] init];
        _carView.backgroundColor = QXHEXCOLOR(0x78d4f5);
    }
    return _carView;
}

- (UIView *)followView
{
    if (!_followView) {
        _followView = [[UIView alloc] init];
        _followView.backgroundColor = QXHEXCOLOR(0xffffff);
        _followView.layer.cornerRadius = 5.0;
        _followView.layer.masksToBounds = YES;
    }
    return _followView;
}

@end
