//
//  ViewController.m
//  CHBannerExample
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "ViewController.h"
#import "CHExample1Controller.h"
#import "CHExample2Controller.h"

#import <QXUIKit.h>
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *example1Button;
@property (nonatomic, strong) UIButton *example2Button;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubviewAndMakeConstraint];
    [self addAction];
}

#pragma mark - Action

- (void)addAction
{
    [self.example1Button addTarget:self action:@selector(example1ButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.example2Button addTarget:self action:@selector(example2ButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)example1ButtonOnClick
{
    CHExample1Controller *controller = [CHExample1Controller new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)example2ButtonOnClick
{
    CHExample2Controller *controller = [CHExample2Controller new];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Constraint

- (void)addSubviewAndMakeConstraint
{
    [self.view addSubview:self.example1Button];
    [self.view addSubview:self.example2Button];
    
    [self.example1Button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200.0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@180.0);
        make.height.equalTo(@60.0);
    }];
    
    [self.example2Button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.example1Button.mas_bottom).offset(40.0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.example1Button);
        make.height.equalTo(self.example1Button);
    }];
}

#pragma mark - Getter

- (UIButton *)example1Button
{
    if (!_example1Button) {
        _example1Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _example1Button.layer.masksToBounds = YES;
        _example1Button.layer.cornerRadius = 7.0;
        _example1Button.backgroundColor = QXHEXCOLOR(0x78d4f5);
        [_example1Button setTitle:@"实例一" forState:UIControlStateNormal];
    }
    return _example1Button;
}

- (UIButton *)example2Button
{
    if (!_example2Button) {
        _example2Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _example2Button.layer.masksToBounds = YES;
        _example2Button.layer.cornerRadius = 7.0;
        _example2Button.backgroundColor = QXHEXCOLOR(0x78d4f5);
        [_example2Button setTitle:@"实例二" forState:UIControlStateNormal];
    }
    return _example2Button;
}

@end
