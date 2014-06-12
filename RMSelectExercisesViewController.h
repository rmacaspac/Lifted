//
//  RMSelectExercisesViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMExerciseObject.h"
#import "Exercise.h"

@protocol RMSelectExercisesViewControllerDelegate <NSObject>

- (void)didSelectExercise:(RMExerciseObject *)selectedExercise;

@end

@interface RMSelectExercisesViewController : UIViewController

@property (weak, nonatomic) id <RMSelectExercisesViewControllerDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *exerciseObject;

@end
