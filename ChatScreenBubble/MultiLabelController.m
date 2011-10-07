//
//  MainViewController.m
//  ResizableAttributedLabel
//
//  Created by Chaitanya Gupta on 26/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiLabelController.h"
#import "BubbleMultiLabel.h"

#define MIN_WIDTH 100.0
#define X_PADDING 10.0
#define MAX_WIDTH (320.0 - (X_PADDING * 2))

#define PADDING_TOP 6.0
#define PADDING_LEFT 27.0
#define PADDING_BOTTOM 14.0
#define PADDING_RIGHT 27.0
#define PADDING_INTER 12.0

#define LEFTCAPWIDTH 32
#define TOPCAPHEIGHT 52


@implementation MultiLabelController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    labelWidth_ = MIN_WIDTH;
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, 320.0, 480.0)];
  UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0.0, 410.0, 320.0, 30.0)];
    
  slider.minimumValue = MIN_WIDTH;
  slider.maximumValue = MAX_WIDTH;
  [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  [view addSubview:slider];    
  [slider release];
  
    
    
  NSMutableArray *texts = [NSMutableArray arrayWithObjects:@"fooo",
                    @"foo bar baz",
                    @"blah agghh zzzzzh fdsfsdf fds 9650770584 fdsfds hfds ffdsfa hafd sfsd",
                    nil];
    
  UIFont *font = [UIFont systemFontOfSize:14.0];
  bubbleMultiLabel_ = [[BubbleMultiLabel alloc] initWithImageName:@"bubbleblue-retina.png" leftCapWidth:LEFTCAPWIDTH topCapHeight:TOPCAPHEIGHT];
  bubbleMultiLabel_.font = font;
  bubbleMultiLabel_.texts = texts;
  bubbleMultiLabel_.clipsToBounds = YES;
  [bubbleMultiLabel_ setPaddingTop:PADDING_TOP left:PADDING_LEFT bottom:PADDING_BOTTOM right:PADDING_RIGHT inter:PADDING_INTER ];
    
  CGSize size = [BubbleMultiLabel sizeForTexts:texts
                                      withFont:font
                             constrainedToSize:CGSizeMake(labelWidth_, 480.0) paddingTop:PADDING_TOP left:PADDING_LEFT bottom:PADDING_BOTTOM right:PADDING_RIGHT inter:PADDING_INTER];
    
  //bubbleMultiLabel_.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
  //bubbleMultiLabel_.center = CGPointMake(view.bounds.size.width/2, (view.bounds.origin.y + slider.frame.origin.y)/2);
  
  bubbleMultiLabel_.frame = CGRectMake(X_PADDING, 30.0, size.width, size.height);
  [view addSubview:bubbleMultiLabel_];
    
  //bubbleMultiLabel_.font = [UIFont systemFontOfSize:10.0];
  //[bubbleMultiLabel_ refreshViewWithCurrentContext];  
    
  [texts addObject:@"adding again"]; 
  [bubbleMultiLabel_ refreshViewWithCurrentContext];  
    
  [bubbleMultiLabel_ release];
  self.view = view;
    
  [view release];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)sliderValueChanged:(id)sender {
  UISlider *slider = (UISlider *)sender;
  labelWidth_ = slider.value;
  CGSize size = [BubbleMultiLabel sizeForTexts:bubbleMultiLabel_.texts
                                      withFont:bubbleMultiLabel_.font
                             constrainedToSize:CGSizeMake(labelWidth_, 480.0) paddingTop:PADDING_TOP left:PADDING_LEFT bottom:PADDING_BOTTOM right:PADDING_RIGHT inter:PADDING_INTER];
  //bubbleMultiLabel_.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
  bubbleMultiLabel_.frame = CGRectMake(10.0, 30.0, size.width, size.height);
}
@end
