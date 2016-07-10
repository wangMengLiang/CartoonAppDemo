//
//  SearchViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "SearchViewController.h"
#import "RecommendMoreController.h"
#import "MoreCartoonCollectionViewCell.h"
#import "CartoonDetailViewController.h"
#import "ResultsModel.h"

NSString *MoreCartoonCell = @"MoreCartoonCollectionViewCell";


@interface SearchViewController ()<UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (weak, nonatomic) IBOutlet UIView *btnView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray * cartoonIDArr;

@property (nonatomic, strong) NSMutableArray *collectionData;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPageView];
    [self configCollectionView];
    _searchBar.delegate = self;
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self showTipText:@"该功能暂未开放,敬请期待!"];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)configCollectionView{
    [self collectionData];
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
    
    _collectionView.collectionViewLayout = layout;
    
    //设置数据源代理
    _collectionView.dataSource = self;
    //设置代理
    _collectionView.delegate = self;

    [_collectionView registerNib:[UINib nibWithNibName:MoreCartoonCell bundle:nil] forCellWithReuseIdentifier:MoreCartoonCell];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.collectionData.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreCartoonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MoreCartoonCell forIndexPath:indexPath];
    MoreCartoonModel *model = self.collectionData[indexPath.item];
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    cell.nameLabel.text = model.name;
    [cell.updataLabel removeFromSuperview];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CartoonDetailViewController *detailVC = [[CartoonDetailViewController alloc] init];
    detailVC.cartoonID = _cartoonIDArr[indexPath.item];
    MoreCartoonModel *model = self.collectionData[indexPath.item];
    detailVC.images = model.images;
    
    [self.navigationController pushViewController:detailVC animated:YES];

}


- (void)initPageView{

    NSArray *btnNameArr = @[@"凤囚凰", @"灼灼琉璃夏", @"23:59", @"破晓世纪", @"妖玉奇谭", @"萌尽的萌娘"];
    NSArray *btnTagArr = @[@"108", @"259", @"256", @"255", @"242", @"109"];
    
    _btnView.userInteractionEnabled = YES;
    CGFloat bWidth = (WIDTH - 10 * 4) / 3;
    CGFloat bHeight = 30 * GlobalScale;
    static int tag = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            tag++;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10 + (bWidth + 10) * j, 50 + (bHeight + 10) * i, bWidth, bHeight);
            btn.tag = [btnTagArr[tag - 1] integerValue];
            [btn setTitle:btnNameArr[tag-1] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:MainColor forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = MainColor.CGColor;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_btnView addSubview:btn];
            
        }
    }

    _collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)btnClick:(UIButton*)btn{
    CartoonDetailViewController *detailVC = [[CartoonDetailViewController alloc] init];
    detailVC.cartoonID = [NSString stringWithFormat:@"%ld", btn.tag];

    [self.navigationController pushViewController:detailVC animated:YES];

}

#pragma mark - 创建collectionview

-(NSMutableArray *)collectionData{
    if (_collectionData == nil) {
        _collectionData = [NSMutableArray new];
        _cartoonIDArr = @[@"108", @"109", @"117", @"125", @"140", @"253"];
        
        for (int i = 0; i < _cartoonIDArr.count; i++) {
            NSString *url = [NSString stringWithFormat:APPCartoonDetailAPI, _cartoonIDArr[i]];
            
            //没有网络从本地读取数据
            if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
                [self showTipText:@"网络连接断开，请检查网络"];
                [self hideLoading];
                
                //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
                NSArray *resArray = [WMCacheManager readDataWithUrl:url];
                [_collectionData addObjectsFromArray:resArray];
                [self.collectionView reloadData];
                
                return _collectionData;
            }
            
            [[WMHTTPEngine shareManager] GET:url params:nil success:^(id responseObject) {
                
                NSDictionary *dic = responseObject[@"results"];
                ResultsModel *model = [[ResultsModel alloc] initWithDictionary:dic error:nil];
                if (model) {
                    [_collectionData addObject:model];
                }
                
                //保存数据
                [WMCacheManager saveData:_collectionData url:url];
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                
                [self showNetError];
            }];
        }
        [self hideLoading];
    }
    return _collectionData;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}





@end
