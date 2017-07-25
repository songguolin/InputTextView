//
//  ViewController.m
//  InputTextViewTest
//
//  Created by     songguolin on 16/2/16.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ViewController.h"

#import "InputTextView.h"

#define DefineWeakSelf __weak __typeof(self) weakSelf = self
@interface ViewController ()<InputTextViewDelgate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}



- (IBAction)btnClick:(id)sender {
    

    
//    //方法1
//    [self.TF becomeFirstResponder];
//    [self.input.textView becomeFirstResponder];
    
//    方法2
        InputTextView * input=[InputTextView creatInputTextView];
        input.delegate=self;
        [input show];
    
}
#pragma mark InputTextViewDelgate
-(void)cancleInput1
{
    
}
-(void)finishedInput1:(InputTextView *)InputTextView
{
    self.TF.text=InputTextView.textView.text;

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
