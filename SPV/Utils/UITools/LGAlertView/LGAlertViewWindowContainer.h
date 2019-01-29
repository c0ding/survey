//
//  LGAlertViewWindowContainer.h
//  LGAlertView
//
//
 
//

#import <UIKit/UIKit.h>

@interface LGAlertViewWindowContainer : NSObject

- (instancetype)initWithWindow:(UIWindow *)window;

+ (instancetype)containerWithWindow:(UIWindow *)window;

@property (weak, nonatomic) UIWindow *window;

@end
