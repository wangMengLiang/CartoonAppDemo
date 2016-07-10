//
//  LovelyInfoViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "LovelyInfoViewController.h"
#import "ScrollImageModel.h"
#import "WMHTTPEngine.h"
#import "ItemModel.h"
#import "MyTableViewCell.h"
#import "LovelyInfoDetailViewController.h"
#import "MJRefresh.h"
#import "WMCacheManager.h"
static NSString *lovelyInfoCell = @"MyTableViewCell";

@interface LovelyInfoViewController ()

@property (nonatomic, strong) NSArray *urlArr;

@property (nonatomic, strong) NSMutableArray *scrollItems;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) CGPoint temp;



@end

@implementation LovelyInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showLoading];
    [self setNavigationBarItem];
    [self loadScrollViewData];
    [self pageControl];
    
    MyLog(@"%f", GlobalScale);
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height - 60 * GlobalScale);
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:lovelyInfoCell bundle:nil] forCellReuseIdentifier:lovelyInfoCell];
    
    [self creatFirstPageUrl];
    
    
    [self loadDataSourceWithUrl:_urlArr[0]];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"header"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infomation2@3x"]];
    
    self.navigationItem.titleView = titleView;
    
}

- (void)leftItemClick:(UIBarButtonItem*)leftItem{
    [self showTipText:@"该功能暂未开放,敬请期待"];
    
}

- (void)rightItemClick:(UIBarButtonItem*)rightItem{
    [self showTipText:@"该功能暂未开放,敬请期待"];
}

#pragma mark - 创建滚动视图
- (NSString*)myScrollViewAPI{

    return APPRollViewAPI;
}

- (void)loadScrollViewData{
    NSString *urlStr = [self myScrollViewAPI];
    
    //没有网络从本地读取数据
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
        [self showTipText:@"网络连接断开，请检查网络"];
        [self hideLoading];
        
        //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
        NSArray *resArray = [WMCacheManager readDataWithUrl:urlStr];
        [_scrollItems  addObjectsFromArray:resArray];

        return;
    }
    
    
    
    [[WMHTTPEngine shareManager] GET:urlStr params:nil success:^(id responseObject) {
        NSArray *results = responseObject[@"results"];
        _scrollItems = [ScrollImageModel arrayOfModelsFromDictionaries:results];
        
        //有网络时保存数据
        [WMCacheManager saveData:_scrollItems url:urlStr];
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * _scrollItems.count, 200 * GlobalScale * GlobalHeightScale);
        int i = 0;
        for (ScrollImageModel *model in _scrollItems) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, 200 * GlobalScale * GlobalHeightScale)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
            imageView.tag = i;
            [_scrollView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 180 * GlobalScale * GlobalHeightScale, 250, 18 * GlobalHeightScale)];
            label.text = model.title;
            label.font = [UIFont systemFontOfSize:15 * GlobalScale];
            label.textColor = [UIColor whiteColor];
            [imageView addSubview:label];
          //  [self pageControl];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            i++;
        }
        
        [self hideLoading];
        
    } failure:^(NSError *error) {
        [self showNetError];
    }];
}


- (void)tapAction:(UITapGestureRecognizer*)tg{
    LovelyInfoDetailViewController *detailVC = [[LovelyInfoDetailViewController alloc] init];
    ScrollImageModel *model = self.scrollItems[tg.view.tag];
    
    NSString *url = [NSString stringWithFormat:APPRollViewDetailAPI, model.messageID];
    
    detailVC.urlStr= url;
    [self.navigationController pushViewController:detailVC animated:YES];
}


//scrollView的懒加载
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        
        if ([self isKindOfClass:[LovelyInfoViewController class]]) {
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200 * GlobalScale * GlobalHeightScale)];
        }
        
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        
    }
    return _scrollView;
}

#pragma mark - 创建pageControl

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        if (GlobalHeightScale != 1) {
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(190, 180 * GlobalScale * GlobalHeightScale, 0, 20 * GlobalHeightScale)];
        }else{
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 180 * GlobalScale * GlobalHeightScale, 0, 20 * GlobalHeightScale)];
        }
        
        
        _pageControl.numberOfPages = 5;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    return _pageControl;

}



- (void)pageChanged:(UIPageControl*)pc{
    CGPoint offset = _scrollView.contentOffset;
    offset.x = pc.currentPage * self.view.frame.size.width;
    [_scrollView setContentOffset:offset animated:YES];
}


- (void)onTimer:(NSTimer*)timer{
     static int pageNum = 0;
     pageNum == 5? pageNum = 0: pageNum;
     _pageControl.currentPage = pageNum;
     
     CGPoint offset = _scrollView.contentOffset;
     offset.x = pageNum * self.view.frame.size.width;
     [UIView animateWithDuration:0.3 animations:^{
         _scrollView.contentOffset = offset;
     }];
     
     pageNum++;
     
}
     
     
#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_scrollView == scrollView) {
        int page = scrollView.contentOffset.x / self.view.frame.size.width;
        _pageControl.currentPage = page;
    }
}


- (void)creatFirstPageUrl{

    _urlArr = @[APPInformationAPI1, APPInformationAPI2, APPInformationAPI3, APPInformationAPI4];
    
}


- (void)loadDataSourceWithUrl:(NSString*)url{
    
    //没有网络从本地读取数据
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
        [self showTipText:@"网络连接断开，请检查网络"];
        [self hideLoading];
        
        //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
        NSArray *resArray = [WMCacheManager readDataWithUrl:url];
        [self.dataSource addObjectsFromArray:resArray];
        [self.tableView reloadData];
        
        return;
    }

    
    //    http://api.playsm.com/index.php?page=1&r=message%2Flist&size=10&
    
    [[WMHTTPEngine shareManager] GET:url params:nil success:^(id responseObject) {
        NSArray *resultArr = responseObject[@"results"];
        NSArray *itemModels = [ItemModel arrayOfModelsFromDictionaries:resultArr];
        
        for (ItemModel *model in itemModels) {
            [self.dataSource addObject:model];
        }
        //有网络时保存数据
        [WMCacheManager saveData:self.dataSource url:url];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self showNetError];
    }];
}


#pragma mark - tableview数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
}


-(UITableViewCell *)firstCell{
    if (_firstCell == nil) {
        _firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [_firstCell addSubview:self.scrollView];
        [_firstCell addSubview:self.pageControl];
    }
    
    return _firstCell;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {

        return self.firstCell;
    }

    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lovelyInfoCell forIndexPath:indexPath];
    ItemModel *model = self.dataSource[indexPath.row - 1];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    
    cell.name.text = model.title;
    cell.nameLabel.text = model.userName;
    cell.timeLabel.text = model.createTimeValue;
    cell.name.font = [UIFont systemFontOfSize:18 * GlobalScale];
    cell.nameLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    cell.timeLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    cell.iconViewWidthConstraints.constant = 123 * GlobalScale;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200 * GlobalScale * GlobalHeightScale;
    }

    return 100 * GlobalScale;
}



#pragma mark - tableView代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemModel *model = self.dataSource[indexPath.row - 1];
    LovelyInfoDetailViewController *detailVC = [[LovelyInfoDetailViewController alloc] init];
    
    NSString *url = [NSString stringWithFormat:APPInfoDetailAPI, model.id];
    
    detailVC.urlStr = url;

    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

#pragma mark - scrollView代理
//每页显示10行数据，当下拉至末行的时候进行刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.tableView.contentOffset;
    static int index = 0;
    if (offset.y > 100 * self.dataSource.count - self.view.frame.size.height - 200) {
        index++;
        if (index >= 4) {
            return;
        }
        [self loadDataSourceWithUrl:_urlArr[index]];
    }
    
    if (offset.y == 0) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    if (_temp.y - offset.y == 0) {
        return;
    }
    
    if (_temp.y - offset.y < 0) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
    
    _temp = offset;
}




@end
