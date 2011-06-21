//
//  CurrentAlbumsViewController.m
//  Album Club
//
//  Created by Cameron Cooke on 16/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrentAlbumsViewController.h"
#import "CJSONDeserializer.h"

@implementation CurrentAlbumsViewController
@synthesize tv;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/albumclub/current"]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTv:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [albums removeAllObjects];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error = nil;    
    albums = [[[CJSONDeserializer deserializer] deserialize:data error:&error] copy];
    NSLog(@"Dict: %@", albums);
    
    // Reload table view
    [tv reloadData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[connection release];
}

- (void)dealloc
{
    [tv release];
    [albums release];   
    [super dealloc];   
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[albums objectAtIndex:indexPath.row] valueForKey:@"albumTitle"];
    
    return cell;
}

@end
