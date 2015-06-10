//
//  TipViewController.m
//  Tip-Caculator
//
//  Created by Saker Lin on 2015/6/9.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (strong, nonatomic) IBOutlet UITextField *billTextField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (IBAction)tipControlChange:(id)sender;
- (IBAction)billChange:(id)sender;

@end

@implementation TipViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.billTextField becomeFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultTipControlIdx = [defaults integerForKey:@"default_tip_control_idx"];
    NSLog(@"%ld", defaultTipControlIdx);
    [self.tipControl setSelectedSegmentIndex:defaultTipControlIdx];
    
    NSDate* lastBillDate = [defaults valueForKey:@"last_bill_date"];
    NSDate* now = [NSDate date];
    
    NSTimeInterval interval = [now timeIntervalSinceDate:lastBillDate];
    if (interval < 600) {
        self.billTextField.text = [defaults valueForKey:@"last_bill_amount"];
    } else {
        self.billTextField.text = @"";
    }
    
    // Update the values in the UI.
    [self updateValues];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
     NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.billTextField.text forKey:@"last_bill_amount"];
    [defaults setObject:[NSDate date] forKey:@"last_bill_date"];
    [defaults setInteger:self.tipControl.selectedSegmentIndex forKey:@"last_tip_segment_index"];
    [defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultTipControlIdx = [defaults integerForKey:@"default_tip_control_idx"];
    [self.tipControl setSelectedSegmentIndex:defaultTipControlIdx];
    [self updateValues];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.tipLabel.text = [numberFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:tipAmount]];
    self.totalLabel.text = [numberFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:totalAmount]];
}
- (IBAction)onTap:(id)sender {
    [self updateValues];
    
}
- (IBAction)tipControlChange:(id)sender {
      [self updateValues];
}

- (IBAction)billChange:(id)sender {
      [self updateValues];
}

@end
