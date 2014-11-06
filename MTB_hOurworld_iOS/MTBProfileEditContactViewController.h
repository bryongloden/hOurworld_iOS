//
//  MTBProfileEditContactViewController.h
//  MTB_hOurworld_iOS
//
//  Created by Kyungsik Han on 9/18/14.
//  Copyright (c) 2014 HCI PSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBProfileEditContactViewController : UIViewController <UITextFieldDelegate> {

    IBOutlet UITextField *email1TextField;
    IBOutlet UITextField *mobileTextField;
    IBOutlet UITextField *homeTextField;
    IBOutlet UITextField *websiteTextField;
    
    IBOutlet UIButton *emailBtn;
    IBOutlet UIButton *mobileBtn;
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *websiteBtn;
    
    IBOutlet UIButton *emailDelBtn;
    IBOutlet UIButton *mobileDelBtn;
    IBOutlet UIButton *homeDelBtn;
    IBOutlet UIButton *websiteDelBtn;
    
    NSString *email1;
    NSString *home1;
    NSString *mobile;
    NSString *website;
}

@property (nonatomic, retain) IBOutlet UITextField *email1TextField;
@property (nonatomic, retain) IBOutlet UITextField *homeTextField;
@property (nonatomic, retain) IBOutlet UITextField *mobileTextField;
@property (nonatomic, retain) IBOutlet UITextField *websiteTextField;

@property (nonatomic, retain) IBOutlet UIButton *emailBtn;
@property (nonatomic, retain) IBOutlet UIButton *mobileBtn;
@property (nonatomic, retain) IBOutlet UIButton *homeBtn;
@property (nonatomic, retain) IBOutlet UIButton *websiteBtn;

@property (nonatomic, retain) IBOutlet UIButton *emailDelBtn;
@property (nonatomic, retain) IBOutlet UIButton *mobileDelBtn;
@property (nonatomic, retain) IBOutlet UIButton *homeDelBtn;
@property (nonatomic, retain) IBOutlet UIButton *websiteDelBtn;

@property (nonatomic, retain) NSString *email1;
@property (nonatomic, retain) NSString *home1;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *website;

-(IBAction)pressEmailBtn:(id)sender;
-(IBAction)pressMobileBtn:(id)sender;
-(IBAction)pressHomeBtn:(id)sender;
-(IBAction)pressWebsiteBtn:(id)sender;

-(IBAction)pressEmailDelBtn:(id)sender;
-(IBAction)pressMobileDelBtn:(id)sender;
-(IBAction)pressHomeDelBtn:(id)sender;
-(IBAction)pressWebsiteDelBtn:(id)sender;

@end
