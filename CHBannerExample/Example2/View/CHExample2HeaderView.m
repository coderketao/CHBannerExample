//
//  CHExample2HeaderView.m
//  CHBannerExample
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "CHExample2HeaderView.h"
#import <UIView+CustomCornerRadius.h>

@interface CHExample2HeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CHExample2HeaderView

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
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Getter

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    }
    return _imageView;
}

@end
