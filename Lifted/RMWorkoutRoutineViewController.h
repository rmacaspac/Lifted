//
//  RMWorkoutRoutineViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMWorkoutObject.h"

@interface RMWorkoutRoutineViewController : UIViewController

@property (strong, nonatomic) NSArray *workoutExercises;
@property (strong, nonatomic) RMWorkoutObject *workoutObject;

@end
