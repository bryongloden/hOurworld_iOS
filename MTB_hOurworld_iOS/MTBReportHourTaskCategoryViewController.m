//
//  MTBReportHourTaskCategoryViewController.m
//  MTB_hOurworld_iOS
//
//  Created by Kyungsik Han on 10/9/14.
//  Copyright (c) 2014 HCI PSU. All rights reserved.
//

#import "MTBReportHourTaskCategoryViewController.h"
#import "MTBReportHourTaskCategoryServiceViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "JSON.h"

@interface MTBReportHourTaskCategoryViewController ()

@end

@implementation MTBReportHourTaskCategoryViewController

@synthesize jsonArray, tableViewList;

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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self downloadContent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"MTBTaskCategoryViewController";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [jsonArray count];
}


// ref: http://www.colejoplin.com/2012/09/28/ios-tutorial-basics-of-table-views-and-prototype-cells-in-storyboards/
// ref2:http://www.appcoda.com/ios-programming-customize-uitableview-storyboard/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *categoryText = (UILabel *)[cell viewWithTag:100];
    
    // display category texts
    NSDictionary *item = [jsonArray objectAtIndex:indexPath.row];
    [categoryText setText:[NSString stringWithFormat:@"%@", [item objectForKey:@"SvcCat"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *item = [jsonArray objectAtIndex:indexPath.row];
    
    MTBReportHourTaskCategoryServiceViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTBReportHourTaskCategoryServiceViewController"];
    [viewController setSvcCat:[item objectForKey:@"SvcCat"]];
    [viewController setSvcCatID:[[item objectForKey:@"SvcCatID"] intValue]];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)updateTimeLine {
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"Pick_Category", nil)];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc]
                                      initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Back", nil)]
                                      style: UIBarButtonItemStyleBordered
                                      target:nil
                                      action:nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    [super viewWillAppear:animated];
    
}

- (void) downloadContent {
    // start downloading
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params;
    
    params = @{@"requestType"     :@"AddTask,CAT",
               @"accessToken"     :[userDefault objectForKey:@"access_token"],
               @"EID"             :[userDefault objectForKey:@"EID"],
               @"memID"           :[userDefault objectForKey:@"memID"]};

    
    [manager POST:@"http://www.hourworld.org/db_mob/auth.php" parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    jsonArray = [NSMutableArray arrayWithCapacity:0];

    [jsonArray addObjectsFromArray:[responseObject objectForKey:@"results"]];
    
    // sort the categoryList : http://stackoverflow.com/questions/805547/how-to-sort-an-nsmutablearray-with-custom-objects-in-it
    NSArray *sortedArray;
    sortedArray = [jsonArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [[a objectForKey:@"SvcCat"] compare:[b objectForKey:@"SvcCat"]];
    }];
    [jsonArray removeAllObjects];
    [jsonArray addObjectsFromArray:sortedArray];
    
    [tableViewList reloadData];
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", operation);
}];
}

- (void)addServiceViewController:(id)controller didFinishEnteringItem:(NSString *)SvcCat SvcCatID:(int)pSvcCatID Service:(NSString *)pService SvcID:(int)pSvcID {
    [self.delegate addCategoryViewController:self didFinishEnteringItem:SvcCat SvcCatID:pSvcCatID Service:pService SvcID:pSvcID];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
