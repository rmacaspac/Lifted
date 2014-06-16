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
        
//        //Fetching array from file system using Core Data
//        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
//        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sets" ascending:NO]];
//        
//        NSError *error = nil;
//        
//        NSArray *fetchedRoutines = [[RMCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//        
//        self.previousWeightLabel.text = [NSString stringWithFormat:@"%@", fetchedRoutines[0]];
//        
//        NSLog(@"data saved is %@", fetchedRoutines);
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
    NSLog(@"Text in text field is %@", self.numberOfRepsTextField.text);
    if (self.weightTextField.text.length > 0) {
        [self.delegate didEnterData:self.numberOfRepsTextField.text and:self.weightTextField.text];
    }
}


/*
- (IBAction)repNumberAdded:(UITextField *)sender
{
    if (self.numberOfRepsTextField.text.length > 0 && self.weightTextField.text.length > 0) {
        NSArray *repDataEntered = [[NSArray alloc] initWithObjects:self.numberOfRepsTextField.text, self.weightTextField.text, nil];
        [self.delegate didEnterData:repDataEntered];
    } else if ([self.numberOfRepsTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] != nil) {
        NSLog(@"nothing saved");
    }
}
 */


@end
