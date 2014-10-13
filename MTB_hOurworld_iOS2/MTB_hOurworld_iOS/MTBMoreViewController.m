//
//  MTBMoreViewController.m
//  MTB_hOurworld_iOS
//
//  Created by Keith Kyungsik Han on 7/2/13.
//  Copyright (c) 2013 HCI PSU. All rights reserved.
//

#import "MTBMoreViewController.h"
#import "MTBProfileViewController.h"
#import "MTBGroupViewController.h"
#import "MTBLoginViewController.h"
#import "MTBAbouthOurworldViewController.h"
#import "MTBAboutAppViewController.h"
#import "FirstViewController.h"

@interface MTBMoreViewController ()

@end

@implementation MTBMoreViewController
@synthesize profileBtn, aboutBtn, aboutAppBtn, shareBtn, updateBtn, logoutBtn, exclamationImage;

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"MoreViewController";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)profileBtnClicked:(id)sender {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    MTBProfileViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTBProfileViewController"];
    [viewController setMemID:[[userDefault objectForKey:@"memID"] intValue]];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)aboutBtnClicked:(id)sender {
    MTBAbouthOurworldViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTBAbouthOurworldViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)aboutAppBtnClicked:(id)sender {
    MTBAboutAppViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTBAboutAppViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)shareAppBtnClicked:(id)sender {
    NSString *emailTitle = @"Download the hOurworld mobile app now!";
    // Email Content
    //    NSString *messageBody = @"Here are the links to download either an Android or an iOS hOurworld app.\n\nAndroid : https://play.google.com/store/apps/details?id=edu.psu.ist.mtb_hourworld&hl=en \n\niOS : https://itunes.apple.com/us/app/hourworld/id671499452?mt=8 \n\n";
    
    NSString *messageBody = @"Hello,<br><br>I want to share this great hOurworld mobile app with you. Download the app now and earn an hour credit!<br><br>Are you an iOS user? Click <a href=\"https://itunes.apple.com/us/app/hourworld/id671499452?mt=8\">here</a> to download!<br><br>Are you an Android user? Click <a href=\"https://play.google.com/store/apps/details?id=edu.psu.ist.mtb_hourworld&hl=en\">here</a> to download! <br><br>If you're not a timebank member, go to the \"Join\" tab here: <a href=\"http://www.hourworld.org/\">www.hourworld.org</a> and select your nearest exchange. You must do this for the mobile app to work. Please be patient after signing up. The administrator will contact you to confirm your identity.";
    
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)updateBtnClicked:(id)sender {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:@"update"] == TRUE) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                          message:@"Update to the latest version?"
                                                         delegate:self
                                                cancelButtonTitle:@"Update"
                                                otherButtonTitles:@"Cancel", nil];
        [message show];
    }
    else {
        
    }
}


-(IBAction)logoutBtnClicked:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                      message:@"Proceed to logout?"
                                                     delegate:self
                                            cancelButtonTitle:@"Logout"
                                            otherButtonTitles:@"Cancel", nil];
    [message show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    // logging out
    if([title isEqualToString:@"Logout"])
    {
        // reset NSUserDefaults
        NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
        
        NSArray *viewControllers = [[self navigationController] viewControllers];
        for(int i=0 ; i<[viewControllers count] ; i++){
            
            id obj=[viewControllers objectAtIndex:i];
            
            NSLog(@"%@", [obj class]);
            
            if([obj isKindOfClass:[MTBLoginViewController class]]){
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
        
        MTBLoginViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTBLoginViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    else if([title isEqualToString:@"Update"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/app/hourworld"]];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.title = @"More menus";
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:@"update"] == TRUE) {
        [updateBtn setTitle:@"New version is available" forState:UIControlStateNormal];
        [exclamationImage setHidden:NO];
    }
    else {
        NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
        NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];
        
        [updateBtn setTitle:[NSString stringWithFormat:@"Version %@", build] forState:UIControlStateNormal];
        [exclamationImage setHidden:YES];
    }
    
    [super viewWillAppear:animated];
}

@end