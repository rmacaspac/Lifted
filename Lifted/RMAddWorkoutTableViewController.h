//
//  RMAddWorkoutTableViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/18/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@protocol RMAddWorkoutTableViewControllerDelegate <NSObject>

- (void)didAddWorkout:(Routine *)routineObject;

@end

@interface RMAddWorkoutTableViewController : UITableViewController

@property (weak, nonatomic) id <RMAddWorkoutTableViewControllerDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *exerciseData;
@property (strong, nonatomic) Routine *routine;

@end
