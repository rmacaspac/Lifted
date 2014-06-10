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

@interface RMAddWorkoutViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, RMEditExerciseViewControllerDelegate, RMSelectExercisesViewControllerDelegate>

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
    
    [self saveRoutine];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMSelectExercisesViewController class]]) {
        RMSelectExercisesViewController *selectExerciseVC = segue.destinationViewController;
        selectExerciseVC.delegate = self;
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.identifier isEqualToString:@"exercisesToEditExercisesSegue"]) {
            if ([segue.destinationViewController isKindOfClass:[RMEditExerciseViewController class]]) {
                RMEditExerciseViewController *editExerciseVC = segue.destinationViewController;
                NSIndexPath *indexPath = sender;
                editExerciseVC.exerciseData = [RMExercisesData exerciseList][indexPath.row];
            }
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
        Exercise *selectedExercise = self.exerciseData[indexPath.row];
        cell.textLabel.text = selectedExercise.name;
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
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"addWorkoutToSelectExerciseSegue" sender:indexPath];
    } else {
        [self performSegueWithIdentifier:@"addWorkoutToSelectExerciseSegue" sender:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"exercisesToEditExercisesSegue" sender:indexPath];
}

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)finishButtonPressed:(UIButton *)sender
{
    [self.delegate didAddWorkout:self.routine];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RMSelectExercisesViewController Delegate

- (void)didSelectExercise:(NSMutableArray *)selectedExercise;
{
    [self.exerciseData addObject:[self saveSelectedExercise:selectedExercise]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.exerciseData count] - 1 inSection:0];
    [self.exercisesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"Array with new exercise %@", self.exerciseData);
    
}

#pragma mark - Helper Methods


- (Exercise *)saveSelectedExercise:(NSMutableArray *)selectedExercise
{
    // Saving exercise name under routine using Core Data
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    Exercise *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
    exercise.name = [NSString stringWithFormat:@"%@", [selectedExercise valueForKey:EXERCISE_NAME]];
    exercise.repMin = [NSString stringWithFormat:@"%@",[selectedExercise valueForKey:EXERCISE_REP_MIN]];
    exercise.repMax = [NSString stringWithFormat:@"%@",[selectedExercise valueForKey:EXERCISE_REP_MAX]];
    exercise.routineName = self.routine;
    exercise.routineName.name = self.workoutNameTextField.text;
    exercise.routineName.date = [NSDate date];
    
    NSError *error = nil;
    if (![[exercise managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    return exercise;
}


- (void)saveRoutine
{
    // Saving exercise name under routine using Core Data
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    self.routine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
    
    NSError *error = nil;
    if (![[self.routine managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
}


#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - RMEditExerciseViewController Delegate

- (void)didChangeData:(RMExerciseObject *)editedExerciseObject
{

}




@end
