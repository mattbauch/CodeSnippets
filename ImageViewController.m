//
//  ImageViewController.m
//  GestureOnImageView
//
//  Created by Matthias Bauch on 12.10.10.
//  Copyright 2010 Matthias Bauch Engineering. All rights reserved.
//

#import "ImageViewController.h"


@implementation ImageViewController
@synthesize imagePath;

- (id)initWithImageDirectory:(NSString*)imgPath {
	if (self = [super init]) {
		imagePath = [imgPath copy];
	}
	return self;
}


- (UIView *)viewFullOfImagesAtPath:(NSString *)path withSize:(CGSize)size {
	NSError *error = nil;
	NSArray *filenames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
	if (!filenames) {
		NSLog(@"Error accessing files: %@ [%@]", [error localizedDescription], error);
		return nil;
	}
	UIView *aView = [[UIView alloc] init];
	CGFloat xOffset = 0;
	for (NSString *filename in filenames) {
		NSString *fullPath = [path stringByAppendingPathComponent:filename];
		UIImage *image = [[[UIImage alloc] initWithContentsOfFile:fullPath] autorelease];
		if (!image)
			continue;
		CGRect frameRect = CGRectMake(xOffset, 0, size.width, size.height);
		UIImageView *imageView = [[[UIImageView alloc] initWithFrame:frameRect] autorelease];
		[imageView setImage:image];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[aView addSubview:imageView];
		xOffset += size.width;
	}
	aView.frame = CGRectMake(0, 0, xOffset, size.height);
	return [aView autorelease];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
	scrollView.pagingEnabled = YES;
	UIView *contentView = [self viewFullOfImagesAtPath:imagePath withSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
	NSLog(@"%f %f %f %f", contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height);
	[scrollView addSubview:contentView];
	scrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
	[self.view addSubview:scrollView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imagePath release];
    [super dealloc];
}


@end