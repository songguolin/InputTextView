//
//  SYFTextBox.m
//  模仿优酷的文本输入框
//
//  Created by syf on 15/8/3.
//  Copyright (c) 2015年 SYF. All rights reserved.
//

#import "InputTextView.h"

@interface InputTextView ()
{
    UIControl * _bgView;
}
@end
@implementation InputTextView
- (void)awakeFromNib
{

    
   
    
    UIWindow * keyWindow=[UIApplication sharedApplication].keyWindow;
    _bgView=[[UIControl alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [keyWindow addSubview:_bgView];
    
    _bgView.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.3];

    [_bgView addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.MAXLength=300;
   
    
 }

+ (instancetype)createInputTextView
{

    InputTextView * box=[[[NSBundle mainBundle] loadNibNamed:@"InputTextView" owner:nil options:nil] lastObject];
    [box.textView becomeFirstResponder];
    return box;
}
-(void)dismiss
{

 
        [_bgView removeFromSuperview];
        [self.textView resignFirstResponder];


}
- (IBAction)clearClick:(id)sender {
    
    self.textView.text=@"";
    self.placeHolderLabel.hidden=NO;
    [self.publishBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateNormal];
     NSString * title=[NSString stringWithFormat:@"0/%lu ❌",(unsigned long)self.MAXLength];
    [self.checkBtn setTitle:title forState:UIControlStateNormal];

}

- (IBAction)cancleClick:(id)sender {
    
   [self dismiss];
    if ([self.delegate respondsToSelector:@selector(cancelInput)]) {
        [self.delegate cancelInput];
    }
    
    
}

- (IBAction)publishClick:(id)sender {


    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(finishedInput:)]) {
        [self.delegate finishedInput:self];
        
    }
    
  
}
#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView;
{
    if (self.textView.text.length>0) {
        [self.publishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    else
    {
        
        [self.publishBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateNormal];
    }
    NSString * title=[NSString stringWithFormat:@"%lu/%lu ❌",(unsigned long)self.textView.text.length,(unsigned long)self.MAXLength];
    
    [self.checkBtn setTitle:title forState:UIControlStateNormal];
    self.placeHolderLabel.hidden=self.textView.text.length>0?YES:NO;
}



@end
