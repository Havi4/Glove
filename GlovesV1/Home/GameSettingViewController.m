//
//  GameSettingViewController.m
//  GlovesV1
//
//  Created by HaviLee on 2016/12/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//
#import "AKLookups.h"
#import "AKLookupsListViewController.h"
#import "AKMeme.h"
#import "TagView.h"
#import "GameSettingViewController.h"
#import "DataCollectionViewController.h"

@interface GameSettingViewController ()<AKLookupsDatasource, AKLookupsListDelegate>
{
    NSArray *_items;
    UIImageView *_memeImageView;
    AKLookups *_memeLookupBtn;
    AKMeme *_selectedMeme;
    TagView *view;
    BOOL _menuPresented;
    AKLookupsListViewController *_listVC;
}

@end

@implementation GameSettingViewController

-(id)init
{
    if (self = [super init]){
        _items = @[[AKMeme memeWithTitle:@"容易" imageName:@"fa.jpg"],
                   [AKMeme memeWithTitle:@"中等" imageName:@"tf.jpg"],
                   [AKMeme memeWithTitle:@"困难"  imageName:@"mg.jpg"],
                   ];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏设定";
    // Do any additional setup after loading the view.
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"background_image"];
    [self.view addSubview:backImageView];
    UILabel *gameLeval = [[UILabel alloc]init];
    gameLeval.text = @"游戏难度";
    gameLeval.font = kTitleNumberFont(17);
    [self.view addSubview:gameLeval];
    [gameLeval makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.equalTo(@100);
        make.height.equalTo(@44);
    }];

    _memeLookupBtn = [[AKLookups alloc] initWithLookupViewController:self.listVC];
    _memeLookupBtn.frame = CGRectMake(105.0f, 15, 150, 40.0f);
    [_memeLookupBtn selectItem:[AKMeme memeWithTitle:@"容易" imageName:@"fa.jpg"]];
    [_memeLookupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_memeLookupBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_memeLookupBtn setBackgroundColor:[UIColor lightGrayColor]];
    [_memeLookupBtn setArrowPosition:AKLookupsArrowPositionAfterTitle];
    [self.view addSubview:_memeLookupBtn];

    UILabel *gameLeval1 = [[UILabel alloc]init];
    gameLeval1.text = @"选择锻炼手指";
    gameLeval1.font = kTitleNumberFont(17);
    [self.view addSubview:gameLeval1];
    [gameLeval1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@44);
    }];
    view = [[TagView alloc] initWithFrame:CGRectMake(15, 110, kScreenSize.width-30, 200)];
    view.backgroundColor = [UIColor clearColor];
    view.tagViewButtonFont = 20;
    view.haveSelected = [NSMutableArray arrayWithArray:@[]];
    view.notSelected = [NSMutableArray arrayWithArray:@[@"大拇指",@"食指",@"中指",@"无名指",@"小拇指"]];
    [self.view addSubview:view];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"手指数据采集" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = kBarHightlightedColor;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(showData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.height.equalTo(@40);
    }];

}

- (void)showData:(UIButton *)sender
{
    if ([view selectedItem].count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择锻炼手指" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    DataCollectionViewController *data = [[DataCollectionViewController alloc]init];
    NSLog(@"ddddd%@",[view selectedItem]);
    data.fingerArr = [view selectedItem];
    data.settingDic = self.settingDic;
    data.level = _selectedMeme.lookupTitle;
    gameLevel = _selectedMeme.lookupTitle;
    [self.navigationController pushViewController:data animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lookup datasource
-(NSArray *)lookupsItems
{
    return _items;
}

-(id<AKLookupsCapableItem>)lookupsSelectedItem
{
    return _selectedMeme;
}

#pragma mark - Lookup delegate
-(void)lookups:(AKDropdownViewController *)lookups didSelectItem:(id<AKLookupsCapableItem>)item
{
    _selectedMeme = (AKMeme*)item;
    [_memeLookupBtn selectItem:item];
    [_memeLookupBtn closeLookup];
}
-(void)lookupsDidOpen:(AKDropdownViewController *)lookups
{
    _menuPresented = YES;
}
-(void)lookupsDidClose:(AKDropdownViewController *)lookups
{
    _menuPresented = NO;
}
-(void)lookupsDidCancel:(AKDropdownViewController *)lookups
{
    [_memeLookupBtn closeAnimation];
    _menuPresented = NO;
}

#pragma mark - Helpers
-(void)showMenu:(id)sender
{
    if (!_menuPresented){
        [self.listVC showDropdownViewBelowView:self.navigationController.navigationBar];
        _menuPresented = YES;
    }
}

-(AKLookupsListViewController*)listVC
{
    if (!_listVC){
        _listVC = [[AKLookupsListViewController alloc] initWithParentViewController:self.navigationController];
        _listVC.dataSource = self;
        _listVC.delegate = self;
        _listVC.bottomMargin = 15.0f;
    }
    return _listVC;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
