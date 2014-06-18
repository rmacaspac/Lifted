//
//  RMAddWorkoutTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/18/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMAddWorkoutTableViewController.h"
#import "RMSelectExerciseTableViewController.h"
#import "RMEditExerciseTableViewController.h"
#import "RMCoreDataHelper.h"
#import "RMExercisesData.h"

@interface RMAddWorkoutTableViewController () <UITextFieldDelegate, UIAlertViewDelegate, RMEditExerciseTableViewControllerDelegate,RMSelectExercisesTableViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *routineNameTextField;
@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) IBOutlet UIButton *addWorkoutButton;

@end

@implementation RMAddWorkoutTableViewController

- (NSMutableArray *)exerciseData
{
    if (!_exerciseData) _exerciseData = [[NSMutableArray alloc] init];
    return _exerciseData;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.frame = CGRectMake(0, 0, 320, 528);
        [self.tableView reloadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.routineNameTextField = [[UITextField alloc] init];
    self.routineNameTextField.delegate = self;
    self.routineNameTextField.frame = CGRectMake(20, 2, 280, 40);
    self.routineNameTextField.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)finishBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if (self.routineNameTextField.text.length == 0) {
        UIAlertView *routineNameAlert = [[UIAlertView alloc] initWithTitle:@"Routine Name" message:@"Please enter routine name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [routineNameAlert show];
    } else if ([self.tableView numberOfRowsInSection:3] == 0) {
        UIAlertView *exerciseAlert = [[UIAlertView alloc] initWithTitle:@"Exercises" message:@"Please add exercise" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [exerciseAlert show];
    } else {
        [self saveRoutineWithExercises];
        [self.delegate didAddWorkout:self.routine];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMSelectExerciseTableViewController class]]) {
        RMSelectExerciseTableViewController *selectExerciseVC = segue.destinationViewController;
        selectExerciseVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"exercisesToEditExercisesSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[RMEditExerciseTableViewController class]]) {
            RMEditExerciseTableViewController *editExerciseVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            editExerciseVC.selectedIndexPath = indexPath.row;
            editExerciseVC.selectedExercise = self.exerciseData[indexPath.row];
        }
    }
    if ([segue.destinationViewController isKindOfClass:[RMEditExerciseTableViewController class]]) {
        RMEditExerciseTableViewController *editExerciseVC = segue.destinationViewController;
        editExerciseVC.delegate = self;
    }
}



#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.routineNameTextField];
    } else if ([self.exerciseData count] > 0 && indexPath.section == 2) {
        RMExerciseObject *selectedExercise = self.exerciseData[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = [selectedExercise valueForKey:@"exerciseName"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (![self.exerciseData count] && indexPath.section == 1){
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = @"Add Exercise";
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return [self.exerciseData count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"addWorkoutToSelectExerciseSegue" sender:indexPath];
    } else if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"exercisesToEditExercisesSegue" sender:indexPath];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1;
    } else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 55.0;
    } else if (section == 1) {
        return 38.0;
    } else {
        return 0.1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Routine Name";
    } else {
        return @"Exercise List";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    
    if (section == 0) {
        myLabel.frame = CGRectMake(18, 25, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    } else if (section == 1) {
        myLabel.frame = CGRectMake(18, 8, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    }
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

#pragma mark - RMSelectExercisesViewController Delegate

- (void)didSelectExercise:(RMExerciseObject *)selectedExercise;
{
    // Adding selected exercise from SelectExerciseVC to exerciseData array and inserting the object to the tableview
    [self.exerciseData addObject:selectedExercise];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.exerciseData count] - 1 inSection:2];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView reloadData];
}

#pragma mark - RMEditExerciseViewController Delegate
- (void)didChangeData:(RMExerciseObject *)editedExerciseObject underIndexPath:(NSInteger)indexPathRow
{
    // Removing unedited object from exerciseData Array and tableview at indexPath selected by user
    [self.exerciseData removeObjectAtIndex:indexPathRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:2];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // Inserting new object to exerciseData Array and tableview at indexPath selected by user
    [self.exerciseData insertObject:editedExerciseObject atIndex:indexPathRow];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

- (void)saveRoutineWithExercises
{
    // Inserting new Routine object under Routine entity using Core Data.
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    self.routine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
    self.routine.name = self.routineNameTextField.text;
    self.routine.date = [NSDate date];
    
    NSError *error = nil;
    if (![[self.routine managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    
    // Enumerating though exercise objects added to tableview and inserting each object under Exercise entity
    for (Exercise *exerciseInfo in self.exerciseData) {
        // Saving exercise name under routine using Core Data
        NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
        
        Exercise *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        exercise.name = [NSString stringWithFormat:@"%@", [exerciseInfo valueForKey:EXERCISE_NAME]];
        exercise.repMin = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_REP_MIN]];
        exercise.repMax = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_REP_MAX]];
        exercise.numberOfSets = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_SETS]];
        exercise.routine = self.routine;
        exercise.routine.name = self.routineNameTextField.text;
        exercise.routine.date = [NSDate date];
        
        NSError *error = nil;
        if (![[exercise managedObjectContext] save:&error]) {
            NSLog(@"%@", error);
        }
    }
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
