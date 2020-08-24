//
//  FuQiJiaoViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoViewController.h"
#import "FuQiJiaoHomeCell.h"

@interface FuQiJiaoViewController ()<UITableViewDelegate,UITableViewDataSource,WSPageViewDelegate,WSPageViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong,nullable)WSPageView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,strong)UIButton * pingFenButton1;
@property(nonatomic,strong)UIButton * zuiXinButton1;
@property(nonatomic,strong)UIButton * zuiReButton1;

@property(nonatomic,assign)CGFloat  lastcontentOffset;

@property(nonatomic,strong)NSString * zuiXinOrZuiRe;//1 最新 2 最热


@end

@implementation FuQiJiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    self.sourceArray = [NSMutableArray array];
    NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"key", nil];
    [self.sourceArray addObject:info];
    [self.sourceArray addObject:info];
    [self.sourceArray addObject:info];
    [self.sourceArray addObject:info];
    [self.sourceArray addObject:info];

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu+18*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(TopHeight_PingMu+18*BiLiWidth+BottomHeight_PingMu))style:UITableViewStyleGrouped];
   self.mainTableView.delegate = self;
   self.mainTableView.dataSource = self;
   self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tag = 1002;
   [self.view addSubview:self.mainTableView];

    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu+13*BiLiWidth, WIDTH_PingMu, 14.5*BiLiWidth*2+12*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.itemButtonContentView];
    
    self.zuiXinOrZuiRe = @"1";
    
    self.pingFenButton1 = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 14.5*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    [self.pingFenButton1 setTitle:@"评分最高" forState:UIControlStateNormal];
    [self.pingFenButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.pingFenButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.pingFenButton1 addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.pingFenButton1];
    
    self.zuiXinButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+33*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiXinButton1 setTitle:@"最新" forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    self.zuiXinButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiXinButton1 addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.zuiXinButton1];
    
    self.zuiReButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+79*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiReButton1 setTitle:@"最热" forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.zuiReButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiReButton1 addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.zuiReButton1];

    self.itemButtonContentView.hidden = YES;
}
#pragma mark---scrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1002) {
        
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastcontentOffset;
        self.lastcontentOffset = contentOffset;

        if (offset > 0 && contentOffset > 0) {
           NSLog(@"上拉行为");
            if (scrollView.contentOffset.y>=378*BiLiWidth) {
                
                self.itemButtonContentView.hidden = NO;
            }

        }
        if (offset < 0 && distanceFromBottom > hight) {
            NSLog(@"下拉行为");
            if (scrollView.contentOffset.y<=378*BiLiWidth) {
                
                
            self.itemButtonContentView.hidden = YES;
                       
            }
        }

    }


}
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int cellNumber;
    if (self.sourceArray.count%2==0) {
        
        cellNumber = (int)self.sourceArray.count/2;
    }
    else
    {
        cellNumber = (int)self.sourceArray.count/2+1;
    }
    return cellNumber;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  200*BiLiWidth;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"FuQiJiaoHomeCellCell"] ;
    FuQiJiaoHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[FuQiJiaoHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((indexPath.row+1)*2<=self.sourceArray.count) {
        
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] info2:[self.sourceArray objectAtIndex:indexPath.row*2+1]];
    }
    else
    {
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] info2:nil];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 378*BiLiWidth+24*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    //顶部轮播图
    self.pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 100*BiLiWidth)];
    self.pageView.currentWidth = 305;
    self.pageView.currentHeight = 100;
    self.pageView.normalHeight = 87;
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 1;   //非当前页的透明比例
    self.pageView.minimumPageScale = 0.8;  //非当前页的缩放比例
    self.pageView.orginPageCount = 3; //原始页数
    self.pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
    [headerView addSubview:self.pageView] ;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.top+self.pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = 3;
    [headerView addSubview:self.pageControl];
        
    //官方推荐
    UILabel * guanFangTuiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.pageControl.top+self.pageControl.height+11*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    guanFangTuiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    guanFangTuiJianLable.textColor = RGBFormUIColor(0x333333);
    guanFangTuiJianLable.text = @"官方推荐";
    [headerView addSubview:guanFangTuiJianLable];
    
    UIScrollView * guanFangTuiJianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianLable.top+guanFangTuiJianLable.height+13*BiLiWidth, WIDTH_PingMu, 176*BiLiWidth)];
    guanFangTuiJianScrollView.scrollEnabled = YES;
    [headerView addSubview:guanFangTuiJianScrollView];
    
    for (int i=0; i<3; i++) {
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(12*BiLiWidth+156*BiLiWidth*i, 0, 151.5*BiLiWidth, 176*BiLiWidth)];
        contentView.layer.cornerRadius = 4*BiLiWidth;
        contentView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        contentView.layer.borderWidth = 1;
        contentView.clipsToBounds = YES;
        [guanFangTuiJianScrollView addSubview:contentView];
        
        UITapGestureRecognizer * guanFqangTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guanFnagTap:)];
        [contentView addGestureRecognizer:guanFqangTap];
        
        
        [guanFangTuiJianScrollView setContentSize:CGSizeMake(contentView.left+contentView.width+12*BiLiWidth, guanFangTuiJianScrollView.height)];
        
        NSLog(@"%f=========================****%f",contentView.left+contentView.width+12*BiLiWidth,guanFangTuiJianScrollView.width);
        
        
        UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 126*BiLiWidth)];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.clipsToBounds = YES;
        [contentView addSubview:headerImageView];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
        
        
        
        UILabel *  jiaoBiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(contentView.width-39*BiLiWidth,0,39*BiLiWidth,18*BiLiWidth)];
        jiaoBiaoLable.textAlignment = NSTextAlignmentCenter;
        jiaoBiaoLable.textColor = RGBFormUIColor(0xFFFFFF);
        jiaoBiaoLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        jiaoBiaoLable.adjustsFontSizeToFitWidth = YES;
        jiaoBiaoLable.text = @"北疆";
        [contentView addSubview:jiaoBiaoLable];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = jiaoBiaoLable.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = @[@0,@1];
        [jiaoBiaoLable.layer addSublayer:gradientLayer];
        
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:jiaoBiaoLable.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4*BiLiWidth, 4*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = jiaoBiaoLable.bounds;
        maskLayer.path = maskPath.CGPath;
        jiaoBiaoLable.layer.mask = maskLayer;
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, headerImageView.top+headerImageView.height+9.5*BiLiWidth, contentView.width, 14*BiLiWidth)];
        titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x333333);
        titleLable.text = @"画的健身房";
        titleLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleLable];
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.top+titleLable.height+7*BiLiWidth, contentView.width, 11*BiLiWidth)];
        messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        messageLable.textColor = RGBFormUIColor(0x999999);
        messageLable.text = @"画的健身房";
        messageLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:messageLable];
        
        
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianScrollView.top+guanFangTuiJianScrollView.height+20*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
    [headerView addSubview:lineView];
    
    self.pingFenButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView.top+lineView.height+18*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    [self.pingFenButton setTitle:@"评分最高" forState:UIControlStateNormal];
    [self.pingFenButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.pingFenButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.pingFenButton];
    
    self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
    self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.zuiXinButton];
    
    self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
    self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.zuiReButton];
    
    if ([@"1" isEqualToString:self.zuiXinOrZuiRe]) {
        
        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];


    }
    else
    {
        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
        [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    }
    
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return nil;
}

#pragma mark--guanFnagTap
-(void)guanFnagTap:(UITapGestureRecognizer *)tap
{
    
}
-(void)pingFenButtonClick
{
}
-(void)zuiXinButtonClick
{
    self.zuiXinOrZuiRe = @"1";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
}
-(void)zuiReButtonClick
{
    self.zuiXinOrZuiRe = @"2";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
}
- (void)didScrollToPage:(float)contentOffsetX inFlowView:(WSPageView *)flowView pageNumber:(int)pageNumber{
    
    self.pageControl.currentPage = pageNumber;

}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    
    return 3;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView)
    {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu-60*BiLiWidth, 100*BiLiWidth)];
    }
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    return bannerView;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
