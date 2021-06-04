//
//  SettingsViewController.h
//  Tipster
//
//  Created by Alexis Rojas-Westall on 6/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SettingsViewController;

@protocol SetttingsViewControllerDelegate <NSObject>
-(void)addItemViewController:(SettingsViewController *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface SettingsViewController : UIViewController
@property (nonatomic, assign) UISegmentedControl *segmentedControl;
@property (nonatomic, weak) id<SetttingsViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
