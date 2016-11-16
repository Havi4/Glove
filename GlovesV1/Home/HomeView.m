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
    
    NSArray *links = @[
                       /*
                        You can add your image url here.
                        */
                       
                       // progressive jpeg
                       @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                       
                       // animated gif: http://cinemagraphs.com/
                       @"http://i.imgur.com/uoBwCLj.gif",
                       @"http://i.imgur.com/8KHKhxI.gif",
                       @"http://i.imgur.com/WXJaqof.gif",
                       
                       // animated gif: https://dribbble.com/markpear
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                       
                       // animaged gif: https://dribbble.com/jonadinges
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                       
                       // jpg: https://dribbble.com/snootyfox
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       @"http://littlesvr.ca/apng/images/Contact.webp",
                       ];
    
    _imageLinks = links;

    
}

- (UITableView *)gameTable
{
    if (!_gameTable) {
        _gameTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenSize.width, kScreenSize.height-20) style:UITableViewStylePlain];
        _gameTable.delegate = self;
        _gameTable.dataSource = self;
        _gameTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _gameTable.backgroundColor = [UIColor clearColor];
    }
    return _gameTable;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
    [cell setImageURL:[NSURL URLWithString:_imageLinks[indexPath.row % _imageLinks.count]]];
    return cell;
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
