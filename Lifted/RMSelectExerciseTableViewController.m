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

@property (strong, nonatomic) NSMutableArray *exerciseObject;
@property (nonatomic) BOOL showAllTargeted;
@property (nonatomic) BOOL showAllExercises;

@end

@implementation RMSelectExerciseTableViewController

- (NSMutableArray *)exerciseObject
{
    if (!_exerciseObject) _exerciseObject = [[NSMutableArray alloc] init];
    return _exerciseObject;
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

    // Setting showAllTargeted and showAllExercises initial values to NO
    self.showAllTargeted = NO;
    self.showAllExercises = NO;
    
    // Enumerating through exerciseList in RMExercisesData for dictionary objects
    for (NSMutableDictionary *exercise in [RMExercisesData exerciseList]) {
        RMExerciseObject *exerciseObjects = [[RMExerciseObject alloc] initWithData:exercise];
        [self.exerciseObject addObject:exerciseObjects];
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

        if (indexPath.section == 0) {
            cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
            cell.textLabel.text = @"Select Target Muscle";
        } else if (indexPath.section == 1) {
            cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
            cell.textLabel.text = [RMExercisesData exerciseType][indexPath.row];
        } else if (indexPath.section == 2) {
            cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
            cell.textLabel.text = @"Select Exercise";
        } else if (indexPath.section == 3) {
            cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
            cell.textLabel.text = [self.exerciseObject valueForKey:EXERCISE_NAME][indexPath.row];
        }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 3) {
        
        // Adjusting number of rows in section 1 when showAllSections is changed
        if (!self.showAllExercises) {
            return 0;
        } else {
            return [self.exerciseObject count];
        }
        
    } else if (section == 2) {
        return 1;
    } else if (section == 1) {
        
        // Adjusting number of rows in section 1 when showAllSections is changed
        if (!self.showAllTargeted) {
            return 0;
        } else {
            return [[RMExercisesData exerciseType] count];
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
        self.showAllTargeted = !self.showAllTargeted;
        [self.tableView reloadData];
        
    } else if (indexPath.section == 1) {
        if (self.showAllExercises == YES) {
            self.showAllTargeted = !self.showAllTargeted;
            [self.tableView reloadData];
        } else {
            self.showAllExercises = !self.showAllExercises;
            self.showAllTargeted = !self.showAllTargeted;
            [self.tableView reloadData];
        }
    } else if (indexPath.section == 2) {
        self.showAllExercises = !self.showAllExercises;
//        [self performSegueWithIdentifier:@"selectExerciseToCreateExerciseSegue" sender:indexPath];
        
    } else if (indexPath.section == 3) {
        RMExerciseObject *exercise = self.exerciseObject[indexPath.row];
        [self.delegate didSelectExercise:exercise];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didCreateWorkout:(RMExerciseObject *)exerciseObject
{
    NSLog(@"Exercise Object %@", exerciseObject);
}

@end
