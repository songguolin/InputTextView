//
//  InputTextView1.m
//  模仿优酷的文本输入框
//
//  Created by     songguolin on 16/2/16.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import "InputTextView1.h"

#define MAINSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MAINSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define DEFAULT_HEIGHT (150)
@interface InputTextView1 ()
{
    UIControl * _overView;
    BOOL      _isKeyboardShow;
    BOOL      _isThirdPartKeyboard;
    NSInteger _keyboardShowTime;
    CGFloat   _defaultConstraint;
    CGFloat   _keyboardAnimateDur;
    CGPoint   _oldOffset;
    CGRect    _keyboardFrame;
    
}
@end
@implementation InputTextView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{

    [self initKeyboardObserver];
    self.MAXLength=300;
}
+(instancetype)creatInputTextView1
{
    InputTextView1 * input=[[[NSBundle mainBundle] loadNibNamed:@"InputTextView1" owner:nil options:nil] lastObject];
    [input setup];
    return input;
}
-(void)setup
{
    self.frame=CGRectMake(0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
   
    
    
    _overView=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _overView.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.3];
    
    [_overView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

-(void)show
{
    UIWindow * keyWindow=[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_overView];
    [keyWindow addSubview:self];
    
    [self.textView becomeFirstResponder];
    
}
-(void)dismiss
{
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
    
    if ([self.delegate respondsToSelector:@selector(cancleInput1)]) {
        [self.delegate cancleInput1];
    }
}

- (IBAction)publishClick:(id)sender {
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(finishedInput1:)]) {
        [self.delegate finishedInput1:self];
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
#pragma mark - 键盘事件
- (void)initKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}
- (void)keyboardWillShow:(NSNotification*)notification
{
    
    NSValue* keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardBoundsValue CGRectValue];
    
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];

    _keyboardShowTime++;
    
    // 第三方输入法有bug,第一次弹出没有keyboardRect
    if (animationDur > 0.0f && keyboardRect.size.height == 0)
    {
        _isThirdPartKeyboard = YES;
    }
    
    // 第三方输入法,有动画间隔时,没有高度
    if (_isThirdPartKeyboard)
    {
        // 第三次调用keyboardWillShow的时候 键盘完全展开
        if (_keyboardShowTime == 3 && keyboardRect.size.height != 0 && keyboardRect.origin.y != 0)
        {
            _keyboardFrame = keyboardRect;

            NSLog(@"_keyboardFrame.size.height--%f",_keyboardFrame.size.height);
            //Animate change
            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame=CGRectMake(0,MAINSCREEN_HEIGHT- _keyboardFrame.size.height-DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
                
//                [self layoutIfNeeded];
//                [self layoutSubviews];
            }];
            
        }
        if (animationDur > 0.0)
        {
            _keyboardAnimateDur = animationDur;
        }
    }
    else
    {
        if (animationDur > 0.0)
        {
            _keyboardFrame = keyboardRect;
            _keyboardAnimateDur = animationDur;
            
            //Animate change
            [UIView animateWithDuration:_keyboardAnimateDur animations:^{
                
                self.frame=CGRectMake(0,MAINSCREEN_HEIGHT- _keyboardFrame.size.height-DEFAULT_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
                
                [self layoutIfNeeded];
                [self layoutSubviews];
            }];
        }
    }
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    _isKeyboardShow = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _isThirdPartKeyboard = NO;
    _keyboardShowTime = 0;
    
    if (animationDur > 0.0)
    {
        
        [_overView removeFromSuperview];
        [UIView animateWithDuration:_keyboardAnimateDur animations:^{
            
            self.frame=CGRectMake(0,MAINSCREEN_HEIGHT+20, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
            [self layoutIfNeeded];
            [self layoutSubviews];
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    _isKeyboardShow = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
