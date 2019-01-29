//
//  UIWindow+LGAlertView.h
//  LGAlertView
//
//
 
//

#import "UIWindow+LGAlertView.h"

@implementation UIWindow (LGAlertView)

- (nullable UIViewController *)currentViewController {
    UIViewController *viewController = self.rootViewController;

    if (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }

    return viewController;
}

@end
