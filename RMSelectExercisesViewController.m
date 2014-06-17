//
//  RMSelectExercisesViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMSelectExercisesViewController.h"
#import "RMExercisesData.h"

@interface RMSelectExercisesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) IBOutlet UITableView *exerciseTypeTableView;

@property (strong, nonatomic) NSMutableArray *exerciseObject;
@property (nonatomic) BOOL showAllTargeted;
@property (nonatomic) BOOL showAllExercises;


@end

@implementation RMSelectExercisesViewController

- (NSMutableArray *)exerciseObject
{
    if (!_exerciseObject) _exerciseObject = [[NSMutableArray alloc] init];
    return _exerciseObject;
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
    
    self.exercisesTableView.delegate = self;
    self.exercisesTableView.dataSource = self;
    self.exerciseTypeTableView.delegate = self;
    self.exerciseTypeTableView.dataSource = self;
    self.exerciseTypeTableView.frame = CGRectMake(0, 20, 320, 138);


    
    // Setting showAllTargeted and showAllExercises initial values to NO
    self.showAllTargeted = NO;
    self.showAllExercises = NO;
    
    // Enumerating through exerciseList in RMExercisesData for dictionary objects
    for (NSMutableDictionary *exercise in [RMExercisesData exerciseList]) {
        RMExerciseObject *exerciseObjects = [[RMExerciseObject alloc] initWithData:exercise];
        [self.exerciseObject addObject:exerciseObjects];
    }
    
    // Adding Header and Footer to exerciseTypeTableView
    UIView *exerciseHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 1, 1)];
    exerciseHeader.backgroundColor = [UIColor lightGrayColor];
    self.exercisesTableView.tableHeaderView = exerciseHeader;
    UIView *exerciseFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    exerciseFooter.backgroundColor = [UIColor lightGrayColor];
    self.exercisesTableView.tableFooterView = exerciseHeader;
    
    // Adding Header and Footer to exerciseTableView
    UIView *exerciseTypeFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    exerciseTypeFooter.backgroundColor = [UIColor lightGrayColor];
    self.exerciseTypeTableView.tableFooterView = exerciseTypeFooter;
    UIView *exerciseTypeHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 1, 1)];
    exerciseTypeHeader.backgroundColor = [UIColor lightGrayColor];
    self.exerciseTypeTableView.tableHeaderView = exerciseTypeHeader;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (tableView == self.exercisesTableView && indexPath.section == 0) {
        [cell.contentView bringSubviewToFront:self.exerciseTypeTableView];
        cell.textLabel.text = @"Select Exercise";
    } else if (tableView == self.exercisesTableView && indexPath.section == 1) {
        cell.textLabel.text = [self.exerciseObject valueForKey:EXERCISE_NAME][indexPath.row];
    } else if (tableView == self.exerciseTypeTableView && indexPath.section == 0) {
        cell.textLabel.text = @"Select Target Muscle";
    } else if (tableView == self.exerciseTypeTableView && indexPath.section == 1) {
        cell.textLabel.text = [RMExercisesData exerciseType][indexPath.row];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.exercisesTableView && section == 0) {
        return 1;
    } else if (tableView == self.exercisesTableView && section == 1) {
        // Adjusting number of rows in section 1 when showAllSections is changed
        if (!self.showAllExercises) {
            return 0;
        } else {
            return [self.exerciseObject count];
        }
        
    } else if (tableView == self.exerciseTypeTableView && section == 0) {
        return 1;
    } else if (tableView == self.exerciseTypeTableView && section == 1) {
        
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.exercisesTableView && indexPath.section == 1) {
        RMExerciseObject *exercise = self.exerciseObject[indexPath.row];
        [self.delegate didSelectExercise:exercise];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (tableView == self.exerciseTypeTableView && indexPath.section == 0) {
        
        // Changing section from showing one cell to multiple cells
        self.showAllTargeted = !self.showAllTargeted;
        [self.exerciseTypeTableView reloadData];

        // Adjusting frame origin when showAllTargeted changes
        if (self.showAllTargeted == YES) {
            CGFloat rowHeight = 51;
            CGFloat tableHeight = rowHeight * [[RMExercisesData exerciseType] count] + rowHeight;
            self.exerciseTypeTableView.frame = CGRectMake(0, 20, 320, tableHeight);
            self.exercisesTableView.frame = CGRectMake(0, 370, 320, 377);
        } else {
            self.exerciseTypeTableView.frame = CGRectMake(0, 20, 320, 138);
            self.exercisesTableView.frame = CGRectMake(0, 171, 320, 377);
        }
    } else if (tableView == self.exerciseTypeTableView && indexPath.section == 1) {
        if (self.showAllExercises == YES) {
            self.showAllTargeted = !self.showAllTargeted;
            [self.exerciseTypeTableView reloadData];
            self.exercisesTableView.frame = CGRectMake(0, 171, 320, 377);
        } else {
            self.showAllExercises = !self.showAllExercises;
            self.exercisesTableView.frame = CGRectMake(0, 171, 320, 377);
            [self.exercisesTableView reloadData];
            self.showAllTargeted = !self.showAllTargeted;
            [self.exerciseTypeTableView reloadData];
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
