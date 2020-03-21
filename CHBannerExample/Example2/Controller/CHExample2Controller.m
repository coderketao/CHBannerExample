//
//  CHExample2Controller.m
//  CHBannerExample
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "CHExample2Controller.h"
#import "CHTableViewCell.h"
#import "CHExample2HeaderView.h"

@interface CHExample2Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CHExample2HeaderView *headerBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

@implementation CHExample2Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubviewAndMakeConstraint];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

#pragma mark - Constraint

- (void)addSubviewAndMakeConstraint
{
    [self.view addSubview:self.headerBgView];
    [self.view addSubview:self.tableView];
    
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.headerBgView.mas_width).multipliedBy(0.8);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHExample2" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView.contentOffset.y > 0) {
      [self.headerBgView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.view).offset(-scrollView.contentOffset.y);
      }];
  } else {
      [self.headerBgView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.width.equalTo(self.view).offset(fabs(scrollView.contentOffset.y));
      }];
  }
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[CHTableViewCell class] forCellReuseIdentifier:@"CHExample2"];
    }
    return _tableView;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableHeaderView.qx_height = 230;
    }
    return _tableHeaderView;
}

- (CHExample2HeaderView *)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[CHExample2HeaderView alloc] init];
        _headerBgView.backgroundColor = QXHEXCOLOR(0x78d4f5);
    }
    return _headerBgView;
}

@end
