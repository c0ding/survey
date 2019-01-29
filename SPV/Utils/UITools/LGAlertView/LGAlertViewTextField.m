//
//  LGAlertViewTextField.m
//  LGAlertView
//
//
 
//

#import "LGAlertViewTextField.h"
#import "LGAlertViewHelper.h"

@implementation LGAlertViewTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += LGAlertViewPaddingWidth;
    bounds.size.width -= LGAlertViewPaddingWidth * 2.0;

    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
    }

    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + LGAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }

    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += LGAlertViewPaddingWidth;
    bounds.size.width -= LGAlertViewPaddingWidth * 2.0;

    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
    }

    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + LGAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }

    return bounds;
}

@end
