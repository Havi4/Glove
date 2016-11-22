//
//  CardBlueView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "CardBlueView.h"
#import "BluetoothModel.h"
#import "WeChatStylePlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"

@interface CardBlueView ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate, WeChatStylePlaceHolderDelegate>

@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation CardBlueView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGRect rect;
    rect = CGRectMake(0, 0, 48, 48);
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    avatarImageView.image = [UIImage imageNamed:@"background_image"];
    
        //Round the corners
    CALayer * layer = [avatarImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:9.0];
    
        //Add a shadow by wrapping the avatar into a container
    UIView * shadow = [[UIView alloc] initWithFrame: self.bounds];
    avatarImageView.frame = CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height);
    
        // setup shadow layer and corner
    shadow.layer.shadowColor = [UIColor grayColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0, 1);
    shadow.layer.shadowOpacity = 1;
    shadow.layer.shadowRadius = 9.0;
    shadow.layer.cornerRadius = 9.0;
    shadow.clipsToBounds = NO;
    
        // combine the views  
    [shadow addSubview: avatarImageView];
    
    [self addSubview:shadow];
    
    self.tableList = [[UITableView alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10) style:UITableViewStyleGrouped];
    self.tableList.delegate = self;
    self.tableList.dataSource = self;
    self.tableList.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"radar_device"];
    BluetoothModel *model = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = model.bluetoothName;
    cell.textLabel.textColor = kBarNormalColor;
    cell.backgroundColor = [UIColor clearColor];
    if ([model.bluetoothName isEqualToString:selectedBlueName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)viewDidLayoutSubviews {
    if ([self.tableList respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableList setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableList respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableList setLayoutMargins:UIEdgeInsetsZero];
    }

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    BluetoothModel *model = [self.dataList objectAtIndex:indexPath.row];
    currPeripheral = model.currentPeripheral;
    selectedBlueName = model.bluetoothName;
    self.cellTaped(indexPath);
}

- (void)setBluetoothList:(NSArray *)bluetoothList
{
    self.dataList = bluetoothList;
    [self.tableList cyl_reloadData];
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method

- (UIView *)makePlaceHolderView {
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableList.frame];
    weChatStylePlaceHolder.delegate = self;
    return weChatStylePlaceHolder;
}

#pragma mark - WeChatStylePlaceHolderDelegate Method

- (void)emptyOverlayClicked:(id)sender {
    self.tapScanAgain(nil);
}


@end
