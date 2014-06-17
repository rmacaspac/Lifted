//
//  RMExerciseDataInputTableViewCell.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/5/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseDataInputTableViewCell.h"

@implementation RMExerciseDataInputTableViewCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.numberOfRepsTextField.delegate = self;
    self.weightTextField.delegate = self;
}

#pragma mark - IBActions

- (IBAction)weightNumberAdded:(UITextField *)sender
{
    int row = self.weightTextField.tag;
    
    [self.delegate didEnterData:self.numberOfRepsTextField.text and:self.weightTextField.text atIndexPath:row];
}

- (IBAction)repsNumberAdded:(UITextField *)sender
{
    int row = self.numberOfRepsTextField.tag;
    
    [self.delegate didEnterData:self.numberOfRepsTextField.text and:self.weightTextField.text atIndexPath:row];
}


@end
