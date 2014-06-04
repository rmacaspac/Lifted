//
//  RMWorkoutsViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/31/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutsViewController.h"
#import "RMAddWorkoutViewController.h"
#import "RMWorkoutObject.h"
#import "RMWorkoutRoutineViewController.h"


@interface RMWorkoutsViewController () <UITableViewDataSource, UITableViewDelegate, RMAddWorkoutViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *workoutExercises;
@property (strong, nonatomic) NSDictionary *workoutObjects;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) RMWorkoutObject *workout;

@property (strong, nonatomic) IBOutlet UITableView *workoutsTableView;

@end

@implementation RMWorkoutsViewController

- (NSMutableArray *)workoutExercises
{
    if (!_workoutExercises) {
        _workoutExercises = [[NSMutableArray alloc] init];
    }
    return _workoutExercises;
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
    
    self.workoutsTableView.dataSource = self;
    self.workoutsTableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0 && [self.workoutExercises count] > 0) {
        cell.textLabel.text = self.workoutExercises[indexPath.row][WORKOUT_NAME];
        NSLog(@"Workout name is %@", self.workoutExercises[indexPath.row][WORKOUT_NAME]);
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"Add Workout";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.workoutExercises count];
    } else {
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"workoutsToRoutineSegue" sender:indexPath];
    } if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"workoutsToAddWorkoutSegue" sender:indexPath];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMAddWorkoutViewController class]]) {
        RMAddWorkoutViewController *addWorkoutVC = segue.destinationViewController;
        addWorkoutVC.delegate = self;
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.identifier isEqualToString:@"workoutsToRoutineSegue"]) {
            if ([segue.destinationViewController isKindOfClass:[RMWorkoutRoutineViewController class]]) {
                RMWorkoutRoutineViewController *workoutRoutineVC = segue.destinationViewController;
                NSIndexPath *indexPath = sender;
                RMWorkoutObject *workoutObject = self.workoutExercises[indexPath.row];
                workoutRoutineVC.workoutObject = workoutObject;
            }
        }
    }
}

#pragma mark - UIAddWorkoutViewController Delegate

- (void)didAddWorkout:(RMWorkoutObject *)workoutObject
{
    // Adding workoutObject from addWorkoutViewController to workoutObjects instance
    [self.workoutExercises addObject:[self workoutInfoAsPropertyLists:workoutObject]];
    
    NSLog(@"new workout is %@", self.workoutExercises);
    [self.workoutsTableView reloadData];
}

#pragma mark - Helper Method

- (NSDictionary *)workoutInfoAsPropertyLists:(RMWorkoutObject *)workout
{
    self.workoutObjects = @{WORKOUT_NAME: workout.workoutName, WORKOUT_EXERCISES: workout.workoutExercises};
    
    [self addedWorkoutObject];
    
    return self.workoutObjects;
    
}

- (RMWorkoutObject *)addedWorkoutObject
{
    RMWorkoutObject *workout = [[RMWorkoutObject alloc] init];
    workout.workoutName = [self.workoutObjects objectForKey:WORKOUT_NAME];
    workout.workoutExercises = [self.workoutObjects objectForKey:WORKOUT_EXERCISES];
    self.workout = workout;
    
    return self.workout;
}




@end
