//
//  MyFlowLayout.m
//  ZZ15221010WangMengLiang
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MyFlowLayout.h"

@interface MyFlowLayout (){
    //存放元素的布局属性信息
    NSMutableArray *_attributes;
    
    //存放每列的高度
    CGFloat columnHeight[2];
}

@end


@implementation MyFlowLayout
- (void)prepareLayout{
    _imageList = [NSMutableArray array];
    _attributes = [NSMutableArray array];
    
    //两列的初始高度，需要考虑边距
    columnHeight[0] = self.sectionInset.top;
    columnHeight[1] = self.sectionInset.top;

    //获取item个数,只有一组，所以section = 0
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //计算item的宽度，这里只有两列，两列宽度相同。计算时需要考虑左右边距和item之间的距离
    CGFloat itemWidth = (WIDTH - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / 2;
    for (int i = 0; i < itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        ImageModel *model = _modelArr[i];
        
        CGFloat iWidth = [model.width floatValue];
        CGFloat height = [model.height floatValue] * itemWidth / iWidth;
        
        //哪一列修改了高度
        int column = 0;
        //找高度最短列,修改columnHeight数组中对应列的总高度
        if (columnHeight[0] <= columnHeight[1]){
            columnHeight[0] += height + self.minimumLineSpacing;
            column = 0;
        }else{
            columnHeight[1] += height + self.minimumLineSpacing;
            column = 1;
        }
        
        //计算item的横纵坐标
        int posX = self.sectionInset.left + (itemWidth + self.minimumInteritemSpacing) * column;
        int posY = columnHeight[column] - height - self.minimumLineSpacing;
        
        //设置布局属性的frame
        attribute.frame = CGRectMake(posX, posY, itemWidth, height);
        
        //添加到布局属性数组中
        [_attributes addObject:attribute];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"send" object:self userInfo:@{@"imageList":_imageList}];
}

//重写该方法，返回指定区域中item的布局属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    //遍历布局属性数组
    for (UICollectionViewLayoutAttributes *attribute in _attributes) {
        
        CGRect frame = attribute.frame;
        //判断某个矩形区域是否在另一个矩形区域里面
        if (CGRectIntersectsRect(frame, rect)) {
            [resultArr addObject:attribute];
        }
    }
    return resultArr;
}

//重写该方法，返回可滚动区域的大小
- (CGSize)collectionViewContentSize{
    //根据最高列进行计算
    CGFloat maxHeight = 0;
    if (columnHeight[0] >= columnHeight[1] ) {
        maxHeight = columnHeight[0];
    }else {
        maxHeight = columnHeight[1];
    }
    return CGSizeMake(WIDTH, maxHeight - self.minimumLineSpacing + self.sectionInset.bottom);
}


@end
