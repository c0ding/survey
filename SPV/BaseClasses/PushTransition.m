//
//  PushTransition.m
//  TestCoreAnimation
//
//  Created by 黄梦炜 on 2017/11/27.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "PushTransition.h"

@implementation PushTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    firstViewController *fromViewController = (firstViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    pushToViewController *toViewController = (pushToViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = [transitionContext containerView];
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//
//    //获得cell中的图片的快照
//    ImageTableViewCell *cell = (ImageTableViewCell*)[fromViewController.table cellForRowAtIndexPath:[fromViewController.table indexPathForSelectedRow]];
//    UIView *cellImageSnapshot = [cell.imageBack snapshotViewAfterScreenUpdates:NO];
//    cellImageSnapshot.frame = [containerView convertRect:cell.imageBack.frame fromView:cell.imageBack.superview];
//    cell.imageView.hidden = YES;
//
//    //设置初始view的状态
//    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
//    toViewController.view.alpha = 0;
//    toViewController.imageHead.hidden = YES;
//
//    [containerView addSubview:toViewController.view];
//    [containerView addSubview:cellImageSnapshot];
//
//    [UIView animateWithDuration:duration animations:^{
//        toViewController.view.alpha = 1.0;
//        CGRect frame = [containerView convertRect:toViewController.imageHead.frame fromView:toViewController.view];
//        cellImageSnapshot.frame = frame;
//    }completion:^(BOOL finished) {
//        toViewController.imageHead.hidden = NO;
//        cell.imageView.hidden = NO;
//        [cellImageSnapshot removeFromSuperview];
//
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIViewController *fromViewController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [fromViewController.view setAlpha:0];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = CGRectMake(0, 200, frame.size.width , frame.size.height);
    
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    
    
   
    
    
    
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toViewController.view.alpha = 0.5;
        toViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [UIView animateWithDuration:0.1 animations:^{
            toViewController.view.alpha = 1;
        }];
        
    }];
    
//    [UIView animateWithDuration:duration animations:^{
//
//        toViewController.view.alpha = 1.0;
//        toViewController.view.frame = frame;
//
//    }completion:^(BOOL finished) {
//
//
//
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
}

@end
