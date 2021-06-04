//
//  SettingsViewController.m
//  Tipster
//
//  Created by Alexis Rojas-Westall on 6/3/21.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *NewTipPercentageField;
@property (weak, nonatomic) IBOutlet UIButton *ReverseButton;


@end
@implementation SettingsViewController

- (void)viewDidLoad; {
    [super viewDidLoad];
    self.NewTipPercentageField.text = 0;
    self.ReverseButton.alpha = 0;
    
    // Do any additional setup after loading the view.
}
- (IBAction)onButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onEditing:(id)sender {
    double newTip = [self.NewTipPercentageField.text doubleValue];
    newTip = newTip * .01;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:newTip forKey:@"new_tip_percentage"];
    [defaults synchronize];

}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)onReverseButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:0.2 forKey:@"default_tip_percentage"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

@synthesize delegate;
-(void)viewWillDisappear:(BOOL)animated
{
    NSString *itemToPassBack = @"default_tip_percentage";
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0 animations:^{
        self.ReverseButton.alpha = 0;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
