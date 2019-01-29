//
//  LGAlertViewWindowsObserver.m
//  LGAlertView
//
//
 
//

#import "LGAlertViewWindowsObserver.h"
#import "LGAlertViewWindow.h"
#import "LGAlertViewWindowContainer.h"
#import "LGAlertViewHelper.h"

@interface LGAlertViewWindowsObserver ()

@property (strong, nonatomic) NSMutableArray *windowsArray;

@end

@implementation LGAlertViewWindowsObserver

+ (instancetype)sharedInstance {
    static LGAlertViewWindowsObserver *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [LGAlertViewWindowsObserver new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.windowsArray = [NSMutableArray new];
    }
    return self;
}

- (void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowVisibleChanged:) name:UIWindowDidBecomeVisibleNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowVisibleChanged:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (void)windowVisibleChanged:(NSNotification *)notification {
    UIWindow *window = notification.object;
    __weak UIWindow *weakWindow = window;
    NSString *windowClassName = NSStringFromClass([window class]);

    if (![windowClassName containsString:@"Alert"]) {
        return;
    }

    // -----

    UIWindow *lastWindow = [self lastWindow];

    if (notification.name == UIWindowDidBecomeVisibleNotification) {
        if ([self isWindowsArrayContains:window]) {
            if (lastWindow && window != lastWindow) {
                window.hidden = YES;
                [lastWindow makeKeyAndVisible];
            }
        }
        else {
            if (lastWindow && ![window isKindOfClass:[LGAlertViewWindow class]]) {
                lastWindow.hidden = YES;
            }

            LGAlertViewWindowContainer *container = [LGAlertViewWindowContainer containerWithWindow:window];
            [self.windowsArray addObject:container];
        }
    }
    else if (notification.name == UIWindowDidBecomeHiddenNotification) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!weakWindow) {
                UIWindow *lastWindow = [self lastWindow];

                if (lastWindow) {
                    [lastWindow makeKeyAndVisible];
                }
            }
        });
    }
}

- (UIWindow *)lastWindow {
    NSMutableArray *newArray = [NSMutableArray new];
    UIWindow *lastWindow;

    for (LGAlertViewWindowContainer *container in self.windowsArray) {
        if (container.window) {
            [newArray addObject:container];
            lastWindow = container.window;
        }
    }

    self.windowsArray = newArray;

    return lastWindow;
}

- (BOOL)isWindowsArrayContains:(UIWindow *)window {
    for (LGAlertViewWindowContainer *container in self.windowsArray) {
        if (container.window == window) {
            return YES;
        }
    }

    return NO;
}

@end
