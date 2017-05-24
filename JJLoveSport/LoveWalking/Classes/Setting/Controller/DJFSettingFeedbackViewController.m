//
//  DJFSettingFeedbackViewController.m
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/14.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSettingFeedbackViewController.h"
#import "DJFProgressHUD.h"
@interface DJFSettingFeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>

/**
 qq或手机号码textView
 */
@property (weak, nonatomic) IBOutlet UITextView *qqOrPhoneTextView;

@property (weak, nonatomic) IBOutlet UITextField *qqTextfield;

/**
 反馈内容textView
 */
@property (weak, nonatomic) IBOutlet UITextView *feedbackContentTextView;

@end

@implementation DJFSettingFeedbackViewController

-(void)awakeFromNib{
    
    [super awakeFromNib];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUI{
    
    self.view.backgroundColor = [UIColor  redColor];
    
    [self setTextView];
    
}

-(void)setTextView{
    
    //设置代理
    _qqTextfield.delegate = self;
    _qqOrPhoneTextView.delegate = self;
    _feedbackContentTextView.delegate = self;
    
    //设置占位内容
    _qqTextfield.text = @"手机号或QQ号 (必填)";
    _qqTextfield.textColor = [UIColor grayColor];
    
    
    _feedbackContentTextView.text = @"问题描述 (选填)";
    _feedbackContentTextView.textColor = [UIColor grayColor];
    
}
#pragma mark - 代理方式
//开始编辑时调用
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([_feedbackContentTextView.text isEqualToString:@"问题描述 (选填)"]) {
        
        _feedbackContentTextView.text = @"";
        _feedbackContentTextView.textColor = [UIColor blackColor];
        
    }

}

//结束编辑时调用

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (_feedbackContentTextView.text.length < 1) {
        
        _feedbackContentTextView.text = @"问题描述 (选填)";
        _feedbackContentTextView.textColor = [UIColor grayColor];
        
        
    }

}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([_qqTextfield.text isEqualToString:@"手机号或QQ号 (必填)"]) {
        _qqTextfield.text = @"";
        _qqTextfield.textColor = [UIColor blackColor];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_qqTextfield.text.length < 1) {
        _qqTextfield.text = @"手机号或QQ号 (必填)";
        _qqTextfield.textColor = [UIColor grayColor];
    }
    
}

#pragma mark - 按钮点击事件
- (IBAction)submitButton:(UIButton *)sender {
    
    if ([_qqTextfield.text isEqualToString:@"手机号或QQ号 (必填)"] ) {
        [DJFProgressHUD showErrorMessageWithConver:@"提交失败"];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [DJFProgressHUD showSuccessMessage:@"提交成功"];
        
        [self setTextView];
    });
}

#pragma mark - 回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_feedbackContentTextView resignFirstResponder];
    [_qqOrPhoneTextView resignFirstResponder];
    [_qqTextfield resignFirstResponder];
}
@end
