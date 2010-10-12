//
//  ImageViewController.h
//  GestureOnImageView
//
//  Created by Matthias Bauch on 12.10.10.
//  Copyright 2010 Matthias Bauch Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController {
	NSString *imagePath;
}
@property (nonatomic, copy) NSString *imagePath;
- (id)initWithImageDirectory:(NSString*)imgPath;
@end
