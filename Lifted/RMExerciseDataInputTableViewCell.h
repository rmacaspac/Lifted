//
//  RMExerciseDataInputTableViewCell.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/5/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMExerciseDataInputTableViewCellDelegate <NSObject>

- (void)didEnterData:(NSArray *)dataEntered;

@end

@interface RMExerciseDataInputTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *numberOfRepsTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;

@property (weak, nonatomic) id <RMExerciseDataInputTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSArray *dataEntered;

@end
