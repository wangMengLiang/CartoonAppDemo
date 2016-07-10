//
//  CartoonDetailViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CartoonDetailViewController.h"
#import "CartoonPictureViewController.h"
#import "ResultsModel.h"
#import "CartoonchapterlistModel.h"
#import "CommentTableViewCell.h"
#import "CommentlistModel.h"
#import "TalkBar.h"
#import "ResultsModel+DataBase.h"
#define CommentCell @"CommentTableViewCell"

@interface CartoonDetailViewController ()<UITableViewDataSource,UITableViewDelegate,  UIScrollViewDelegate, UITextFieldDelegate, UITabBarDelegate>
//标题名字的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelHC;
//下部view距离屏幕顶部的距离的约束，默认200
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewTopC;

//漫画图像的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cartoonImageHC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cartoonImageTopC;

//距离顶部的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLableTopC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorLabelTopC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updateLabelTopC;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updateTimeTopC;


@property (nonatomic, strong) UIButton *firstChapterBtn;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) ResultsModel *dataModel;

@property (nonatomic, strong) NSMutableArray *commentData;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet UIImageView *cartoonImageView;

@property (weak, nonatomic) IBOutlet UIButton *addCollectBtn;

@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;


@property (nonatomic, strong) UIView *talkView;
@property (nonatomic) CGFloat  keyHeight;

@property (nonatomic, strong) UITextField *msgTF;

@end

@implementation CartoonDetailViewController

-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
    //此处设置透明色没有效果
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Bar_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.tintColor = MainColor;
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    MyLog(@"%f", self.navigationController.navigationBar.frame.origin.y);
    //将tabBar隐藏
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = 800;
    self.tabBarController.tabBar.frame = frame;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = HEIGHT - 49;
    self.tabBarController.tabBar.frame = frame;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataModel];
    
    [self setHeadBtn];
}

- (void)setHeadBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake( 10, 25, 30 * GlobalScale, 30 * GlobalScale);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(WIDTH - 45, 25, 30 * GlobalScale, 30 * GlobalScale);
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadItem"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn];
}


- (void)backBtnClick:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)downloadBtnClick:(UIButton*)btn{
    [self showTipText:@"该功能暂未开放,敬请期待!"];
}



-(ResultsModel *)dataModel{
    if (_dataModel == nil) {
        NSString *urlStr = [NSString stringWithFormat:APPCartoonDetailAPI, self.cartoonID];
        
        //没有网络从本地读取数据
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) { //判断是否能联网
            [self showTipText:@"网络连接断开，请检查网络"];
            [self hideLoading];
            
            //需要去数据库 或者其他保存数据的地点，查数据，如果有就显示出来
            _dataModel = [WMCacheManager readDataWithUrl:urlStr];
            _commentData = [CommentlistModel arrayOfModelsFromDictionaries:_dataModel.commentList];
            return _dataModel;
        }
        
        
        
        [[WMHTTPEngine shareManager] GET:urlStr params:nil success:^(id responseObject) {
            NSDictionary *dic = responseObject[@"results"];
            _dataModel = [[ResultsModel alloc] initWithDictionary:dic error:nil];
            _commentData = [CommentlistModel arrayOfModelsFromDictionaries:_dataModel.commentList];
            
            //有网络时保存数据
            [WMCacheManager saveData:_dataModel url:urlStr];
            
            [self setPage];
            [self.commentTableView reloadData];
            [self hideLoading];
        } failure:^(NSError *error) {
            [self showNetError];
        }];
    }
    return _dataModel;
}

- (void)setPage{
    [_backgroundImage sd_setImageWithURL:[NSURL URLWithString:self.dataModel.images] placeholderImage:nil];

    _cartoonImageView.layer.cornerRadius = 5 * GlobalScale;
    _cartoonImageView.clipsToBounds = YES;
    _cartoonImageView.layer.borderWidth = 5 * GlobalScale;
    _cartoonImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [_cartoonImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.images] placeholderImage:nil];
    _addCollectBtn.layer.cornerRadius = 5 * GlobalScale;
    _readBtn.layer.cornerRadius = 5 * GlobalScale;
    _addCollectBtn.clipsToBounds = YES;
    _readBtn.clipsToBounds = YES;
    _addCollectBtn.layer.borderWidth = 1;
    _addCollectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _contentLabel.text = [NSString stringWithFormat:@"       %@", self.dataModel.introduction];
    _nameLabel.text = self.dataModel.name;

    _authorLabel.text = [NSString stringWithFormat:@"作者:%@", self.dataModel.author];
    _updateLabel.text = self.dataModel.updateValueLabel;
    _updateTime.text = [NSString stringWithFormat:@"最近更新时间:%@", self.dataModel.recentUpdateTime];
    
    _contentLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    _nameLabel.font = [UIFont systemFontOfSize:17 * GlobalScale];
    _authorLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    _updateLabel.font = [UIFont systemFontOfSize:13 * GlobalScale];
    _updateTime.font = [UIFont systemFontOfSize:13 * GlobalScale];

    //初始选中值
    _segmentControl.selectedSegmentIndex = 0;
    
    
    //清空系统自带的颜色
    _segmentControl.tintColor = [UIColor clearColor];
    //设置normal的属性
    NSDictionary *dicNormal = @{NSFontAttributeName:[UIFont systemFontOfSize:16 * GlobalScale], NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [_segmentControl setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    //设置选中状态的属性
    NSDictionary *dicSelect = @{NSFontAttributeName:[UIFont systemFontOfSize:16 * GlobalScale], NSForegroundColorAttributeName:MainColor};
    [_segmentControl setTitleTextAttributes:dicSelect  forState:UIControlStateSelected];
    //监听点击
    
    [_segmentControl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    
    _addCollectBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    _readBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
    [self configScrollView];
    [self setViewConstraint];

    
}

- (void)setViewConstraint{
    _cartoonImageHC.constant = 180 * GlobalScale;
    _cartoonImageTopC.constant = -128 * GlobalScale;
    //  宽度约束
    _nameLabelHC.constant = 270 * GlobalScale;
    
    _mainViewTopC.constant = 200 * GlobalScale;
    
    //修改几个label距离顶部的约束
    _nameLableTopC.constant = 65 * GlobalScale;
    _authorLabelTopC.constant = 12 * GlobalScale;
    MyLog(@"%f", GlobalScale);
    if (GlobalScale < 0.906 || GlobalHeightScale != 1) {
        _updateLabelTopC.constant = 39 * GlobalScale * 0.8;
        
    }else{
        _updateLabelTopC.constant = 39 * GlobalScale;
    }
    
    _updateTimeTopC.constant = 6 * GlobalScale;
    
}


- (void)segmentChange:(UISegmentedControl*)sg{
    CGPoint offset = self.scrollView.contentOffset;
    if (sg.selectedSegmentIndex == 0) {
        offset.x = 0;
    }else{
        offset.x = WIDTH;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = offset;
    }];
    
}


- (void)configScrollView{
    CGRect frame = _scrollView.frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width * 2, frame.size.height - 98 * GlobalScale);
    _scrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    _scrollView.delegate = self;

    
    //目录界面
    UIScrollView *subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    [_scrollView addSubview:subScrollView];
    
    //漫画总共有多少章
    NSInteger btnNum = [self.dataModel.cartoonChapterCount integerValue];
    //取出chapterID
    NSArray *chapterArr = self.dataModel.cartoonChapterList;
//    重点 解决为啥从model里面取不到值的问题
    NSArray *chapteModelArr = [CartoonchapterlistModel arrayOfModelsFromDictionaries:chapterArr];
    
    CGFloat bWidth = (frame.size.width - 20 * GlobalScale * 5) / 4;
    CGFloat bHeight = 30 * GlobalScale;
    static int tag = 0;
    for (int i = 0; i < chapteModelArr.count / 4 + 1; i++) {
        for (int j = 0; j < 4; j++) {
            tag++;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20 * GlobalScale + (bWidth + 20 * GlobalScale) * j, 30 * GlobalScale + (bHeight + 10 * GlobalScale) * i, bWidth, bHeight);
            CartoonchapterlistModel *model;
            if (tag <= chapteModelArr.count) {
                model = chapteModelArr[tag - 1];
            }

            btn.tag = [model.id integerValue];

            if (tag == 1) {
                self.firstChapterBtn = btn;
            }
            [btn setTitle:[NSString stringWithFormat:@"%d话", tag] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
            btn.layer.cornerRadius = 5 * GlobalScale;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [subScrollView addSubview:btn];
            
            if (tag == btnNum) {
                subScrollView.contentSize = CGSizeMake(frame.size.width, CGRectGetMaxY(btn.frame) + 49 * GlobalScale);
            if (tag == chapteModelArr.count) {
                    break;
            }
            }
        }
    }
    tag = 0;
    
    //评论界面
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height - 49 * GlobalScale) style:UITableViewStylePlain];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.userInteractionEnabled = YES;
    _commentTableView.estimatedRowHeight = 50;
    [_commentTableView registerNib:[UINib nibWithNibName:CommentCell bundle:nil] forCellReuseIdentifier:CommentCell];
    [_scrollView addSubview:_commentTableView];

    UILabel *headLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, WIDTH, 20)];
    headLabel1.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    headLabel1.text = @"  连载(话)";
    headLabel1.font = [UIFont boldSystemFontOfSize:15 * GlobalScale];
    headLabel1.textColor = [UIColor grayColor];
    [subScrollView addSubview:headLabel1];
    
}


- (void)btnClick:(UIButton*)btn{
    CartoonPictureViewController *picVC = [[CartoonPictureViewController alloc] init];
    picVC.urlStr = [NSString stringWithFormat:APPCartoonPictureAPI, btn.tag];
    [self.navigationController pushViewController:picVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//收藏按钮的点击事件
- (IBAction)addCollectionBtnClick:(id)sender {
    if ([self.dataModel selectCartoonIsExist]) {
        [self showTipText:@"该漫画已被收藏"];
        MyLog(@"该漫画已被收藏");
        return;
    }
    
    if ([self.dataModel saveCartoon]) {
        [self showTipText:@"收藏成功"];
        MyLog(@"收藏成功");
    }else{
        [self showErrorText:@"收藏失败"];
        MyLog(@"收藏失败");
    }
}

- (IBAction)readBtnClick:(id)sender {
    
    [self btnClick:self.firstChapterBtn];
}


#pragma mark - TableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.commentData.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCell forIndexPath:indexPath];
    CommentlistModel *model = self.commentData[indexPath.row];
    
    [cell configViewWithData:model];
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    headLabel2.text = [NSString stringWithFormat:@"  最新评论(%ld)", (unsigned long)self.commentData.count];
    headLabel2.font = [UIFont boldSystemFontOfSize:15 * GlobalScale];
    [self.commentTableView addSubview:headLabel2];
    headLabel2.backgroundColor = [UIColor whiteColor];
    return headLabel2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0 * GlobalScale;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x > WIDTH * 2 / 3) {
        self.segmentControl.selectedSegmentIndex = 1;
    }else{
        self.segmentControl.selectedSegmentIndex = 0;
    }


}

@end
