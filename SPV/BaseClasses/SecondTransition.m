//
//  SecondTransition.h
//  TestCoreAnimation
//
//  Created by 黄梦炜 on 2017/11/27.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "SecondTransition.h"

@implementation SecondTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
//
//    //获得要移动的图片的快照
//    UIView *imageSnapshot = [fromViewController.imageHead snapshotViewAfterScreenUpdates:NO];
//    imageSnapshot.frame = [containerView convertRect:fromViewController.imageHead.frame fromView:fromViewController.imageHead.superview];
//    fromViewController.imageHead.hidden = YES;
//
//    //获得图片对应的cell
//    ImageTableViewCell *cell = [toViewController.table cellForRowAtIndexPath:[toViewController.table indexPathForSelectedRow]];
//    NSLog(@"indexPath:%@",[toViewController.table indexPathForSelectedRow]);
//    cell.imageBack.hidden = YES;
//
//    //设置初始view的状态
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
//    [containerView addSubview:imageSnapshot];
//
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.alpha = 0.0;
//        imageSnapshot.frame = [containerView convertRect:cell.imageBack.frame fromView:cell.imageBack.superview];
    } completion:^(BOOL finished) {
//        [imageSnapshot removeFromSuperview];
//        fromViewController.imageHead.hidden = NO;
//        cell.imageBack.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
//
    
  
}




@end
