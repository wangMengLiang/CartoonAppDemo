//
//  RecommendViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "RecommendViewController.h"
#import "CartoonDetailViewController.h"
#import "LovelyInfoDetailViewController.h"
#import "CellItemModel.h"
#import "CartoonScrollViewModel.h"
#import "CartooninfoModel.h"
#import "RecommendTableViewCell.h"
static NSString *recommendCell = @"RecommendTableViewCell";

@interface RecommendViewController ()
//存放滚动视图的数据源
@property (nonatomic, strong) NSMutableArray *scrollViewData;

//存放分类数据的数据源
@property (nonatomic, strong) NSMutableArray *myData;


//记录继续撸的cell
@property (nonatomic, strong) RecommendTableViewCell *continueLookCell;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    //解决第二个界面pageControl.frame改变的问题
    self.pageControl.frame = CGRectMake(WIDTH - 160 * GlobalScale, self.scrollView.frame.size.height - 20, 150, 20);
    
    [super viewDidLoad];
    _myData = [NSMutableArray new];
    [self starHttpRequest];
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 44 - 49 - 10);
    self.tableView.estimatedRowHeight = 200;
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:recommendCell bundle:nil] forCellReuseIdentifier:recommendCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources
}


#pragma mark - 重写父类方法
- (void)starHttpRequest{
    //没有网络从本地读取数据
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
        [self showTipText:@"网络连接断开，请检查网络"];
        [self hideLoading];
        
        //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
        _myData = [WMCacheManager readDataWithUrl:APPCartoonRecommendAPI];
        [self.tableView reloadData];
        return ;
    }
    
    
    [[WMHTTPEngine shareManager] GET:APPCartoonRecommendAPI params:nil success:^(id responseObject) {
        NSArray *results = responseObject[@"results"];
        for (int i = 0; i < results.count; i++) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:results[i] options:NSJSONWritingPrettyPrinted error:nil];
            CellItemModel *model = [[CellItemModel alloc] initWithData:data error:nil];
            if (i != 0) {
                
                [_myData addObject:model];
            }
        }
        
        [WMCacheManager saveData:_myData url:APPCartoonRecommendAPI];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self showNetError];
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
}

-(NSString *)myScrollViewAPI{

    return APPCartoonRollViewAPI;
}

- (NSMutableArray *)scrollViewData{
    if (_scrollViewData == nil) {
        _scrollViewData = [NSMutableArray new];
    }
    return _scrollViewData;
}


- (void)loadScrollViewData{
    
    [[WMHTTPEngine shareManager] GET:[self myScrollViewAPI] params:nil success:^(id responseObject) {
        NSArray *results = responseObject[@"results"];
        
        self.scrollViewData = [CartoonScrollViewModel arrayOfModelsFromDictionaries:results];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.scrollViewData.count, 200 * GlobalScale * GlobalHeightScale);
    
        int i = 0;
        for (CartoonScrollViewModel *model in self.scrollViewData) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, 200 * GlobalScale*GlobalHeightScale)];
            imageView.tag = i;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
            
            [self.scrollView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 180 * GlobalScale * GlobalHeightScale, 250 * GlobalScale, 20 * GlobalHeightScale)];

            
            label.text = model.title;
            label.font = [UIFont systemFontOfSize:15 * GlobalScale];
            label.textColor = [UIColor whiteColor];
            [imageView addSubview:label];
        
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            i++;
        }
        self.pageControl.numberOfPages = 5;
        [self hideLoading];
    } failure:^(NSError *error) {
        [self showNetError];
    }];
}

- (void)pageChanged:(UIPageControl*)pc{
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = pc.currentPage * self.view.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}


- (void)onTimer:(NSTimer*)timer{
    static int pageNum = 0;
    pageNum == 5? pageNum = 0: pageNum;
    self.pageControl.currentPage = pageNum;
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = pageNum * self.view.frame.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = offset;
    }];
    
    pageNum++;
    
}

///////////////////////////////////////////////////



- (void)tapAction:(UITapGestureRecognizer*)tg{
    CartoonScrollViewModel *model = self.scrollViewData[tg.view.tag];
    
    if (tg.view.tag == self.scrollViewData.count - 1) {
        LovelyInfoDetailViewController *detailVC = [[LovelyInfoDetailViewController alloc] init];
        NSString *url = [NSString stringWithFormat:APPRollViewDetailAPI, model.messageID];
        detailVC.urlStr= url;
//        detailVC
        [self.navigationController pushViewController:detailVC animated:YES];
        return;
    }
    
    CartoonDetailViewController *detailVC = [[CartoonDetailViewController alloc] init];
    detailVC.cartoonID = model.cartooninfo.id;
    detailVC.images = model.cartooninfo.images;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark - tableview数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myData.count + 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.firstCell;
    }
    
    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCell forIndexPath:indexPath];
    
    CellItemModel *model = _myData[indexPath.row - 1];;

    cell.controller = self;
    
    [cell configViewWithDate:model];
    cell.userInteractionEnabled = YES;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200 * GlobalScale * GlobalHeightScale;
    }
    
    return 230 * GlobalScale;
}






@end
