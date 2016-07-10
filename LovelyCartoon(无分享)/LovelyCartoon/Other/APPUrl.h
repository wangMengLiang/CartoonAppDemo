//
//  APPUrl.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#ifndef APPUrl_h
#define APPUrl_h
//滚动视图接口
#define APPRollViewAPI @"http://api.playsm.com/index.php?page=1&r=adImage%2Flist&customPosition=1&size=999&"
//滚动视图详情接口
#define APPRollViewDetailAPI @"http://api.playsm.com/index.php?withContent=1&r=message%%2Fdetail&withPraise=1&id=%@&pushtype=2&"

//tableview接口
#define APPInformationAPI @"http://api.playsm.com/index.php?page=%ld&r=message%2Flist&size=10&"
//详情页接口
#define APPInfoDetailAPI @"http://api.playsm.com/index.php?withPraise=1&id=%@&withContent=1&pushtype=0&r=message%%2Fdetail&"

//首页TableView  上拉加载的url
#define APPInformationAPI1 @"http://api.playsm.com/index.php?size=10&r=message%2Flist&page=1&"

#define APPInformationAPI2 @"http://api.playsm.com/index.php?lastCount=19751&lastShowTime=20022http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F125d65949973b04812eeb1431198ac05_51708.jpeg%3FimageView2%2F2%2Fq%2F80&size=10&r=message%2Flist&page=1&lastID=20022http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F125d65949973b04812eeb1431198ac05_51708.jpeg%3FimageView2%2F2%2Fq%2F80&"

#define APPInformationAPI3 @"http://api.playsm.com/index.php?lastCount=19751&lastShowTime=20035http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F1ccd7141cbedf5252ab790433e635b32_45443.jpeg%3FimageView2%2F2%2Fq%2F80&size=10&r=message%2Flist&page=1&lastID=20035http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F1ccd7141cbedf5252ab790433e635b32_45443.jpeg%3FimageView2%2F2%2Fq%2F80&"

#define APPInformationAPI4 @"http://api.playsm.com/index.php?lastCount=19751&lastShowTime=20054http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F7f3ff28291c3e5006010720196f0a05f_375571.png%3FimageView2%2F2%2Fq%2F80&size=10&r=message%2Flist&page=1&lastID=20054http%3A%2F%2F7xkbpd.com2.z0.glb.qiniucdn.com%2F7f3ff28291c3e5006010720196f0a05f_375571.png%3FimageView2%2F2%2Fq%2F80&"


//漫画页，推荐的接口
#define APPCartoonRecommendAPI  @"http://api.playsm.com/index.php?page=1&r=recommend%2FgetUserRecommendList&size=999&"

#define APPCartoonRollViewAPI @"http://api.playsm.com/index.php?size=999&r=adImage%2Flist&customPosition=2&page=1&"


//推荐 中 更多的接口
#define APPCartoonMoreAPI @"http://api.playsm.com/index.php?size=20&r=cartoonCategory%%2FgetCartoonSetListByCategory&id=%@&page=1&"

//漫画的详情接口
#define  APPCartoonDetailAPI @"http://api.playsm.com/index.php?r=cartoonSet%%2Fdetail&id=%@&"

//榜单的接口
#define APPCartoonBillBoardAPI  @"http://api.playsm.com/index.php?size=12&r=cartoonBillBoard%%2FgetCartoonSetListByBillBoard&page=1&id=%@&"


//类别的接口
#define APPCartoonCategory @"http://api.playsm.com/index.php?size=12&r=cartoonCategory%%2FgetCartoonSetListByCategory&page=1&id=%@&"


//漫画图片内容的接口
#define APPCartoonPictureAPI @"http://api.playsm.com/index.php?size=10&orderType=1&r=cartoonChapter%%2FalbumList&page=1&isSize=1&chapterId=%zi&"




#endif /* APPUrl_h */
