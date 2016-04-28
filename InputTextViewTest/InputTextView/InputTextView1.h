//
//  InputTextView1.h
//  模仿优酷的文本输入框
//
//  Created by     songguolin on 16/2/16.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputTextView1;
@protocol InputTextView1Delgate <NSObject>

-(void)cancleInput1;
-(void)finishedInput1:(InputTextView1 *)InputTextView1;

@end
/**
 * 这是创建一个view
 */
@interface InputTextView1 : UIView<UITextViewDelegate>
@property (nonatomic,weak) id<InputTextView1Delgate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@property (nonatomic,assign) NSUInteger MAXLength;  //最大内容


+(instancetype)creatInputTextView1;

-(void)show;


@end



