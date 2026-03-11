//
//  POPDViewController.m
//  popdowntable
//
//  Created by Alex Di Mango on 15/09/2013.
//  Copyright (c) 2013 Alex Di Mango. All rights reserved.
//

#import "POPDViewController.h"
#import "POPDSectionTableViewCell.h"

#define TABLECOLOR [UIColor groupTableViewBackgroundColor]
#define CELLSELECTED [UIColor lightGrayColor]
#define TEXT [UIColor darkGrayColor]

//static NSString *kheader = @"menuSectionHeader";
//static NSString *ksubSection = @"menuSubSection";

@interface POPDViewController ()
@property NSArray *sections;
@property (strong, nonatomic) NSMutableArray *sectionsArray;
@property (strong, nonatomic) NSMutableArray *showingArray;
@end


@implementation POPDViewController
@synthesize delegate;

- (id)initWithMenuSections:(NSArray *) menuSections
{
    self = [super init];
    if (self) {
        self.sections = menuSections;
    }
	_RowHeight = 64;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.backgroundColor = TABLECOLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.tableView.frame = self.view.frame;

    self.sectionsArray = [NSMutableArray new];
    self.showingArray = [NSMutableArray new];
   [self setMenuSections:self.sections];
    
}

- (void)setMenuSections:(NSArray *)menuSections{
    
    for (NSDictionary *sec in menuSections) {
        
        NSString *header = [sec objectForKey:kheader];
        NSArray *subSection = [sec objectForKey:ksubSection];

        NSMutableArray *section = [NSMutableArray new];
        [section addObject:header];
        
        for (NSString *sub in subSection) {
            [section addObject:sub];
        }
        [self.sectionsArray addObject:section];
        [self.showingArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (![[self.showingArray objectAtIndex:section] boolValue]) {
        return 1;
    }
    else{
        return [[self.sectionsArray objectAtIndex:section] count];;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return _RowHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 0)
	{
    	if ([[self.showingArray objectAtIndex:indexPath.section] boolValue]) {
        	[cell setBackgroundColor:CELLSELECTED];
	    } else {
    	    [cell setBackgroundColor:[UIColor clearColor]];
	    }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDChild = @"menuCellChild";
	static NSString *cellIDSection = @"menuCellSection";
	
	UITableViewCell * cell;
	
	if (indexPath.row == 0)
	{
		cell = (POPDSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIDSection];
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"POPDSectionTableViewCell" owner:self options:nil];
		
		if (cell == nil) {
			cell = [topLevelObjects objectAtIndex:0];
		}
		
		// check expand state
		if ([[self.showingArray objectAtIndex:indexPath.section] boolValue])
		{
			[(POPDSectionTableViewCell *)cell expand];
		}
		else
		{
			[(POPDSectionTableViewCell *)cell collapse];
		}
	}
	else
	{
	 	cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIDChild];
		if (cell == nil)
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDChild];
		}
	}
	
	
//    cell.labelText.text = [[self.sectionsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    cell.labelText.textColor = TEXT;
//    cell.separator.backgroundColor = SEPARATOR;
//    cell.sepShadow.backgroundColor = SEPSHADOW;
//    cell.shadow.backgroundColor = SHADOW;

	cell.textLabel.textColor = TEXT;
	cell.textLabel.text = [[self.sectionsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[self.showingArray objectAtIndex:indexPath.section]boolValue])
	{
        [self.showingArray setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:indexPath.section];
    }
	else
	{
        [self.showingArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:indexPath.section];
    }
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
	
	

    [self.delegate didSelectRowAtIndexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
