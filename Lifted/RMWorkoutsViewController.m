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
#import "Routine.h"
#import "RMCoreDataHelper.h"


@interface RMWorkoutsViewController () <UITableViewDataSource, UITableViewDelegate, RMAddWorkoutViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *routineExercises;
@property (strong, nonatomic) NSDictionary *workoutObjects;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) RMWorkoutObject *workout;

@property (strong, nonatomic) IBOutlet UITableView *workoutsTableView;

@end

@implementation RMWorkoutsViewController

- (NSMutableArray *)routineExercises
{
    if (!_routineExercises) {
        _routineExercises = [[NSMutableArray alloc] init];
    }
    return _routineExercises;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self routineWithExercises];
    
    NSLog(@"Routine Info is %@", self.routineExercises);
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
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.routineExercises[indexPath.row][ROUTINE_NAME];
        }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"Add Workout";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.routineExercises count];
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
                workoutRoutineVC.routine = self.routineExercises[indexPath.row];
            }
        }
    }
}

#pragma mark - UIAddWorkoutViewController Delegate

- (void)didAddWorkout:(NSMutableArray *)routineObject
{
    // Adding workoutObject from addWorkoutViewController to workoutObjects
    self.routineExercises = routineObject;
    NSLog(@"new workout is %@", self.routineExercises);
    [self.workoutsTableView reloadData];
}

#pragma mark - Helper Method

- (NSDictionary *)workoutInfoAsPropertyLists:(RMWorkoutObject *)workout
{
    self.workoutObjects = @{WORKOUT_NAME: workout.workoutName, ROUTINE_EXERCISES: workout.workoutExercises};
    
    [self addedWorkoutObject];
    
    return self.workoutObjects;
    
}

- (RMWorkoutObject *)addedWorkoutObject
{
    RMWorkoutObject *workout = [[RMWorkoutObject alloc] init];
    workout.workoutName = [self.workoutObjects objectForKey:WORKOUT_NAME];
    workout.workoutExercises = [self.workoutObjects objectForKey:ROUTINE_EXERCISES];
    self.workout = workout;
    
    return self.workout;
}

- (NSMutableArray *)routineWithExercises
{
    // Querying Album object using Core Data
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Routine"];
    fetchRequest.resultType = NSDictionaryResultType;
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"routineName", @"routineExercises", nil]];
    
    NSError *error = nil;
    
    NSArray *routineWithExercises = [[RMCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.routineExercises = [routineWithExercises mutableCopy];
    
    return self.routineExercises;
}





@end
