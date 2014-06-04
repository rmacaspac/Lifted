//
//  RMSelectExercisesViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMExercises.h"

@protocol RMSelectExercisesViewControllerDelegate <NSObject>

- (void)didSelectExercise:(NSMutableArray *)selectedExercise;

@end

@interface RMSelectExercisesViewController : UIViewController

@property (weak, nonatomic) id <RMSelectExercisesViewControllerDelegate> delegate;

@end
