//
//  ScanViewController.m
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@property (strong, nonatomic) AVCaptureDevice* device;
@property (strong, nonatomic) AVCaptureDeviceInput* input;
@property (strong, nonatomic) AVCaptureMetadataOutput* output;
@property (strong, nonatomic) AVCaptureSession* session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* preview;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
    // Do any additional setup after loading the view.
    if([self isCameraAvailable]) {
        [self setupScanner];
    }
    [self startScanning];
    
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    if(![self isCameraAvailable]) {
        [self setupNoCameraView];
    }
}

- (void) viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
    NSLog(@"ContentView2: %fx%f",self.contentView.frame.size.width, self.contentView.frame.size.height);
    NSLog(@"ContentView2: %fx%f",self.contentView.frame.size.width, self.contentView.frame.size.height);

    NSLog(@"View2: %fx%f",self.view.frame.size.width, self.view.frame.size.height);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupButton{
    [self.cancelButton addTarget:self action:@selector(toMainViewController:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)evt
{
    NSLog(@"Touch Focus: %i",self.touchToFocusEnabled);
    if(self.touchToFocusEnabled) {
        UITouch *touch=[touches anyObject];
        CGPoint pt= [touch locationInView:self.cameraView];
        [self focus:pt];
    }
}

#pragma mark -
#pragma mark AVFoundationSetup

- (void) setupScanner;
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.session = [[AVCaptureSession alloc] init];
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:self.output];
    [self.session addInput:self.input];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0
                                    , self.view.frame.size.width, self.view.frame.size.height-150);
    AVCaptureConnection *con = self.preview.connection;
    
    con.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [self.cameraView.layer insertSublayer:self.preview atIndex:1];
}

#pragma mark -
#pragma mark NoCamAvailable

- (void) setupNoCameraView;
{
    UILabel *labelNoCam = [[UILabel alloc] init];
    labelNoCam.text = @"No Camera available";
    labelNoCam.textColor = [UIColor whiteColor];
    [self.contentView addSubview:labelNoCam];
    [labelNoCam sizeToFit];
    labelNoCam.center = self.contentView.center;
}


#pragma mark -
#pragma mark Helper Methods

- (BOOL) isCameraAvailable;
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] > 0;
}

- (void)startScanning;
{
    NSLog(@"Start Scanning");
    [self.session startRunning];
    
}

- (void) stopScanning;
{
    NSLog(@"Stop Scanning");
    [self.session stopRunning];
}

- (void) setTorch:(BOOL) aStatus;
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if ( [device hasTorch] ) {
        if ( aStatus ) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
    }
    [device unlockForConfiguration];
}

- (void) focus:(CGPoint) aPoint;
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isFocusPointOfInterestSupported] &&
       [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        double screenWidth = screenRect.size.width;
        double screenHeight = screenRect.size.height;
        double focus_x = aPoint.x/screenWidth;
        double focus_y = aPoint.y/screenHeight;
        if([device lockForConfiguration:nil]) {
            if([self.delegate respondsToSelector:@selector(scanViewController:didTapToFocusOnPoint:)]) {
                [self.delegate scanViewController:self didTapToFocusOnPoint:aPoint];
            }
            [device setFocusPointOfInterest:CGPointMake(focus_x,focus_y)];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]){
                [device setExposureMode:AVCaptureExposureModeAutoExpose];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"Try Capturing");
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            AVMetadataMachineReadableCodeObject *transformed = (AVMetadataMachineReadableCodeObject *)metadata;
            // Update the view with the decoded text
            NSLog(@"Scan Value Capture:%@",[transformed stringValue]);
            NSString *scannedString = [transformed stringValue];
            [self scanViewController:self didSuccessfullyScan:scannedString];
            
            
        }
    }

}

- (void) scanViewController:(ScanViewController *) aCtler didSuccessfullyScan:(NSString *) aScannedValue{
    NSLog(@"Scan Value:%@",aScannedValue);
    [self processScanValue:aScannedValue];
    
}

- (void) processScanValue:(NSString *) aScannedValue{
    // Stop scanning camera
    [self stopScanning];
    // Check if it is an id or not
    if([self isCorrectFormat:aScannedValue]){
        // freeze camera
        // send id to database
        [self postRegisterDesk:aScannedValue];
    }else{
        // Start scanning
        [self startScanning];
    }
    
}


#pragma mark - Internet Connection

/**
 * Post function for register desk
 **/
- (void) postRegisterDesk:(NSString *) deskId{
    // assume we get the link data here
    
    
    // data is recieve and allow for usage
    // Recieve desk data
    Desk* desk = [[Desk alloc] initWithDeskId:[deskId intValue] roomId:1 isAvailable:true];
    [self toCheckInNoticeViewController:desk];
    

    
}

- (void) processRecievedRegistrationData{
    
}


/**
 * Check if it is a coorect id
 */
- (BOOL) isCorrectFormat:(NSString *) aString{
    return [self stringIsNumeric:aString];
}

-(BOOL) stringIsNumeric:(NSString *) str {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:str];
    return !!number; // If the string is not numeric, number will be nil
}

- (void) toCheckInNoticeViewController:(Desk *) desk{
    CheckInNoticeViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckInNoticeViewController"];
    VC2.delegate = self;
    VC2.currentDesk = desk;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}


- (void) toMainViewController:(UIGestureRecognizer *)recognizer{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
