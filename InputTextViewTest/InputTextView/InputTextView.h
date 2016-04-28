//
//  SYFTextBox.h
//  模仿优酷的文本输入框
//
//  Created by syf on 15/8/3.
//  Copyright (c) 2015年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputTextView;
@protocol InputTextViewDelgate <NSObject>

-(void)cancelInput;
-(void)finishedInput:(InputTextView *)InputTextView;

@end
/**
 * 这是基于inputAccessoryView,ci
 */
@interface InputTextView : UIView<UITextViewDelegate>
@property (nonatomic,weak) id<InputTextViewDelgate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@property (nonatomic,assign) NSUInteger MAXLength;  //最大内容

+ (instancetype)createInputTextView;
@end
