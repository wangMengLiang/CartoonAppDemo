//
//  PictureViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "PictureViewController.h"

#import "AFNetworking.h"
#import "ImageModel.h"
#import "MyFlowLayout.h"
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"
#import "UIImageView+WebCache.h"
@interface PictureViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) MyFlowLayout *waterFlow;

//记录瀑布流的最大高度
@property (nonatomic) CGFloat maxHeight;
//记录上一次的偏移量，来控制tabBar的隐藏
@property (nonatomic) CGPoint temp;

//记录全部按钮下的url接口
@property (nonatomic, strong) NSMutableArray *urlArr;
//记录插画按钮下的url接口
@property (nonatomic, strong) NSMutableArray *insertUrlArr;

//记录大触按钮下的url接口
@property (nonatomic, strong) NSMutableArray *bigUrlArr;
//用来记录点击的是哪个按钮
@property (nonatomic) NSInteger btnIndex;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoading];
    //关闭collectionView的回弹效果
    self.collectionView.bounces = NO;

    _dataSource = [NSMutableArray new];
    _btnIndex = 0;
    [self createUrlStrArr];
    [self startHttpRequestWithUrl:_urlArr[0]];
    [self createCollectionView];
    [self setNavigationBar];
    
}


- (void)setNavigationBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add@3x.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"file"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture"]];
    
    self.navigationItem.titleView = titleView;
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(10 * GlobalScale, 5 * GlobalScale, 100 * GlobalScale, 33 * GlobalScale);
    allBtn.layer.cornerRadius = 5 * GlobalScale;
    allBtn.clipsToBounds = YES;
    allBtn.layer.borderWidth = 1;
    allBtn.layer.borderColor = MainColor.CGColor;
    
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allBtn.tag = 1000;
    
    [allBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allBtn];
    
    UIButton *insetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    insetBtn.frame = CGRectMake(115 * GlobalScale, 5 * GlobalScale, 100 * GlobalScale, 33 * GlobalScale);
    insetBtn.layer.cornerRadius = 5 * GlobalScale;
    insetBtn.clipsToBounds = YES;
    insetBtn.layer.borderWidth = 1;
    insetBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [insetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    insetBtn.clipsToBounds = YES;
    insetBtn.tag = 2000;
    [insetBtn setTitle:@"插画" forState:UIControlStateNormal];
    [insetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insetBtn];
    
    UIButton *bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bigBtn.frame = CGRectMake(220 * GlobalScale, 5 * GlobalScale, 100 * GlobalScale, 33 * GlobalScale);
    bigBtn.layer.cornerRadius = 5 * GlobalScale;
    bigBtn.clipsToBounds = YES;
    bigBtn.layer.borderWidth = 1;
    bigBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [bigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bigBtn setTitle:@"大触" forState:UIControlStateNormal];
    bigBtn.titleLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    
    bigBtn.tag = 3000;
    [bigBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigBtn];
    
    [allBtn setTitleColor:MainColor forState:UIControlStateSelected];
    [insetBtn setTitleColor:MainColor forState:UIControlStateSelected];
    [bigBtn setTitleColor:MainColor forState:UIControlStateSelected];
    allBtn.selected = YES;
    
    bigBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    insetBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
}

- (void)leftItemClick:(UIBarButtonItem*)leftItem{
    [self showTipText:@"该功能暂未开放,敬请期待"];
}

- (void)rightItemClick:(UIBarButtonItem*)rightItem{
    [self showTipText:@"该功能暂未开放,敬请期待"];
}

- (void)btnClick:(UIButton*)btn{
    switch (btn.tag) {
        case 1000:
            _btnIndex = 0;
            [_dataSource removeAllObjects];
            [self startHttpRequestWithUrl:_urlArr[0]];
            break;
        case 2000:
            _btnIndex = 1;
            [_dataSource removeAllObjects];
            [self startHttpRequestWithUrl:_insertUrlArr[0]];
            break;
        case 3000:
            _btnIndex = 2;
            [_dataSource removeAllObjects];
            [self startHttpRequestWithUrl:_bigUrlArr[0]];
            break;
            
        default:
            break;
    }
    
    UIButton *btn1 = [self.view viewWithTag:1000];
    UIButton *btn2 = [self.view viewWithTag:2000];
    UIButton *btn3 = [self.view viewWithTag:3000];
    NSArray *btnArr = @[btn1, btn2, btn3];
    for (UIButton *button in btnArr) {
        if (btn.tag == button.tag) {
            button.selected = YES;
            button.layer.borderColor = MainColor.CGColor;
        }else{
            button.selected = NO;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        }
    }
    
    
    
}



- (void)createUrlStrArr{
    _urlArr = [NSMutableArray new];
    for (int i = 1; i < 5; i++) {
        NSString *url = [NSString stringWithFormat:@"http://api.playsm.com/index.php?lastCount=9722&page=%d&r=prettyImages%%2Flist&searchLabel=&", i];
        [_urlArr addObject:url];
    }
    
    _insertUrlArr = [NSMutableArray new];
    _bigUrlArr = [NSMutableArray new];
    
    [_insertUrlArr addObject:@"http://api.playsm.com/index.php?lastCount=9741&page=1&r=prettyImages%2Flist&searchLabel=%E6%8F%92%E7%94%BB&"];
    [_bigUrlArr addObject:@"http://api.playsm.com/index.php?lastCount=5633&page=1&r=prettyImages%2Flist&searchLabel=%E5%A4%A7%E8%A7%A6&"];
    
    
    for (int i = 2; i < 6; i++) {
        NSString *insertUrl = [NSString stringWithFormat:@"http://api.playsm.com/index.php?lastCount=9741&page=%d&r=prettyImages%%2Flist&searchLabel=%%E6%%8F%%92%%E7%%94%%BB&", i];
        [_insertUrlArr addObject:insertUrl];
        
        NSString *bigUrl = [NSString stringWithFormat:@"http://api.playsm.com/index.php?lastCount=3847&page=%d&r=prettyImages%%2Flist&searchLabel=%%E5%%A4%%A7%%E8%%A7%%A6&", i];
        [_bigUrlArr addObject:bigUrl];
    }
    
    
    
}

- (void)startHttpRequestWithUrl:(NSString*)url{
    [[WMHTTPEngine shareManager] GET:url params:nil success:^(id responseObject) {
        MyLog(@"请求美图图片数据成功");
        NSArray *results = responseObject[@"results"];
        NSArray *imageModels = [ImageModel arrayOfModelsFromDictionaries:results];
        for (ImageModel *model in imageModels) {
            [_dataSource addObject:model];
        }
        
        [_collectionView reloadData];
        
        _waterFlow.modelArr = _dataSource;
        [self hideLoading];
    } failure:^(NSError *error) {
        [self showNetError];
    }];

}


- (void)createCollectionView{
    //创建瀑布流布局
    
    _waterFlow = [[MyFlowLayout alloc] init];
    
    _waterFlow.minimumLineSpacing = 10 * GlobalScale;
    _waterFlow.minimumInteritemSpacing = 10 * GlobalScale;
    
    _waterFlow.sectionInset = UIEdgeInsetsMake(20 * GlobalScale, 10 * GlobalScale, 10 * GlobalScale, 10 * GlobalScale);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 * GlobalScale, WIDTH, HEIGHT) collectionViewLayout:_waterFlow];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
    
    
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ImageModel *model = _dataSource[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
    
    cell.imageView.userInteractionEnabled = YES;
    cell.imageView.tag = indexPath.item;
    [self addTapToView:cell.imageView];
    
    //  在这里可以得到collectionView的最大高度,用于更新下一页图片
    
    if (_collectionView.contentSize.height > _maxHeight) {
        _maxHeight = _collectionView.contentSize.height;
    }
    
    return cell;
}




- (void)addTapToView:(UIImageView*)imageView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer*)tg{
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    imageVC.modelArr = _dataSource;
    imageVC.index = tg.view.tag;
    
    [self.navigationController pushViewController:imageVC animated:YES];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = _collectionView.contentOffset;
    static int index = 0;
    if (_maxHeight <= 20) {
        return;
    }
    if (offset.y > _maxHeight - HEIGHT - 100) {
        index++;
        if (index >= 4) {
            return;
        }
        //        判断是哪个按钮点击的，根据按钮来连接不同的接口
        if (_btnIndex == 0) {
            [self startHttpRequestWithUrl:_urlArr[index]];
        }else if (_btnIndex == 1){
            [self startHttpRequestWithUrl:_insertUrlArr[index]];
        }else{
            [self startHttpRequestWithUrl:_bigUrlArr[index]];
        }
        
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
