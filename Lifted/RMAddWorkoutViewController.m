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

@interface RMAddWorkoutViewController () <UITableViewDataSource, UITableViewDelegate, RMSelectExercisesViewControllerDelegate, UITextFieldDelegate>

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
}


#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ([self.exerciseList count] > 0 && indexPath.section == 0) {
        cell.textLabel.text = self.exerciseList[indexPath.row][WORKOUT_NAME];
    } else if ([self.exerciseList count] == 0 && indexPath.section == 1) {
        cell.textLabel.text = @"Add Exercise";
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

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)finishButtonPressed:(UIButton *)sender
{
    [self.delegate didAddWorkout:[self workoutWithExercises]];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Helper Methods


- (RMWorkoutObject *)workoutWithExercises
{
    RMWorkoutObject *workout = [[RMWorkoutObject alloc] init];
    workout.workoutName = self.workoutNameTextField.text;
    workout.workoutExercises = self.exerciseList;
    
    return workout;
}



#pragma mark - RMSelectExercisesViewController Delegate

- (void)didSelectExercise:(NSMutableArray *)selectedExercise;
{
    [self.exerciseList addObject:selectedExercise];
    NSLog(@"exerciseList has %@ objects", self.exerciseList);
    [self.exercisesTableView reloadData];
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}






@end
