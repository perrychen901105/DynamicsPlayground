//
//  ViewController.m
//  DynamicsPlayground
//
//  Created by Perry on 14-7-18.
//  Copyright (c) 2014年 Perrychen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollisionBehaviorDelegate>
{
    /**
     UIDynamicAnimator is the UIKit physics engine. This class keeps track of the various behaviors that you add to the engine, such as gravity, and provides the overall context. When you create an instance of an animator, you pass in a reference view that the animator uses to define its coordinate system.
     
     
     UIGravityBehavior models the behavior of gravity and exerts forces on one or more items, allowing you to model physical interactions. When you create an instance of a behavior, you associate it with a set of items — typically views. This way you can select which items are influenced by the behavior, in this case which items the gravitational forces affect.
     
     */
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];    // 设置参考的view
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    _collision.collisionDelegate = self;
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    // add a boundary that coincides with the top edge
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width, barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];
    
    _collision.action = ^{
//        NSLog(@"%@, %@",
//              NSStringFromCGAffineTransform(square.transform),
//              NSStringFromCGPoint(square.center));
    };
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"Boundary contact occurred - %@", identifier);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
