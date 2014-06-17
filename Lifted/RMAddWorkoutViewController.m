//
//  RMAddWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMAddWorkoutViewController.h"
#import "RMSelectExercisesViewController.h"
#import "RMEditExerciseViewController.h"
#import "RMCoreDataHelper.h"
#import "RMExercisesData.h"

@interface RMAddWorkoutViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, RMEditExerciseViewControllerDelegate, RMSelectExercisesViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) IBOutlet UIButton *addWorkoutButton;

@end

@implementation RMAddWorkoutViewController

- (NSMutableArray *)exerciseData
{
    if (!_exerciseData) _exerciseData = [[NSMutableArray alloc] init];
    return _exerciseData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.exercisesTableView.delegate = self;
    self.exercisesTableView.dataSource = self;
    self.workoutNameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)finishButtonPressed:(UIButton *)sender
{
    if (self.workoutNameTextField.text.length == 0) {
        UIAlertView *routineNameAlert = [[UIAlertView alloc] initWithTitle:@"Routine Name" message:@"Please enter routine name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [routineNameAlert show];
    } else if ([self.exercisesTableView numberOfRowsInSection:0] == 0) {
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
    if ([segue.destinationViewController isKindOfClass:[RMSelectExercisesViewController class]]) {
        RMSelectExercisesViewController *selectExerciseVC = segue.destinationViewController;
        selectExerciseVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"exercisesToEditExercisesSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[RMEditExerciseViewController class]]) {
            RMEditExerciseViewController *editExerciseVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            editExerciseVC.selectedIndexPath = indexPath.row;
            editExerciseVC.selectedExercise = self.exerciseData[indexPath.row];
        }
    }
    if ([segue.destinationViewController isKindOfClass:[RMEditExerciseViewController class]]) {
        RMEditExerciseViewController *editExerciseVC = segue.destinationViewController;
        editExerciseVC.delegate = self;
    }
}



#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ([self.exerciseData count] > 0 && indexPath.section == 0) {
        RMExerciseObject *selectedExercise = self.exerciseData[indexPath.row];
        cell.textLabel.text = [selectedExercise valueForKey:@"exerciseName"];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else {
        cell.textLabel.text = @"Add Exercise";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return [self.exerciseData count];
    else return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"addWorkoutToSelectExerciseSegue" sender:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"exercisesToEditExercisesSegue" sender:indexPath];
}


#pragma mark - RMSelectExercisesViewController Delegate

- (void)didSelectExercise:(RMExerciseObject *)selectedExercise;
{
    // Adding selected exercise from SelectExerciseVC to exerciseData array and inserting the object to the tableview
    [self.exerciseData addObject:selectedExercise];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.exerciseData count] - 1 inSection:0];
    [self.exercisesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.exercisesTableView reloadData];
}

#pragma mark - RMEditExerciseViewController Delegate
- (void)didChangeData:(RMExerciseObject *)editedExerciseObject underIndexPath:(NSInteger)indexPathRow
{
    // Removing unedited object from exerciseData Array and tableview at indexPath selected by user
    [self.exerciseData removeObjectAtIndex:indexPathRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:0];
    [self.exercisesTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // Inserting new object to exerciseData Array and tableview at indexPath selected by user
    [self.exerciseData insertObject:editedExerciseObject atIndex:indexPathRow];
    [self.exercisesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.exercisesTableView reloadData];
}

#pragma mark - Helper Methods

- (void)saveRoutineWithExercises
{
    // Inserting new Routine object under Routine entity using Core Data.
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    self.routine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
    self.routine.name = self.workoutNameTextField.text;
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
        exercise.routine.name = self.workoutNameTextField.text;
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
