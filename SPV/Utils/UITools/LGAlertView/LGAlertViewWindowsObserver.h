//
//  LGAlertViewWindowsObserver.h
//  LGAlertView
//
//
 
//

#import <UIKit/UIKit.h>

@interface LGAlertViewWindowsObserver : NSObject

+ (instancetype)sharedInstance;

- (void)startObserving;

@end
