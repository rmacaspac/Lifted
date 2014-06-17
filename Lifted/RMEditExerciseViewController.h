//
//  RMEditExerciseViewController.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "RMExerciseObject.h"

@protocol RMEditExerciseViewControllerDelegate <NSObject>

-(void)didChangeData:(RMExerciseObject *)editedExerciseObject underIndexPath:(NSInteger)indexPathRow;

@end

@interface RMEditExerciseViewController : UIViewController

@property (weak) id <RMEditExerciseViewControllerDelegate> delegate;

@property (strong, nonatomic) RMExerciseObject *selectedExercise;
@property (nonatomic) NSInteger selectedIndexPath;

@end
