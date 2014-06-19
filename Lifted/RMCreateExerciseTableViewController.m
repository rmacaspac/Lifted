//
//  RMCreateExerciseTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/17/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMCreateExerciseTableViewController.h"
#define REP_INITIAL_VALUE 4

@interface RMCreateExerciseTableViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *numberOfSetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *targetedMuscleLabel;

@property (strong, nonatomic) IBOutlet UIStepper *setsStepper;

@end

@implementation RMCreateExerciseTableViewController

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
    
    self.exerciseNameTextField.delegate = self;
    
    // Initial Setup
    self.numberOfSetsLabel.text = [NSString stringWithFormat:@"%i", 4];
    self.repMinLabel.text = [NSString stringWithFormat:@"%i", 6];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%i", 10];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)createBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.delegate didCreateWorkout:[self newExerciseObject]];
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

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else {
        return 2;
    }
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

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper Methods

- (RMExerciseObject *)newExerciseObject
{
    NSDictionary *exerciseDataAsPropertyLists = @{EXERCISE_NAME : self.exerciseNameTextField.text, EXERCISE_SETS : self.numberOfSetsLabel.text, EXERCISE_REP_MIN : self.repMinLabel.text, EXERCISE_REP_MAX : self.repMaxLabel.text};
    
    RMExerciseObject *newExerciseObject = [[RMExerciseObject alloc] initWithData:exerciseDataAsPropertyLists];
    
    return newExerciseObject;
}

@end
