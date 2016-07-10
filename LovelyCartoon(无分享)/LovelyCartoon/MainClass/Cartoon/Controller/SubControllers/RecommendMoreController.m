//
//  RecommendMoreController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "RecommendMoreController.h"
#import "MoreCartoonModel.h"
#import "MoreCartoonCollectionViewCell.h"
#import "CartoonDetailViewController.h"

#define MoreCartoonCell @"MoreCartoonCollectionViewCell"

@interface RecommendMoreController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RecommendMoreController

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }

    return _dataSource;
}

- (void)loadDataSource{
    NSString *urlStr;
    if (self.valueID != nil && ![self.title isEqualToString:@"小编推荐"]) {
        urlStr = [NSString stringWithFormat:APPCartoonMoreAPI, self.valueID];
    }else if([self.title isEqualToString:@"小编推荐"]){
        urlStr = [NSString stringWithFormat:APPCartoonBillBoardAPI, self.valueID];
    }else{
        urlStr = self.url;
    }
    
    //没有网络从本地读取数据
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
        [self showTipText:@"网络连接断开，请检查网络"];
        [self hideLoading];
        
        //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
        self.dataSource = [WMCacheManager readDataWithUrl:urlStr];
        [self.collectionView reloadData];
        return ;
    }
    MyLog(@"%@", urlStr);
    [[WMHTTPEngine shareManager] GET:urlStr params:nil success:^(id responseObject) {
        NSArray *resultArr = responseObject[@"results"];
        self.dataSource = [MoreCartoonModel arrayOfModelsFromDictionaries:resultArr];
        
        [WMCacheManager saveData:self.dataSource url:urlStr];
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        [self showNetError];
    }];
}


-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 10 * GlobalScale;     //水平方向，元素之间的最小距离
        
        layout.minimumLineSpacing = 20 * GlobalScale;   //行之间的最小距离
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;   //滚动方向
        
        //设置元素的大小
        CGFloat itemWidth = (WIDTH - 45 * GlobalScale) / 3;
        CGFloat itemHeight = itemWidth * 3 / 2;
        
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
        //设置边距
        layout.sectionInset = UIEdgeInsetsMake(10, 10 * GlobalScale, 10, 10 * GlobalScale);
        
      //第二个参数：表示使用的布局
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49 - 44 - 20) collectionViewLayout:layout];
        
        //设置数据源代理
        _collectionView.dataSource = self;
        //设置代理
        _collectionView.delegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:MoreCartoonCell bundle:nil] forCellWithReuseIdentifier:MoreCartoonCell];

        [self.view addSubview:_collectionView];

    }

    return _collectionView;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreCartoonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MoreCartoonCell forIndexPath:indexPath];
    MoreCartoonModel *model = self.dataSource[indexPath.row];
    
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    cell.updataLabel.text = model.updateInfo;
    cell.nameLabel.text = model.name;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCartoonModel *model = self.dataSource[indexPath.item];
    
    CartoonDetailViewController *cartoonVC = [[CartoonDetailViewController alloc] init];
    cartoonVC.cartoonID = model.id;
    cartoonVC.images = model.images;
    
    [self.navigationController pushViewController:cartoonVC animated:YES];
    
}








@end
