//
//  RMEditExerciseTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/17/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMEditExerciseTableViewController.h"

@interface RMEditExerciseTableViewController ()

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *targetedMuscleLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfSetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;


@end

@implementation RMEditExerciseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initial Setup
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.exerciseNameLabel.text = [self.selectedExercise valueForKey:@"name"];
    self.targetedMuscleLabel.text = [[self.muscle valueForKey:@"name"] objectAtIndex:0];
    self.numberOfSetsLabel.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_SETS]];
    self.repMinLabel.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_REP_MIN]];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_REP_MAX]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.delegate didChangeData:[self newExerciseObject] underIndexPath:self.selectedIndexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)setsStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 50;
    
    self.numberOfSetsLabel.text = [NSString stringWithFormat:@"%i", value];
}

- (IBAction)repMinStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 100;
    
    self.repMinLabel.text = [NSString stringWithFormat:@"%i", value];
}

- (IBAction)repMaxStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 100;
    
    self.repMaxLabel.text = [NSString stringWithFormat:@"%i", value];
}

#pragma mark - UITableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    
    if (section == 0) {
        myLabel.frame = CGRectMake(18, 25, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    } else {
        myLabel.frame = CGRectMake(18, 8, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    }
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

#pragma mark - Helper Methods

- (RMExerciseObject *)newExerciseObject
{
    NSDictionary *exerciseDataAsPropertyLists = @{EXERCISE_NAME : self.exerciseNameLabel.text, EXERCISE_MUSCLE_GROUP : [self.selectedExercise valueForKey:@"muscle"], EXERCISE_SETS : self.numberOfSetsLabel.text, EXERCISE_REP_MIN : self.repMinLabel.text, EXERCISE_REP_MAX : self.repMaxLabel.text};
    
    RMExerciseObject *newExerciseObject = [[RMExerciseObject alloc] initWithData:exerciseDataAsPropertyLists];
    
    return newExerciseObject;
}

@end
