//
//  DJFNewsViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNewsViewController.h"
#import "DJFNewsSearchViewController.h"
#import "DJFCategoryView.h"
#import "DJFNewsListViewController.h"
@interface DJFNewsViewController ()<UISearchBarDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
/**
 *  资讯搜索框
 */
@property(nonatomic,strong)UISearchBar *searchNewsBar;

/**
 *  频道
 */
@property(nonatomic,strong)DJFCategoryView *categoryView;

/**
 *  分页控制器
 */
@property(nonatomic,strong)UIPageViewController *pageVC;

@end

@implementation DJFNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 搭建UI
- (void)setupUI{
    
    //MARK: 搜索框
    _searchNewsBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_BOUNDS.size.width, 40)];
    _searchNewsBar.placeholder = @"请输入相关资讯内容";
    _searchNewsBar.delegate = self;
    _searchNewsBar.backgroundColor = THEME_COLOR;
    self.navigationItem.titleView = _searchNewsBar;
    
    //MARK: 分类
    DJFCategoryView* categoryView = [[DJFCategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_BOUNDS.size.width, 44)];
    //切换栏目点击事件
    [categoryView addTarget:self action:@selector(selectedChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:categoryView];
    _categoryView = categoryView;
    //设置内容
    _categoryView.catagoryList = [[NSArray alloc]initWithObjects:@"健身",@"减肥",@"塑形", nil];
    
    //MARK:详细页面
    //创建及设置分页控制器
     _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageVC.view.backgroundColor = [UIColor whiteColor];
    //设置数据源和代理
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    //添加到本控制器中
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    [_pageVC didMoveToParentViewController:self];
    
    //添加分页控制器初始页面
    [_pageVC setViewControllers:@[[[DJFNewsListViewController alloc]initWithPageIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //页面布局
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
        make.top.equalTo(categoryView.mas_bottom).offset(0);
    }];
 

}

#pragma mark - 分页控制器数据源协议
//前一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(DJFNewsListViewController *)viewController{
    NSInteger currentPageIndex = viewController.pageIndex;
    if (currentPageIndex == 0) {
        return nil;
    }
    currentPageIndex --;
    DJFNewsListViewController* listVC = [[DJFNewsListViewController alloc]initWithPageIndex:currentPageIndex];
    
    return listVC;
    
}
//后一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(DJFNewsListViewController *)viewController{
    NSInteger currentPageIndex = viewController.pageIndex;
    if (currentPageIndex >= _categoryView.catagoryList.count -1 ) {
        return nil;
    }
    currentPageIndex ++;
    DJFNewsListViewController* listVC = [[DJFNewsListViewController alloc]initWithPageIndex:currentPageIndex];
    
    return listVC;
}

#pragma mark - 分页控制器代理协议
//即将显示页面
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    DJFNewsListViewController* pageList = (DJFNewsListViewController*)pendingViewControllers[0];
    _categoryView.currentIndex = pageList.pageIndex;
    
    
}
//最终显示页面
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    DJFNewsListViewController* pageList = (DJFNewsListViewController*)pageViewController.viewControllers[0];
    _categoryView.currentIndex = pageList.pageIndex;
}
#pragma mark - 搜索框代理 UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;{
    
    DJFNewsSearchViewController* searchVC = [DJFNewsSearchViewController new];
    searchVC.view.backgroundColor = [UIColor whiteColor];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}
#pragma mark - 按钮点击事件
-(void)selectedChange:(DJFCategoryView*)cgView{
    
  //切换频道内容
    NSInteger selectIndex = cgView.currentIndex;
    DJFNewsListViewController* listVC = [[DJFNewsListViewController alloc]initWithPageIndex:selectIndex];
    
    //判断方向
    UIPageViewControllerNavigationDirection pageDirection = selectIndex > [_pageVC.viewControllers[0] pageIndex]? UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse;
    [_pageVC setViewControllers:@[listVC] direction:pageDirection animated:YES completion:nil];
}
@end
