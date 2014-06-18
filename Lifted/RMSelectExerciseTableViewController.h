//
//  RMSelectExerciseTableViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/18/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMExerciseObject.h"

@protocol RMSelectExercisesTableViewControllerDelegate <NSObject>

- (void)didSelectExercise:(RMExerciseObject *)selectedExercise;

@end

@interface RMSelectExerciseTableViewController : UITableViewController

@property (weak, nonatomic) id <RMSelectExercisesTableViewControllerDelegate> delegate;

@end
