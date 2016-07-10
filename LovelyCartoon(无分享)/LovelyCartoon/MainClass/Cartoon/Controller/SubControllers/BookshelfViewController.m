//
//  BookshelfViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "BookshelfViewController.h"
#import "ResultsModel+DataBase.h"
#import "CartoonDetailViewController.h"

NSString *BookshelfCell = @"BookshelfTableViewCell";
@interface BookshelfViewController ()<UITableViewDelegate>

@end

@implementation BookshelfViewController

-(void)viewWillAppear:(BOOL)animated{
    [self loadDataSource];

    MyLog(@"%f", self.view.frame.origin.y);


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, 29)];
//    view.backgroundColor = [UIColor redColor];
    
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 49 - 64);
    
    [self.view addSubview:self.tableView];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadDataSource{
    self.dataSource = [[ResultsModel selectAllCartoons] mutableCopy];
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookshelfCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bookshelfCell"];
    }
    
    ResultsModel *model = self.dataSource[indexPath.row];
    
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    NSString *desStr;
    if (model.introduction.length > 15) {
        desStr = [model.introduction substringToIndex:15];
    }else{
        desStr = model.introduction;
    }
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14 * GlobalScale];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"\n作者:%@\n\n更新时间:%@\n\n简介:%@...", model.author, model.recentUpdateTime,desStr];
    cell.detailTextLabel.numberOfLines = 0;
    

    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    deleteBtn.tag = indexPath.row;
    deleteBtn.frame = CGRectMake(WIDTH - 80 * GlobalScale, (130 - 20) * GlobalScale / 2, 50 * GlobalScale, 20 * GlobalScale);
    deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16 * GlobalScale];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:deleteBtn];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130 * GlobalScale;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResultsModel *model = self.dataSource[indexPath.row];
    CartoonDetailViewController *cartoonVC = [[CartoonDetailViewController alloc] init];
    cartoonVC.cartoonID = model.id;
    [self.navigationController pushViewController:cartoonVC animated:YES];

}

- (void)deleteBtnClick:(UIButton*)btn{
    ResultsModel *model = self.dataSource[btn.tag];
    [model removeCartoon];
    
    [self.dataSource removeObjectAtIndex:btn.tag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
