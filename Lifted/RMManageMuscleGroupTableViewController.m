//
//  RMManageMuscleGroupTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/19/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMManageMuscleGroupTableViewController.h"
#import "RMEditExerciseTableViewController.h"
#import "RMCoreDataHelper.h"

@interface RMManageMuscleGroupTableViewController () <RMEditExerciseTableViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *exercises;

@end

@implementation RMManageMuscleGroupTableViewController

- (NSMutableArray *)exercises
{
    if (!_exercises) {
        _exercises = [[NSMutableArray alloc] init];
    }
    return _exercises;
}

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
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"muscle.name == %@", self.muscleGroupName];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchedArray = [[RMCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.exercises = [fetchedArray mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return [self.exercises count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        cell.textLabel.text = self.muscleGroupName;
    } else if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        cell.textLabel.text = [self.exercises valueForKey:@"name"][indexPath.row];
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"muscleGroupToEditExercisesSegue" sender:indexPath];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 55.0;
    } else {
        return 38.0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Muscle Group";
    } else {
        return @"Exercises";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    
    if (section == 0) {
        myLabel.frame = CGRectMake(18, 31, 320, 20);
        myLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    } else if (section == 1) {
        myLabel.frame = CGRectMake(18, 15, 320, 20);
        myLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    }
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"muscleGroupToEditExercisesSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[RMEditExerciseTableViewController class]]) {
            RMEditExerciseTableViewController *editExerciseVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            editExerciseVC.selectedIndexPath = indexPath.row;
            editExerciseVC.selectedExercise = self.exercises[indexPath.row];
            editExerciseVC.muscle = [self.exercises valueForKey:@"muscle"];
        }
    }
    if ([segue.destinationViewController isKindOfClass:[RMEditExerciseTableViewController class]]) {
        RMEditExerciseTableViewController *editExerciseVC = segue.destinationViewController;
        editExerciseVC.delegate = self;
    }
}

#pragma mark - RMEditExerciseViewController Delegate
- (void)didChangeData:(RMExerciseObject *)editedExerciseObject underIndexPath:(NSInteger)indexPathRow
{
    // Removing unedited object from exerciseData Array and tableview at indexPath selected by user
    [self.exercises removeObjectAtIndex:indexPathRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:1];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // Inserting new object to exerciseData Array and tableview at indexPath selected by user
    [self.exercises insertObject:editedExerciseObject atIndex:indexPathRow];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}

@end
