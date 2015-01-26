//
//  MTBReportHoursViewController.m
//  MTB_hOurworld_iOS
//
//  Created by Keith Kyungsik Han on 6/14/13.
//  Copyright (c) 2013 HCI PSU. All rights reserved.
//

#import "MTBReportHoursViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MTBItem.h"
#import "JSON.h"

@interface MTBReportHoursViewController ()

@end

@implementation MTBReportHoursViewController

@synthesize note, addDateBtn, addHourBtn, chooseRecipientBtn, submitBtn, isProvider, isReceiver, mItem;
@synthesize satisfactionLabel, referenceLabel, satisfactionSwitch, referenceSwitch;

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
    // set delegate to note
    //note.delegate = self;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    NSLog(@"%ld", (long)mItem.mSvcCatID);
    NSLog(@"%ld", (long)mItem.mSvcID);
    
    // rounded corner
    addDateBtn.layer.cornerRadius = 5;
    addDateBtn.clipsToBounds = YES;
    
    addHourBtn.layer.cornerRadius = 5;
    addHourBtn.clipsToBounds = YES;
    
    chooseRecipientBtn.layer.cornerRadius = 5;
    chooseRecipientBtn.clipsToBounds = YES;
    
    // add borderline
    note.layer.borderColor = [[UIColor blackColor] CGColor];
    note.layer.borderWidth = 1.0f;
    
    // add a placeholder
    note.text = @"About recipient’s comments about promptness, quality, difficulty, etc. of the task";
    note.textColor = [UIColor lightGrayColor];
    
    // initialize "satisfaction" and "reference" to "T"
    satisfaction = @"T";
    reference = @"T";
    
    addDate = false;
    addHour = false;
    
    if ([isReceiver isEqualToString:@"F"]) {
        [satisfactionLabel setHidden:YES];
        [satisfactionSwitch setHidden:YES];
        [referenceLabel setHidden:YES];
        [referenceSwitch setHidden:YES];
    }
    else {
        [satisfactionLabel setHidden:NO];
        [satisfactionSwitch setHidden:NO];
        [referenceLabel setHidden:NO];
        [referenceSwitch setHidden:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"ReportHoursViewController";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)pressAddDateBtn:(id)sender {
    
    [ActionSheetDatePicker showPickerWithTitle:@"Select Date"
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                         
                                         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                        
                                         NSDate *completedDate = selectedDate;
                                         date = [dateFormatter stringFromDate:completedDate];
                                         
                                         [addDateBtn setTitle:[NSString stringWithFormat:@"%@", date] forState:UIControlStateNormal];
                                         
                                         addDate = true;

                                     }
                                    cancelBlock:^(ActionSheetDatePicker *picker) {
                                       
                                    }
                                    origin:sender];
    
    
}

-(IBAction)pressAddHourBtn:(id)sender {
    
    NSArray *hourArray = [NSArray arrayWithObjects:
                     @"15 mins", @"30 mins", @"45 mins", @"60 mins",
                     @"75 mins", @"90 mins", @"105 mins", @"120 mins",
                     @"135 mins", @"150 mins", @"165 mins", @"180 mins",
                     @"195 mins", @"210 mins", @"225 mins", @"240 mins",
                     @"255 mins", @"270 mins", @"285 mins", @"300 mins", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Hours"
                                            rows:hourArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           NSString *hourString = [NSString stringWithFormat:@"%@", selectedValue];
                                           [addHourBtn setTitle:hourString forState:UIControlStateNormal];
                                           
                                           if ([hourString isEqualToString:@"15 mins"]) {
                                               hour = @"0.15";
                                           }
                                           else if ([hourString isEqualToString:@"30 mins"]) {
                                               hour = @"0.30";
                                           }
                                           else if ([hourString isEqualToString:@"45 mins"]) {
                                               hour = @"0.45";
                                           }
                                           else if ([hourString isEqualToString:@"60 mins"]) {
                                               hour = @"1.00";
                                           }
                                           else if ([hourString isEqualToString:@"75 mins"]) {
                                               hour = @"1.15";
                                           }
                                           else if ([hourString isEqualToString:@"90 mins"]) {
                                               hour = @"1.30";
                                           }
                                           else if ([hourString isEqualToString:@"105 mins"]) {
                                               hour = @"1.45";
                                           }
                                           else if ([hourString isEqualToString:@"120 mins"]) {
                                               hour = @"2.00";
                                           }
                                           else if ([hourString isEqualToString:@"135 mins"]) {
                                               hour = @"2.15";
                                           }
                                           else if ([hourString isEqualToString:@"150 mins"]) {
                                               hour = @"2.30";
                                           }
                                           else if ([hourString isEqualToString:@"165 mins"]) {
                                               hour = @"2.45";
                                           }
                                           else if ([hourString isEqualToString:@"180 mins"]) {
                                               hour = @"3.00";
                                           }
                                           else if ([hourString isEqualToString:@"195 mins"]) {
                                               hour = @"3.15";
                                           }
                                           else if ([hourString isEqualToString:@"210 mins"]) {
                                               hour = @"3.30";
                                           }
                                           else if ([hourString isEqualToString:@"225 mins"]) {
                                               hour = @"3.45";
                                           }
                                           else if ([hourString isEqualToString:@"240 mins"]) {
                                               hour = @"4.00";
                                           }
                                           else if ([hourString isEqualToString:@"255 mins"]) {
                                               hour = @"4.15";
                                           }
                                           else if ([hourString isEqualToString:@"270 mins"]) {
                                               hour = @"4.30";
                                           }
                                           else if ([hourString isEqualToString:@"285 mins"]) {
                                               hour = @"4.45";
                                           }
                                           else if ([hourString isEqualToString:@"300 mins"]) {
                                               hour = @"5.00";
                                           }
                                           
                                           addHour = true;

                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

-(IBAction)pressSubmitBtn:(id)sender {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                message:@"Report hours?"
                                                delegate:self
                                                cancelButtonTitle:@"Report"
                                                otherButtonTitles:@"Cancel", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Report"]) {
        
        // check the fields first
        if (addDate != true || addHour != true) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Please fill out all fields"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Okay"
                                                    otherButtonTitles:nil, nil];
            [message show];
        }
        else {
            // start downloading
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *params;
            
            if([isProvider isEqualToString:@"T"]) {
                
                params = @{@"requestType"     :@"RecordHrs,0",
                           @"accessToken"     :[userDefault objectForKey:@"access_token"],
                           @"EID"             :[userDefault objectForKey:@"EID"],
                           @"memID"           :[userDefault objectForKey:@"memID"],
                           @"transDate"       :[NSString stringWithFormat:@"%@", date],
                           @"TDs"             :[NSString stringWithFormat:@"%@", hour],
                           @"transOrigin"     :[NSString stringWithFormat:@"M"],
                           @"transHappy"      :[NSString stringWithFormat:@"%@", satisfaction],
                           @"transRefer"      :[NSString stringWithFormat:@"%@", reference],
                           @"transNote"       :[NSString stringWithFormat:@"%@", note.text],
                           @"Provider"        :[NSString stringWithFormat:@"%@", [userDefault objectForKey:@"memID"]],
                           @"Receiver"        :[NSString stringWithFormat:@"%ld", (long)mItem.mListMbrID],
                           @"SvcCatID"        :[NSString stringWithFormat:@"%ld", (long)mItem.mSvcCatID],
                           @"SvcID"           :[NSString stringWithFormat:@"%ld", (long)mItem.mSvcID]};
                
            }
            else {
                params = @{@"requestType"     :@"RecordHrs,0",
                           @"accessToken"     :[userDefault objectForKey:@"access_token"],
                           @"EID"             :[userDefault objectForKey:@"EID"],
                           @"memID"           :[userDefault objectForKey:@"memID"],
                           @"transDate"       :[NSString stringWithFormat:@"%@", date],
                           @"TDs"             :[NSString stringWithFormat:@"%@", hour],
                           @"transOrigin"     :[NSString stringWithFormat:@"M"],
                           @"transHappy"      :[NSString stringWithFormat:@"%@", satisfaction],
                           @"transRefer"      :[NSString stringWithFormat:@"%@", reference],
                           @"transNote"       :[NSString stringWithFormat:@"%@", note.text],
                           @"Provider"        :[NSString stringWithFormat:@"%ld", (long)mItem.mListMbrID],
                           @"Receiver"        :[NSString stringWithFormat:@"%@", [userDefault objectForKey:@"memID"]],
                           @"SvcCatID"        :[NSString stringWithFormat:@"%ld", (long)mItem.mSvcCatID],
                           @"SvcID"           :[NSString stringWithFormat:@"%ld", (long)mItem.mSvcID]};
            }
            
            [manager POST:@"http://www.hourworld.org/db_mob/auth.php" parameters:params
                constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
                      if([responseObject objectForKey:@"success"]) {
                          NSLog(@"Complete reporting hour");
                          
                          UIAlertView *dialog = [[UIAlertView alloc]init];
                          [dialog setDelegate:self];
                          [dialog setTitle:@"Message"];
                          [dialog setMessage:@"Your hour has been reported"];
                          [dialog addButtonWithTitle:@"Close"];
                          [dialog show];
                          
                          NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                          [userDefault setInteger:1 forKey:@"reload"];
                          [self.navigationController popViewControllerAnimated:YES];
                      }
                      else {
                          NSLog(@"Fail to report hour");
                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", operation);
                  }];
        }
    }    
}

- (BOOL)textViewShouldReturn:(UITextField *)textView
{
    [textView resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [note endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"About recipient’s comments about promptness, quality, difficulty, etc. of the task"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"Report hours";
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    //self.navigationController.navigationBar.backItem.title = @"Back";
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    [super viewWillAppear:animated];
}

-(IBAction)satisfactionSwitchPressed:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        satisfaction = @"T";
    }
    else{
        satisfaction = @"F";
    }
}

-(IBAction)referenceSwitchPressed:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        reference = @"T";
    }
    else{
        reference = @"F";
    }
}

@end
