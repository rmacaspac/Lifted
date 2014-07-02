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
    self.workoutTableView.scrollEnabled = NO;
    
    self.exerciseNameLabel.text = [self.selectedExercise valueForKey:@"name"];
    self.repMinLabel.text = [NSString stringWithFormat:@"%@",[self.selectedExercise valueForKey:EXERCISE_REP_MIN]];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%@",[self.selectedExercise valueForKey:EXERCISE_REP_MAX]];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.workoutTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    UILabel *setLabel = [[UILabel alloc] init];
    setLabel.frame = CGRectMake(20, 157, 41, 13);
    setLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:12.0];
    setLabel.textColor = [UIColor blackColor];
    setLabel.text = @"Set";
    
    UILabel *repsLabel = [[UILabel alloc] init];
    repsLabel.frame = CGRectMake(120, 157, 41, 13);
    repsLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:12.0];
    repsLabel.textColor = [UIColor blackColor];
    repsLabel.text = @"Reps";
    
    UILabel *weightLabel = [[UILabel alloc] init];
    weightLabel.frame = CGRectMake(257, 157, 38, 13);
    weightLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:12.0];
    weightLabel.textColor = [UIColor blackColor];
    weightLabel.text = @"Weight";
    
    [self.view addSubview:setLabel];
    [self.view addSubview:repsLabel];
    [self.view addSubview:weightLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Fetching set data for selected exercise and putting it into workoutData array.
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Set"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exercise == %@", self.selectedExercise];
    [fetchRequest setPredicate:predicate];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"repsAndWeightLifted" ascending:NO]];
    
    NSError *error = nil;
    
    NSArray *fetchedWorkoutData = [context executeFetchRequest:fetchRequest error:&error];
    
    self.workoutData = [fetchedWorkoutData mutableCopy];
    
    // Adding Header and Footer to tableView
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 1, 1)];
	header.backgroundColor = [UIColor lightGrayColor];
    self.workoutTableView.tableHeaderView = header;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	footer.backgroundColor = [UIColor lightGrayColor];
	self.workoutTableView.tableFooterView = footer;
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
    
    // Fetching set data and assigning it to fetchedObject array
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Set"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exercise == %@", self.selectedExercise];
    [fetchRequest setPredicate:predicate];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"repsAndWeightLifted" ascending:NO]];
    
    NSError *error = nil;
    
    NSArray *fetchedObject = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    } else {
        
        // Inserting new object to managedObjectContext
        Sets *sets = [NSEntityDescription insertNewObjectForEntityForName:@"Set" inManagedObjectContext:context];
        sets.exercise = self.selectedExercise;
        sets.repsAndWeightLifted = self.workoutData;
        
        // Deleting previous set data from fetchedObject
        for (Sets *setToDelete in fetchedObject) {
            [context deleteObject:setToDelete];
        }
        // Saving changes to managedObjectContext
        if (![[sets managedObjectContext] save:&error]) {
            NSLog(@"%@", error);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    RMExerciseDataInputTableViewCell *cell = [self.workoutTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.numberOfRepsTextField.tag = indexPath.row;
    cell.weightTextField.tag = indexPath.row;
    
    if (indexPath.section == 0 && [self.workoutData count] > 0) {
        
//        for (int i = 0 ; i < [[self.selectedExercise valueForKey:EXERCISE_SETS] intValue]; i++) {
//            NSString *rowNumber = [NSString stringWithFormat:@"%i", i];
//            cell.setNumberLabel.text = rowNumber[indexPath.row];
//        }
        
        cell.previousRepsLabel.text = [[[[self.workoutData valueForKey:@"repsAndWeightLifted"] objectAtIndex:0] objectAtIndex:indexPath.row] objectAtIndex:0];
        cell.previousWeightLabel.text = [[[[self.workoutData valueForKey:@"repsAndWeightLifted"] objectAtIndex:0] objectAtIndex:indexPath.row] objectAtIndex:1];

    } else if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14.0];
        cell.textLabel.text = @"Add Set";
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        int row = [[self.selectedExercise valueForKey:EXERCISE_SETS] intValue];
        NSString *newRowString = [NSString stringWithFormat:@"%i", row + 1];
        [self newNumberOfSets:newRowString];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.workoutTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    int row = [[self.selectedExercise valueForKey:EXERCISE_SETS] intValue];
    NSString *newRowString = [NSString stringWithFormat:@"%i", row - 1];
    [self newNumberOfSets:newRowString];
    [self.workoutTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}


#pragma mark - RMExerciseDataInputTableViewCell Delegate

-(void)didEnterData:(NSString *)repEntered and:(NSString *)weightEntered atIndexPath:(int)row
{
    if ([self.workoutData count] > [[self.selectedExercise valueForKey:EXERCISE_SETS] integerValue] - 1) {
        self.rowData = [[NSArray alloc] initWithObjects:repEntered, weightEntered, nil];
        [self.workoutData replaceObjectAtIndex:row withObject:self.rowData];
    } else {
        self.rowData = [[NSArray alloc] initWithObjects:repEntered, weightEntered, nil];
        [self.workoutData insertObject:self.rowData atIndex:row];
    }
}

#pragma mark - Helper Method

- (void)newNumberOfSets:(NSString *)addedNumber
{
    NSManagedObjectContext *context = [RMCoreDataHelper managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    NSPredicate *exercisePredicate = [NSPredicate predicateWithFormat:@"name == %@", [self.selectedExercise valueForKey:@"name"]];
    [fetchRequest setPredicate:exercisePredicate];

    NSError *error = nil;
    
    NSArray *fetchedExercise = [context executeFetchRequest:fetchRequest error:&error];

    Exercise *exercise = [fetchedExercise objectAtIndex:0];
        exercise.name = self.selectedExercise.name;
        exercise.numberOfSets = [NSString stringWithFormat:@"%@", addedNumber];
    
    if (![context save:&error]) {
            NSLog(@"%@", error);
        }
}

- (void)tableViewHeight
{
    CGFloat cellHeight = self.workoutTableView.rowHeight;
    float height = cellHeight * 3;
    self.workoutTableView.clipsToBounds = YES;
    self.workoutTableView.frame = CGRectMake(22, 22, self.workoutTableView.frame.size.width, height);
}


@end
