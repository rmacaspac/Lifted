//
//  RMAddWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMAddWorkoutViewController.h"
#import "RMExerciseObject.h"
#import "RMSelectExercisesViewController.h"
#import "RMEditExerciseViewController.h"
#import "RMWorkoutObject.h"
#import "RMCoreDataHelper.h"



@interface RMAddWorkoutViewController () <UITableViewDataSource, UITableViewDelegate, RMSelectExercisesViewControllerDelegate, UITextFieldDelegate, RMEditExerciseViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *exerciseList;
@property (strong, nonatomic) RMExerciseObject *exerciseSelected;

@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) IBOutlet UIButton *addWorkoutButton;


@end

@implementation RMAddWorkoutViewController

- (NSMutableArray *)exerciseList
{
    if (!_exerciseList) {
        _exerciseList = [[NSMutableArray alloc] init];
    }
    return _exerciseList;
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMSelectExercisesViewController class]]) {
        RMSelectExercisesViewController *selectExerciseVC = segue.destinationViewController;
        selectExerciseVC.delegate = self;
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.identifier isEqualToString:@"addWorkoutToSelectExerciseSegue"]) {
            if ([segue.destinationViewController isKindOfClass:[RMSelectExercisesViewController class]]) {
                RMSelectExercisesViewController *selectExercisesVC = segue.destinationViewController;
            }
        }
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
    
    if ([self.exerciseList count] > 0 && indexPath.section == 0) {
        cell.textLabel.text = self.exerciseList[indexPath.row][WORKOUT_NAME];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Add Exercise";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return [self.exerciseList count];
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
    [self routineWithExercises:self.exerciseList];
    [self.delegate didAddWorkout:self.exerciseList];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (Routine *)routineWithExercises:(NSMutableArray *)exercises
{
    // Saving exercise name under routine using Core Data
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    Routine *routine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
    routine.routineName = self.workoutNameTextField.text;
    [routine.routineExercises setByAddingObjectsFromArray:exercises];
    
    NSError *error = nil;
    if (![[routine managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }

    return routine;
}

#pragma mark - RMSelectExercisesViewController Delegate

- (void)didSelectExercise:(Routine *)selectedExercise;
{
    [self.exerciseList addObject:selectedExercise];
    NSLog(@"Array with new exercise %@", self.exerciseList);
    [self.exercisesTableView reloadData];
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
//    self.exercises = editedExerciseObject;
//    NSLog(@"new exercise object is %@", self.exercises);
}




@end
