//
//  RMAddWorkoutViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMWorkoutObject.h"
#import "Exercise.h"

@protocol RMAddWorkoutViewControllerDelegate <NSObject>

- (void)didAddWorkout:(Routine *)routineObject;

@end

@interface RMAddWorkoutViewController : UIViewController

@property (weak, nonatomic) id <RMAddWorkoutViewControllerDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *exerciseData;
@property (strong, nonatomic) Routine *routine;




@end
