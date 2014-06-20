//
//  RMEditExerciseTableViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/17/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "Muscle.h"
#import "RMExerciseObject.h"

@protocol RMEditExerciseTableViewControllerDelegate <NSObject>

-(void)didChangeData:(RMExerciseObject *)editedExerciseObject underIndexPath:(NSInteger)indexPathRow;

@end

@interface RMEditExerciseTableViewController : UITableViewController

@property (weak) id <RMEditExerciseTableViewControllerDelegate> delegate;

@property (strong, nonatomic) RMExerciseObject *selectedExercise;
@property (strong, nonatomic) Muscle *muscle;
@property (nonatomic) NSInteger selectedIndexPath;

@end
