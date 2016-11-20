//
// HomeView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "HomeView.h"
#import "UIView+MIPipeline.h"
#import "HomePipeline.h"
#import "PopListButton.h"
#import "GameTableViewCell.h"

@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HomePipeline *pipeline;
@property (nonatomic, strong) UITableView *gameTable;
@property (nonatomic, strong) NSArray *imageLinks;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)didMoveToWindow
{
    [super didMoveToSuperview];
    [self scrollViewDidScroll:self.gameTable];
}

- (void)setupViews
{
    [self addSubview:self.gameTable];
    PopListButton *popButton = [[PopListButton alloc]initWithFrame:CGRectMake(kScreenSize.width-50, kScreenSize.height-50, 30, 30)
                                buttonType:buttonMenuType
                               buttonStyle:buttonRoundedStyle
                     animateToInitialState:YES];
    popButton.roundBackgroundColor = [UIColor whiteColor];
    popButton.lineThickness = 2;
    popButton.lineRadius = 1;
    popButton.tintColor = [UIColor flatPeterRiverColor];
    [self addSubview:popButton];
    popButton.clickBlock = ^(NSInteger integer){
        DeBugLog(@"%zd",integer);
    };
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Games" ofType:@"plist"];
    NSArray *games = [NSArray arrayWithContentsOfFile:path];
    _imageLinks = games;

    
}

- (UITableView *)gameTable
{
    if (!_gameTable) {
        _gameTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64-49) style:UITableViewStylePlain];
        _gameTable.delegate = self;
        _gameTable.dataSource = self;
        _gameTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _gameTable.backgroundColor = [UIColor clearColor];
    }
    return _gameTable;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [cell setImageURL:[NSURL URLWithString:[[_imageLinks objectAtIndex:indexPath.row] objectForKey:@"gamePreview"]]];
    [cell configCell:[_imageLinks objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.pipeline.gameUrl = [[_imageLinks objectAtIndex:indexPath.row] objectForKey:@"gameUrl"];
    self.pipeline.selectedIndexPath = indexPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (GameTableViewCell *cell in [self.gameTable visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        if (kiOS8Later) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                cell.backView.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:NULL];
        } else {
            cell.backView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
