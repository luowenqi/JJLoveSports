//
//  JJMapTypeChooseVC.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/16.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJMapTypeChooseVCDelegate <NSObject>

-(void)changeMapeType:(UIButton*)sender;

@end

@interface JJMapTypeChooseVC : UIViewController

@property(nonatomic , weak) id<JJMapTypeChooseVCDelegate> deleagte;

@end
