//
//  ViewController.m
//  Tipster
//
//  Created by Alexis Rojas-Westall on 6/2/21.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *percentages;
@property (nonatomic, assign) BOOL entered;
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UILabel *NewTipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.entered = NO;
    self.view.opaque = NO;
    self.view.backgroundColor = UIColor.cyanColor;
    self.view.alpha = 0.7;
    self.NewTipLabel.alpha = 0;
    
    // Do any additional setup after loading the view.

}
- (id)init
{
    self.entered = NO;
    return self;
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}
- (IBAction)onEdit:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"new_tip_percentage"];
    double original = [defaults doubleForKey:@"default_tip_percentage"];
    
    if (self.entered == NO)
        self.percentages = @[@(0.15), @(0.2), @(0.22)];
    else
        self.percentages = @[@(doubleValue), @(0.2), @(0.22)];
//        self.NewTipLabel.alpha = 1;
//        doubleValue = doubleValue * 100;
//        int myInt = (int)round(doubleValue);
//        self.NewTipLabel.text = [NSString stringWithFormat:@"%d", myInt];
    
    double tipPercentages = [self.percentages[self.tipControl.selectedSegmentIndex]doubleValue];
    
    double bill = [self.billField.text doubleValue];
    double tip = tipPercentages * bill;
    double total = tip + bill;
    
    [self.view reloadInputViews];
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}
- (IBAction)onEditingBegin:(id)sender {
//    self.entered = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.billField.frame = CGRectMake(self.billField.frame.origin.x - 50, self.billField.frame.origin.y + 100, self.billField.frame.size.width, self.billField.frame.size.height);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.currency.frame = CGRectMake(self.currency.frame.origin.x + 30, self.currency.frame.origin.y + 95, self.currency.frame.size.width, self.currency.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha = 0;
    }];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.alpha = 0;
//    }];

}

- (IBAction)onEditingEnd:(id)sender {
//    self.NewTipLabel.alpha = 0;
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 100;
    newFrame.origin.x += 50;
    
    CGRect currencyNewFrame = self.currency.frame;
    currencyNewFrame.origin.y -= 95;
    currencyNewFrame.origin.x -= 30;

    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
        self.currency.frame = currencyNewFrame;
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha = 1;
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSettingsSegue"]){
        SettingsViewController *controller = (SettingsViewController *)segue.destinationViewController;
        controller.segmentedControl = self.tipControl;
    }
}


- (void)addItemViewController:(SettingsViewController *)controller didFinishEnteringItem:(NSString *)item
 {
     NSLog(@"This was returned from ViewControllerB %@", item);
     SettingsViewController *viewControllerB = [[SettingsViewController alloc] initWithNibName:@"viewControllerB" bundle:nil];
     viewControllerB.delegate = self;
     [[self navigationController] pushViewController:viewControllerB animated:YES];
 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"View will appear");
}

- (void)viewDidAppear:(BOOL)animated {
//    self.NewTipLabel.alpha = 0;
    [super viewDidAppear:animated];
//    self.entered = NO;
    [self.billField becomeFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha = 0;
    }];
    
    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.entered = YES;

    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
//    self.NewTipLabel.alpha = 1;
    [super viewDidDisappear:animated];
    self.entered = YES;

    NSLog(@"View did disappear");
}

@end
