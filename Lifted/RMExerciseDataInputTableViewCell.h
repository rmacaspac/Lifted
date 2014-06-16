//
//  RMExerciseDataInputTableViewCell.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/5/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "Sets.h"

@protocol RMExerciseDataInputTableViewCellDelegate <NSObject>

- (void)didEnterData:(NSString *)repEntered and:(NSString *)weightEntered;

@end

@interface RMExerciseDataInputTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *previousWeightLabel;
@property (strong, nonatomic) IBOutlet UITextField *numberOfRepsTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;

@property (weak, nonatomic) id <RMExerciseDataInputTableViewCellDelegate> delegate;

@property (strong, nonatomic) Exercise *exercise;
@property (strong, nonatomic) Sets *sets;
@property (strong, nonatomic) NSArray *dataEntered;

@end
