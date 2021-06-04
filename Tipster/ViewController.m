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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}
- (IBAction)onEdit:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    
//    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    BOOL hasLoaded = [defaults doubleForKey:@"default_tip_percentages"];
//    if (doubleValue == 0)
//        self.percentages = @[@(0.15), @(0.2), @(0.22)];
//    else
//        self.percentages = @[@(doubleValue), @(0.2), @(0.22)];
    self.percentages = @[@(0.15), @(0.2), @(0.22)];
    double tipPercentages = [self.percentages[self.tipControl.selectedSegmentIndex]doubleValue];
    
    double bill = [self.billField.text doubleValue];
    double tip = tipPercentages * bill;
    if (hasLoaded == NO)
        tip = tip;
    else
        tip = bill * doubleValue;
    
    double total = tip + bill;
    if (hasLoaded == NO)
        total = total;
    else
        total = bill + (bill * doubleValue);
    
    [self.view reloadInputViews];
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}
- (IBAction)onEditingBegin:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.billField.frame = CGRectMake(self.billField.frame.origin.x - 50, self.billField.frame.origin.y + 100, self.billField.frame.size.width, self.billField.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha = 0;
    }];

}

- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 100;
    newFrame.origin.x += 50;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
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
     NSLog(@"string %@", item);
 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"View will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
//
////    NSMutableArray *myArray = [self.percentages mutableCopy];
////    NSMutableArray *myArray = [[NSMutableArray alloc] initWithArray: self.percentages copyItems:YES];
////    [myArray replaceObjectAtIndex:1 withObject:@(doubleValue)];
//    self.percentages = @[@(0.15), @(0.2), @(0.22)];
//    NSMutableArray *myArrayUpdate = [self.percentages mutableCopy];
//    myArrayUpdate[1] = @(doubleValue);
//    self.percentages = [NSArray arrayWithArray: myArrayUpdate];
////    [self.percentages[self.tipControl.selectedSegmentIndex]doubleValue];
////    NSArray *ar1 = @[@(doubleValue)];
////    NSMutableArray *percentages = [ar1 mutableCopy];
////    percentages[1] = @"Changed";
////    ar1 = [NSArray arrayWithArray:percentages];
//
////    NSArray percentages = @[@(doubleValue), @(0.2), @(0.22)];
//    [self.percentages[self.tipControl.selectedSegmentIndex]doubleValue];
//    [self.tipControl reloadInputViews];
    
    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSLog(@"View did disappear");
}

@end
