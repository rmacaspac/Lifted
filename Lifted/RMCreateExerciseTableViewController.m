//
//  RMCreateExerciseTableViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/17/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMCreateExerciseTableViewController.h"
#import "RMCoreDataHelper.h"
#import "Muscle.h"
#import "Exercise.h"

@interface RMCreateExerciseTableViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *numberOfSetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

@property (nonatomic) BOOL showAllMuscles;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) NSMutableArray *exerciseObject;
@property (strong, nonatomic) Muscle *muscle;

@end

@implementation RMCreateExerciseTableViewController

- (NSMutableArray *)exerciseObject
{
    if (!_exerciseObject) {
        _exerciseObject = [[NSMutableArray alloc] init];
    }
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
    
    self.showAllMuscles = NO;
    
    // Initial Setup
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

    // Exercise Name Text Field Setup
    self.exerciseNameTextField = [[UITextField alloc] init];
    self.exerciseNameTextField.delegate = self;
    self.exerciseNameTextField.frame = CGRectMake(20, 2, 280, 40);
    self.exerciseNameTextField.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
    self.exerciseNameTextField.placeholder = @"Example: Chest";
    self.exerciseNameTextField.enablesReturnKeyAutomatically = YES;
    self.exerciseNameTextField.returnKeyType = UIReturnKeyDone;
    
    // Label Setup
    self.numberOfSetsLabel = [[UILabel alloc] init];
    self.numberOfSetsLabel.frame = CGRectMake(70, 12, 120, 21);
    self.numberOfSetsLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
    self.numberOfSetsLabel.text = [NSString stringWithFormat:@"%i", 4];
    
    self.repMinLabel = [[UILabel alloc] init];
    self.repMinLabel.frame = CGRectMake(70, 12, 120, 21);
    self.repMinLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
    self.repMinLabel.text = [NSString stringWithFormat:@"%i", 6];
    
    self.repMaxLabel = [[UILabel alloc] init];
    self.repMaxLabel.frame = CGRectMake(70, 12, 120, 21);
    self.repMaxLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%i", 10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)createBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.exerciseObject addObject:[self newExerciseObject]];
    NSString *muscleName = [self.muscleGroups objectAtIndex:self.selectedIndexPath.row];
    
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    
    self.muscle = [NSEntityDescription insertNewObjectForEntityForName:@"Muscle" inManagedObjectContext:context];
    self.muscle.name = muscleName;
    
    NSError *error = nil;
    
    if (![[self.muscle managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    
    // Enumerating though exercise objects added to tableview and inserting each object under Exercise entity
    for (Exercise *exerciseInfo in self.exerciseObject) {
        // Saving exercise name under routine using Core Data
        NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
        
        Exercise *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        exercise.name = [NSString stringWithFormat:@"%@", [exerciseInfo valueForKey:EXERCISE_NAME]];
        exercise.repMin = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_REP_MIN]];
        exercise.repMax = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_REP_MAX]];
        exercise.numberOfSets = [NSString stringWithFormat:@"%@",[exerciseInfo valueForKey:EXERCISE_SETS]];
        exercise.muscle = self.muscle;
        
        if (![[exercise managedObjectContext] save:&error]) {
            NSLog(@"%@", error);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)setsStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 50;
    
    self.numberOfSetsLabel.text = [NSString stringWithFormat:@"%i", value];
}

- (IBAction)repMinStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 100;

    self.repMinLabel.text = [NSString stringWithFormat:@"%i", value];
}

- (IBAction)repMaxStepperPressed:(UIStepper *)sender
{
    int value = [sender value];
    sender.minimumValue = 1;
    sender.maximumValue = 100;
    
    self.repMaxLabel.text = [NSString stringWithFormat:@"%i", value];
}

#pragma mark - UITableView Data Source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  
    self.stepper = [[UIStepper alloc] init];
    self.stepper.frame = CGRectMake(206, 6, 94, 29);
    self.stepper.tintColor = [UIColor colorWithRed:153/255.0 green:10/255.0 blue:10/255.0 alpha:1.0];
    
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.exerciseNameTextField];
    } else if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        if (!self.showAllMuscles) {
            cell.textLabel.text = [self.muscleGroups objectAtIndex:self.selectedIndexPath.row];
        } else {
            cell.textLabel.text = self.muscleGroups[indexPath.row];
        }
    } else if (indexPath.section == 2) {
        UILabel *setsLabel = [[UILabel alloc] init];
        setsLabel.frame = CGRectMake(20, 12, 120, 21);
        setsLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        setsLabel.text = @"Sets";
        
        [cell.contentView addSubview:setsLabel];
        [cell.contentView addSubview:self.numberOfSetsLabel];
        [cell.contentView addSubview:self.stepper];
        [self.stepper addTarget:self action:@selector(setsStepperPressed:) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            UILabel *minLabel = [[UILabel alloc] init];
            minLabel.frame = CGRectMake(20, 12, 120, 21);
            minLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
            minLabel.text = @"Min:";
            
            [cell.contentView addSubview:minLabel];
            [cell.contentView addSubview:self.repMinLabel];
            [cell.contentView addSubview:self.stepper];
            [self.stepper addTarget:self action:@selector(repMinStepperPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            UILabel *maxLabel = [[UILabel alloc] init];
            maxLabel.frame = CGRectMake(20, 12, 120, 21);
            maxLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
            maxLabel.text = @"Max:";
            
            [cell.contentView addSubview:maxLabel];
            [cell.contentView addSubview:self.repMaxLabel];
            [cell.contentView addSubview:self.stepper];
            [self.stepper addTarget:self action:@selector(repMaxStepperPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}
 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (!self.showAllMuscles) {
            return 1;
        } else {
            return [self.muscleGroups count];
        }
    } else if (section == 2) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (!self.showAllMuscles) {
            self.showAllMuscles = !self.showAllMuscles;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            self.selectedIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:1];
            NSLog(@"Selected muscle is %@", [self.muscleGroups objectAtIndex:self.selectedIndexPath.row]);
            self.showAllMuscles = !self.showAllMuscles;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
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
        return @"Exercise Name";
    } else if (section == 1) {
        return @"Muscle Group";
    } else if (section == 0) {
        return @"Number of Reps";
    } else {
        return @"Rep Range";
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
    } else {
        myLabel.frame = CGRectMake(18, 15, 320, 20);
        myLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        myLabel.textColor = [UIColor blackColor];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    }
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper Methods

- (RMExerciseObject *)newExerciseObject
{
    NSDictionary *exerciseDataAsPropertyLists = @{EXERCISE_NAME : self.exerciseNameTextField.text, EXERCISE_SETS : self.numberOfSetsLabel.text, EXERCISE_REP_MIN : self.repMinLabel.text, EXERCISE_REP_MAX : self.repMaxLabel.text};
    
    RMExerciseObject *newExerciseObject = [[RMExerciseObject alloc] initWithData:exerciseDataAsPropertyLists];
    
    return newExerciseObject;
}

@end
