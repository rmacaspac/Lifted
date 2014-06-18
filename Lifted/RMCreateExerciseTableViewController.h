//
//  RMCreateExerciseTableViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/17/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMExerciseObject.h"

@protocol RMCreateExerciseTableViewControllerDelegate <NSObject>

- (void)didCreateWorkout:(RMExerciseObject *)exerciseObject;

@end

@interface RMCreateExerciseTableViewController : UITableViewController

@property (weak, nonatomic) id <RMCreateExerciseTableViewControllerDelegate> delegate;

@end
