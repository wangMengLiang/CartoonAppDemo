//
//  CategoryViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCollectionViewCell.h"
#import "RecommendMoreController.h"

#define CategoryCell @"CategoryCollectionViewCell"

@interface CategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *urlArr;

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) NSArray *categoryNameArr;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configCollectionView];
    [self hideLoading];
}


- (void)configCollectionView{

    //线性布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //水平方向，元素之间的最小距离
    layout.minimumInteritemSpacing = 10 * GlobalScale;
    //行之间的最小距离
    layout.minimumLineSpacing = 20 * GlobalScale;
    
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    
    //设置元素的大小
    layout.itemSize = CGSizeMake(110*GlobalScale, 130*GlobalScale);
    
    //设置边距
    
    layout.sectionInset = UIEdgeInsetsMake(10, 20*GlobalScale, 0, 20*GlobalScale);
    _collectionView.collectionViewLayout = layout;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:CategoryCell bundle:nil] forCellWithReuseIdentifier:CategoryCell];



}


//此处代码可重钩为一个Model
-(NSMutableArray *)imageArr{
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray new];
        for (int i = 1; i <= 13; i++) {
            NSString *str = [NSString stringWithFormat:@"view%d", i];
            [_imageArr addObject:str];
        }
        
    }
    return _imageArr;
}

- (NSArray *)categoryNameArr{
    if (_categoryNameArr == nil) {
        _categoryNameArr = @[@"最新上架", @"最新更新", @"完结漫画", @"校园", @"日常", @"少女·爱情", @"少年·热血", @"耽美", @"幽默·搞笑", @"侦探·推理", @"冒险·动作", @"科幻·奇幻", @"恐怖·悬疑"];
    }
    
    return _categoryNameArr;
}

- (NSMutableArray *)urlArr{
    if (_urlArr == nil) {
        _urlArr = [NSMutableArray new];
        NSArray *arr = @[@"21", @"20", @"19", @"8", @"16", @"2", @"1", @"14", @"5", @"7", @"23", @"4", @"22"];

        for (int i = 0; i < arr.count; i++) {
            NSString *urlStr = [NSString stringWithFormat:@"http://api.playsm.com/index.php?size=12&r=cartoonCategory%%2FgetCartoonSetListByCategory&page=1&id=%@&", arr[i]];
            [_urlArr addObject:urlStr];
        }
    }

    return _urlArr;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCell forIndexPath:indexPath];

    cell.cellImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.categoryName.text = self.categoryNameArr[indexPath.row];
    cell.categoryName.font = [UIFont systemFontOfSize:15 * GlobalScale];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendMoreController *moreVC = [[RecommendMoreController alloc] init];
    moreVC.url = self.urlArr[indexPath.item];
    MyLog(@"%@", moreVC.url);
    moreVC.title = self.categoryNameArr[indexPath.item];
    [self.navigationController pushViewController:moreVC animated:YES];



}



@end
