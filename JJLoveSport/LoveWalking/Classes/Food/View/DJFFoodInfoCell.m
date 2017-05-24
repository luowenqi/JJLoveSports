//
//  DJFFoodInfoCell.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/15.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodInfoCell.h"
#import <WebKit/WebKit.h>
@interface DJFFoodInfoCell ()<WKNavigationDelegate>
/**
 *  <#名称#>
 */
@property(nonatomic,strong)WKWebView * wkWebView;
@end
@implementation DJFFoodInfoCell{
    UIActivityIndicatorView* activityView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFId:(NSString *)fId{
    _fId = fId;
    
    DJFNetWorkManager* manger = [DJFNetWorkManager sharedManager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [activityView startAnimating];
    [manger reqeustWith:[NSString stringWithFormat:@"%@?fId=%@",cookInfoUrl,fId] method:@"GET" parameters:nil callBack:^(id response) {
        NSString* htmlStr = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
        NSString* infoCss = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cookInfo.css" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<$replaceInfoCss$>" withString:infoCss];
        [_wkWebView loadHTMLString:htmlStr baseURL:nil];
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    WKWebView* wkWebView = [[WKWebView alloc]init];
    [self.contentView addSubview:wkWebView];

    _wkWebView = wkWebView;
    _wkWebView.navigationDelegate = self;
    _wkWebView.scrollView.pagingEnabled = YES;
    
    activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.contentView addSubview:activityView];
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.offset = 30;
    }];
    //    //监听wkwebview contentSize的变化
    //        [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(550);
    }];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
{
    [activityView stopAnimating];
}
//
////根据contSize 改变wkwebView高度
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context
//{
//    static int i = 0;
//    i++;
//    NSLog(@"%d",i);
//    if (object == _wkWebView.scrollView && [keyPath isEqual:@"contentSize"]) {
//
//        UIScrollView *scrollView = _wkWebView.scrollView;
//        webViewH = scrollView.contentSize.height;
//        [_wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(webViewH);
//        }];
//        [_wkWebView reloadInputViews];
//
//        CGRect frame = self.frame;
//        frame.size.height += webViewH - lastHeight;
//        lastHeight = webViewH;
//        self.frame = frame;
//        //_changeHeigh();
//    }
//}
////移除
//- (void)dealloc
//{
//    [_wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
