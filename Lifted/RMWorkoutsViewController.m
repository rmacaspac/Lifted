//
//  RMWorkoutsViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/31/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutsViewController.h"
#import "RMAddWorkoutViewController.h"
#import "RMWorkoutRoutineViewController.h"
#import "Routine.h"
#import "RMCoreDataHelper.h"


@interface RMWorkoutsViewController () <UITableViewDataSource, UITableViewDelegate, RMAddWorkoutViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *routineExercises;

@property (strong, nonatomic) NSString *workoutName;
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
    [self fetchRoutine];
    
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
    
    if ([self.routineExercises count] > 0 && indexPath.section == 0) {
        cell.textLabel.text = [self.routineExercises[indexPath.row] valueForKey:@"name"];
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
                NSIndexPath *indexPath = [self.workoutsTableView indexPathForSelectedRow];
                workoutRoutineVC.routine = self.routineExercises[indexPath.row];
            }
        }
    }
}

#pragma mark - UIAddWorkoutViewController Delegate

- (void)didAddWorkout:(Routine *)exerciseData;
{
    [self.routineExercises addObject:exerciseData];
}

#pragma mark - Helper Methods


- (void)fetchRoutine
{
    // Querying Album object using Core Data
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Routine"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError *error = nil;
    
    NSArray *fetchedRoutines = [[RMCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.routineExercises = [fetchedRoutines mutableCopy];
    
    [self.workoutsTableView reloadData];
}







@end
