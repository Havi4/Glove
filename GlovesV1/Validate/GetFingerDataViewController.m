//
//  GetFingerDataViewController.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/28.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "GetFingerDataViewController.h"

@interface GetFingerDataViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingView;

@end

@implementation GetFingerDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableView *)settingView
{
    if (!_settingView) {
        _settingView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _settingView.delegate = self;
        _settingView.dataSource = self;
    }
    return _settingView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"最大握力";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"最小握力";
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
