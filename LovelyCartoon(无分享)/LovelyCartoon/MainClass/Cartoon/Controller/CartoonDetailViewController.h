//
//  CartoonDetailViewController.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMBaseViewController.h"
#import "MoreCartoonModel.h"
#import "CartoonScrollViewModel.h"
@interface CartoonDetailViewController : WMBaseViewController

@property (nonatomic, strong) CartoonScrollViewModel *scrollViewModel;

@property (nonatomic, copy) NSString *cartoonID;

@property (nonatomic, copy) NSString *images;

@end
