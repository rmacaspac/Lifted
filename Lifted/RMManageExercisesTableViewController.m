//
//  RMManageExercisesTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/19/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMManageExercisesTableViewController.h"
#import "RMCreateExerciseTableViewController.h"
#import "RMExercisesData.h"
#import "RMManageMuscleGroupTableViewController.h"
#import "Muscle.h"

@interface RMManageExercisesTableViewController () <RMCreateExerciseTableViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *muscleGroups;
@property (strong, nonatomic) NSMutableArray *exerciseObject;
@end

@implementation RMManageExercisesTableViewController

-(NSMutableArray *)exerciseObject
{
    if (!_exerciseObject) {
        _exerciseObject = [[NSMutableArray alloc] init];
    }
    return _exerciseObject;
}

- (NSMutableArray *)muscleGroups
{
    if (!_muscleGroups) {
        _muscleGroups = [[NSMutableArray alloc] init];
    }
    return _muscleGroups;
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

    self.muscleGroups = [[[RMExercisesData muscleType] subarrayWithRange:NSMakeRange(1, [[RMExercisesData muscleType] count] - 1)] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Data Source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        cell.textLabel.text = @"Create New Exercise";
    } else if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        cell.textLabel.text = self.muscleGroups[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return [[RMExercisesData exerciseList] count] - 1;
    } else {
        return 1;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"manageToCreateSegue" sender:indexPath];
    } else if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"manageExerciseToManageMuscleSegue" sender:indexPath];
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
    if (section == 1) {
        return @"Muscle Groups";
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    
    if (section == 1) {
        myLabel.frame = CGRectMake(18, 14, 320, 20);
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
    if ([segue.destinationViewController isKindOfClass:[RMManageMuscleGroupTableViewController class]]) {
        if ([segue.identifier isEqualToString:@"manageExerciseToManageMuscleSegue"]) {
            RMManageMuscleGroupTableViewController *manageMuscleVC = segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            manageMuscleVC.muscleGroupName = self.muscleGroups[indexPath.row];
        }
    }
    
    if ([segue.destinationViewController isKindOfClass:[RMCreateExerciseTableViewController class]]) {
        if ([segue.identifier isEqualToString:@"manageToCreateSegue"]) {
            RMCreateExerciseTableViewController *createExerciseVC = segue.destinationViewController;
            createExerciseVC.muscleGroups = self.muscleGroups;
        }
    }
}

#pragma mark - RMCreateExerciseTableViewController Delegate

- (void)didCreateWorkout:(RMExerciseObject *)exerciseObject
{

}



@end
