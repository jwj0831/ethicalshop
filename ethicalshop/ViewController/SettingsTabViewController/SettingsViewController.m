//
//  SettingsViewController.m
//  EthicalShop
//
//  Created by Woojin Joe on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AccountModifyViewController.h"
#import "ESGuideViewController.h"
#import "DonationGuideViewController.h"
#import "SharingVisionViewController.h"

@implementation SettingsViewController

@synthesize settingTable;

#pragma mark - View Initialize

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"설정";
        self.navigationItem.title = @"설정";
        self.tabBarItem.image = [UIImage imageNamed:@"ES_all_tabicon_setting"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settingTable.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSettingTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [settingTable reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{    
    [settingTable release];
    [super dealloc];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 1;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"닉네임";
        case 1:
            return @"알림";
        case 2:
            return @"프로그램 정보";
        default:
            return @"";
    } 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:               
            cell.textLabel.text = [[UserObject sharedUserData] nickName];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            return cell;        
        case 1:            
            if(indexPath.row == 0)
                cell.textLabel.text = @"착한가게란?";
            else if(indexPath.row == 1)
                cell.textLabel.text = @"기부대상은?";
            else if (indexPath.row == 2)
                cell.textLabel.text = @"꿈을 나누기";
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            return cell;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"버전정보   %@", PRGRAMVERSION];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            if([NetworkReachability connectedToNetwork] == 0 || [UserObject userFileIsIn] == NO ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"설정 변경 불가" message:@"네트워크 문제이거나 로그인되어 있지 않아 닉네임을 변경할 수 없습니다." delegate:self    cancelButtonTitle:@"확인" otherButtonTitles:nil];
                [alert show];
                [alert release];
                break;
            }
            AccountModifyViewController *detailViewController = [[AccountModifyViewController alloc] initWithNibName:@"AccountModifyViewController" bundle:nil];
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];
        }
            break;
        case 1:
            if(indexPath.row == 0) {
                ESGuideViewController *detailViewController = [[ESGuideViewController alloc] initWithNibName:@"ESGuideViewController" bundle:nil];
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }                
            else if(indexPath.row == 1) {
                DonationGuideViewController *detailViewController = [[DonationGuideViewController alloc] initWithNibName:@"DonationGuideViewController" bundle:nil];
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];                
            }            
            else if (indexPath.row == 2) {
                SharingVisionViewController *detailViewController = [[SharingVisionViewController alloc] initWithNibName:@"SharingVisionViewController" bundle:nil];
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }
            break;
        case 2:
            break;           
    }
}

@end

