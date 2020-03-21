//
//  CHExample1Controller.m
//  CHBannerExample
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "CHExample1Controller.h"
#import "CHTableViewCell.h"
#import "CHExample1HeaderView.h"

static const CGFloat HeaderViewHeight = 260.0;

@interface CHExample1Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CHExample1HeaderView *tableHeaderView;
@property (nonatomic, strong) MJRefreshStateHeader *mjHeader;

@end

@implementation CHExample1Controller

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView bringSubviewToFront:self.tableView.mj_header];
}

#pragma mark - Constraint

- (void)addSubviewAndMakeConstraint
{
    [self.view addSubview:self.headerBgView];
    [self.view addSubview:self.tableView];
    
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(HeaderViewHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - HTTP

- (void)request
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHExample1" forIndexPath:indexPath];
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
          make.top.equalTo(self.view);
          make.height.equalTo(@(HeaderViewHeight + fabs(scrollView.contentOffset.y)));
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
        _tableView.mj_header = self.mjHeader;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[CHTableViewCell class] forCellReuseIdentifier:@"CHExample1"];
    }
    return _tableView;
}

- (UIView *)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc] init];
        _headerBgView.backgroundColor = QXHEXCOLOR(0x78d4f5);
    }
    return _headerBgView;
}

- (CHExample1HeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[CHExample1HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.qx_width, HeaderViewHeight)];
        _tableHeaderView.backgroundColor = QXHEXCOLOR(0xf4f4f4);
    }
    return _tableHeaderView;
}

- (MJRefreshStateHeader *)mjHeader
{
    if (!_mjHeader) {
        self.mjHeader = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
        self.mjHeader.stateLabel.textColor = QXHEXCOLOR(0xffffff);
        self.mjHeader.lastUpdatedTimeLabel.textColor = QXHEXCOLOR(0xffffff);
        self.mjHeader.ignoredScrollViewContentInsetTop = -36;
    }
    return _mjHeader;
}

@end
