//
//  SettingsViewController.m
//  Tipster
//
//  Created by Alexis Rojas-Westall on 6/3/21.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *NewTipPercentageField;


@end
@implementation SettingsViewController

- (void)viewDidLoad; {
    [super viewDidLoad];
    self.NewTipPercentageField.text = 0;
    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    [defaultss setBool:NO forKey:@"default_tip_percentages"];
    [defaultss synchronize];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    doubleValue = 0;
    // Do any additional setup after loading the view.
}
- (IBAction)onButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onEditing:(id)sender {
//    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
//    settingsViewController.delegate = self;
//    [[self navigationController] pushViewController: settingsViewController animated:YES];
    double newTip = [self.NewTipPercentageField.text doubleValue];
    newTip = newTip * .01;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:newTip forKey:@"default_tip_percentage"];
    [defaults synchronize];
    
//    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    Boolean hasLoaded = [defaults doubleForKey:@"default_tip_percentages"];
//    [defaults setBool:hasLoaded forKey:@"default_tip_percentage"];
    hasLoaded = YES;
    [defaults synchronize];

//    NSNumber *doubleNumber = [NSNumber numberWithDouble:newTip];
//    NSString *string = [doubleNumber stringValue];
//    [self.delegate addItemViewController:self didFinishEnteringItem:string];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
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
