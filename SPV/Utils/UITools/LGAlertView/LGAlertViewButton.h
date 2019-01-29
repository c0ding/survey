//
//  LGAlertViewButton.h
//  LGAlertView
//
//
 
//

#import <UIKit/UIKit.h>
#import "LGAlertViewShared.h"

@interface LGAlertViewButton : UIButton

@property (assign, nonatomic) LGAlertViewButtonIconPosition iconPosition;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
