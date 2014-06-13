//
//  RMExerciseDataInputTableViewCell.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/5/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseDataInputTableViewCell.h"
#import "RMCoreDataHelper.h"

@implementation RMExerciseDataInputTableViewCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

- (IBAction)repNumberAdded:(UITextField *)sender
{
    self.dataEntered = [[NSArray alloc] initWithObjects:self.numberOfRepsTextField.text, self.weightTextField.text, nil];
    NSLog(@"Rep number entered is %@ and added to array %@", self.numberOfRepsTextField.text, self.dataEntered);
    [self.delegate didEnterData:self.dataEntered];
}

- (IBAction)weightNumberAdded:(UITextField *)sender
{
    self.dataEntered = [[NSArray alloc] initWithObjects:self.numberOfRepsTextField.text, self.weightTextField.text, nil];
    NSLog(@"Weight number entered is %@ and added to array %@", self.weightTextField.text, self.dataEntered);
    [self.delegate didEnterData:self.dataEntered];
}



@end
