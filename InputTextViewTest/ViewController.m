//
//  ViewController.m
//  InputTextViewTest
//
//  Created by     songguolin on 16/2/16.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ViewController.h"

#import "InputTextView1.h"

#define DefineWeakSelf __weak __typeof(self) weakSelf = self
@interface ViewController ()<InputTextView1Delgate,UITextFieldDelegate>
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
        InputTextView1 * input=[InputTextView1 creatInputTextView1];
        input.delegate=self;
        [input show];
    
}
#pragma mark InputTextView1Delgate
-(void)cancleInput1
{
    
}
-(void)finishedInput1:(InputTextView1 *)InputTextView1
{
    self.TF.text=InputTextView1.textView.text;

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
