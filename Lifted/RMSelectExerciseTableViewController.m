//
//  RMSelectExerciseTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/18/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMSelectExerciseTableViewController.h"
#import "RMCreateExerciseTableViewController.h"
#import "RMExercisesData.h"

@interface RMSelectExerciseTableViewController () <UITableViewDataSource, UITableViewDelegate, RMCreateExerciseTableViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) IBOutlet UITableView *exerciseTypeTableView;

@property (strong, nonatomic) NSMutableArray *targetMuscleData;
@property (strong, nonatomic) NSMutableArray *exerciseData;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic) BOOL showAllMuscles;
@property (nonatomic) BOOL showAllExercises;

@end

@implementation RMSelectExerciseTableViewController

- (NSMutableArray *)targetMuscleData
{
    if (!_targetMuscleData) {
        _targetMuscleData = [[NSMutableArray alloc] init];
    }
    return _targetMuscleData;
}

- (NSMutableArray *)exerciseData
{
    if (!_exerciseData) {
        _exerciseData = [[NSMutableArray alloc] init];
    }
    return _exerciseData;
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
    
    // Initial Setup
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    // Setting showAllTargeted, showAllExercises and selectedIndexPath initial values
    self.showAllMuscles = NO;
    self.showAllExercises = NO;
    self.selectedIndexPath = 0;
    
    // Enumerating through exerciseList in RMExercisesData for dictionary objects
    for (NSMutableDictionary *exercise in [RMExercisesData exerciseList]) {
        RMExerciseObject *exerciseObjects = [[RMExerciseObject alloc] initWithData:exercise];
        [self.exerciseData addObject:exerciseObjects];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RMCreateExerciseTableViewController class]]) {
        RMCreateExerciseTableViewController *createExerciseVC = segue.destinationViewController;
        createExerciseVC.delegate = self;
    }
}


#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = [[RMExercisesData muscleType] objectAtIndex:self.selectedIndexPath.row + 1];;
    } else if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = [self selectMuscleGroup][indexPath.row];
    } else if (indexPath.section == 2) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = @"Create New Exercise";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 3) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = [self.exerciseData valueForKey:EXERCISE_NAME][indexPath.row];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        // Adjusting number of rows in section 1 when showAllSections is changed
        if (!self.showAllMuscles) {
            return 0;
        } else {
            return [[RMExercisesData muscleType] count] - 1;
        }
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        // Adjusting number of rows in section 1 when showAllSections is changed
        if (!self.showAllExercises) {
            return 0;
        } else {
            return [self.exerciseData count];
        }
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // Changing section from showing one cell to multiple cells
        self.showAllMuscles = !self.showAllMuscles;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } else if (indexPath.section == 1) {
        // Getting the index path for the row selected
        self.selectedIndexPath = [self.tableView indexPathForSelectedRow];

        // Expanding or minimizing table view sections based other sections actions
        if (self.showAllExercises == YES) {
            self.showAllMuscles = !self.showAllMuscles;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            self.showAllExercises = !self.showAllExercises;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            self.showAllMuscles = !self.showAllMuscles;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"selectExerciseToCreateExerciseSegue" sender:indexPath];
        
    } else if (indexPath.section == 3) {
        RMExerciseObject *exercise = self.exerciseData[indexPath.row];
        [self.delegate didSelectExercise:exercise];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 55.0;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 38.0;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Select Muscle Group";
    } else {
        return @"List of Exercises";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    
    if (section == 0) {
        myLabel.frame = CGRectMake(18, 31, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    } else if (section == 2) {
        myLabel.frame = CGRectMake(18, 15, 320, 20);
        myLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    }
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

#pragma mark - UICreateWorkout Delegate

- (void)didCreateWorkout:(RMExerciseObject *)exerciseObject
{
    [self.exerciseData insertObject:exerciseObject atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - Helper Methods

- (NSArray *)selectMuscleGroup
{
    // Getting all objects from muscle type array from indexes 1 - 6
    NSArray *muscleGroup = [[NSArray alloc] init];
    muscleGroup = [[RMExercisesData muscleType] subarrayWithRange:NSMakeRange(1, [[RMExercisesData muscleType] count] - 1)];
    return muscleGroup;
}

@end
