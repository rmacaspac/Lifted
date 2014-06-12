//
//  RMIndividualWorkoutViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface RMExerciseDataInputViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *exerciseData;
@property (strong, nonatomic) Exercise *selectedExercise;

@end
