//
//  RMIndividualWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseDataInputViewController.h"
#import "RMExerciseDataInputTableViewCell.h"
#import "RMCoreDataHelper.h"

@interface RMExerciseDataInputViewController () <UITableViewDataSource, UITableViewDelegate, RMExerciseDataInputTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) Exercise *exercise;
@property (strong, nonatomic) Sets *sets;
@property (strong, nonatomic) NSArray *rowData;
@property (strong, nonatomic) NSMutableArray *workoutData;

@end

@implementation RMExerciseDataInputViewController


- (NSMutableArray *)workoutData
{
    if (!_workoutData) {
        _workoutData = [[NSMutableArray alloc] init];
    }
    return _workoutData;
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
    
    self.workoutTableView.dataSource = self;
    self.workoutTableView.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    self.exerciseNameLabel.text = [self.selectedExercise valueForKey:@"name"];
    self.repMinLabel.text = [NSString stringWithFormat:@"%@",[self.selectedExercise valueForKey:EXERCISE_REP_MIN]];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%@",[self.selectedExercise valueForKey:EXERCISE_REP_MAX]];
    
    NSLog(@"the exercises data for routine is %@", self.selectedExercise);
    

}

- (void)viewWillAppear:(BOOL)animated
{
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Set"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"exercise" ascending:NO]];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"repsAndWeightLifted" ascending:NO]];

    NSError *error = nil;
    
    NSArray *fetchedWorkoutData = [context executeFetchRequest:fetchRequest error:&error];
    
    self.workoutData = [fetchedWorkoutData mutableCopy];
    for (NSArray *rowData in [self.workoutData valueForKey:@"repsAndWeightLifted"]) {
        self.rowData = rowData;
    }
    
    
    NSLog(@"workout data on row is %@", self.rowData);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)finishBarButtonItemPressed:(UIBarButtonItem *)sender
{
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
//    Exercise *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
    
    NSError *error = nil;
    
//    if (![[exercise managedObjectContext] save:&error]) {
//        NSLog(@"%@", error);
//    }

    Sets *sets = [NSEntityDescription insertNewObjectForEntityForName:@"Set" inManagedObjectContext:context];
    sets.exercise.routine = self.selectedRoutine;
    sets.exercise = self.selectedExercise;
    sets.repsAndWeightLifted = self.workoutData;

    if (![[sets managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    RMExerciseDataInputTableViewCell *cell = [self.workoutTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
//    if (indexPath.section == 0 && [self.rowData count] > 0) {
////        cell.previousWeightLabel.text = [[[self.rowData valueForKey:@"repsAndWeightLifted"] objectAtIndex:0] objectAtIndex:0];
//        cell.exercise = self.selectedExercise;
//        cell.numberOfRepsTextField.text = nil;
//        cell.weightTextField.text = nil;
//    } else if (indexPath.section == 1) {
//        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
//        cell.textLabel.text = @"Add Set";
//    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[self.selectedExercise valueForKey:EXERCISE_SETS] integerValue];
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - RMExerciseDataInputTableViewCell Delegate

-(void)didEnterData:(NSString *)repEntered and:(NSString *)weightEntered
{
    self.rowData = [[NSArray alloc] initWithObjects:repEntered, weightEntered, nil];
    [self.workoutData addObject:self.rowData];
    NSLog(@"row data is %@", self.rowData);
    NSLog(@"workout data is %@", self.workoutData);
    
}

@end
