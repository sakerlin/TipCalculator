//
//  SetViewController.m
//  Tip-Caculator
//
//  Created by Saker Lin on 2015/6/9.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *setDefaultController;
- (void)updateDefaultTip;
- (IBAction)onDefaultPercentChange:(id)sender;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger defaultTipControlIdx = [defaults integerForKey:@"default_tip_control_idx"];
    [self.setDefaultController setSelectedSegmentIndex:defaultTipControlIdx];

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
- (void)updateDefaultTip {
}

- (IBAction)onDefaultPercentChange:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.setDefaultController.selectedSegmentIndex forKey:@"default_tip_control_idx"];
    [defaults synchronize];
}
@end
