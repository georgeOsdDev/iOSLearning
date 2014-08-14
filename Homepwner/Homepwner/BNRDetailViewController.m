//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Oshida Takeharu on 8/8/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController ()
    <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *imagePickerPopOver;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@end

@implementation BNRDetailViewController

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
    
//    for (UIView *subView in self.view.subviews){
//        if ([subView hasAmbiguousLayout]) {
//            [subView exerciseAmbiguityInLayout];
//        }
//    }
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([self.imagePickerPopOver isPopoverVisible]) {
        [self.imagePickerPopOver dismissPopoverAnimated:YES];
        self.imagePickerPopOver = nil;
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    // Place image picker on the screen
    //[self presentViewController:imagePicker animated:YES completion:NULL];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
      
        self.imagePickerPopOver = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        self.imagePickerPopOver.delegate = self;
        
        [self.imagePickerPopOver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
    } else {
      [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    
}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    // Take imagePicker off the screen
//
    
    if (self.imagePickerPopOver) {
        // Dismiss it
        [self.imagePickerPopOver dismissPopoverAnimated:YES];
        self.imagePickerPopOver = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIInterfaceOrientation io =
        [[UIApplication sharedApplication] statusBarOrientation];
    
    [self prepareViewForOrientation:io];
    
    BNRItem *item = self.item;
    self.nameField.text         = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text        = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDateFormatter that will turn a date into a simple date dtring
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *key = self.item.itemKey;
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:key];
    
    self.imageView.image = imageToDisplay;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // Save changes to item
    BNRItem * item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void) setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (void)viewDidLayoutSubviews
//{
//    for (UIView *subView in self.view.subviews){
//        if ([subView hasAmbiguousLayout]) {
//            NSLog(@"Ambigous: %@", subView);
//        }
//    }
//}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIImageView *iview = [[UIImageView alloc] initWithImage:nil];
    
    iview.contentMode = UIViewContentModeScaleAspectFit;
    
    iview.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:iview];
    
    self.imageView = iview;
    
    [self.imageView setContentHuggingPriority:200
                                      forAxis:UILayoutConstraintAxisVertical];

    [self.imageView setContentCompressionResistancePriority:200
                                                    forAxis:UILayoutConstraintAxisVertical];

    
    NSDictionary *nameMap = @{@"imageView":self.imageView, @"dateLabel": self.dateLabel, @"toolBar":self.toolBar};
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolBar]"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];

    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void) prepareViewForOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    
    if (UIInterfaceOrientationIsLandscape(orientation)){
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self prepareViewForOrientation:toInterfaceOrientation];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    self.imagePickerPopOver = nil;
}

- (instancetype) initForNewItem:(BOOL)isNew{

    self = [super initWithNibName:nil bundle:nil];
    if (self){
        if (isNew){
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            
            self.navigationItem.leftBarButtonItem = cancelItem;
        }

    }
    
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    [NSException raise:@"Wrong initializer"
                format:@"Use initForNewItem"];
    return nil;
}

- (void) save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void) cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
    
    
    
}

@end
