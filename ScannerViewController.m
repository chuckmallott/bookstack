//
//  ScannerViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 1/2/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "ScannerViewController.h"
@import AVFoundation;

@interface ScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) NSMutableArray * foundBarcodes;
@property (weak, nonatomic) UIView *previewView;
@end

@implementation ScannerViewController {
    AVCaptureSession *captureSession;
    AVCaptureDevice *videoDevice;
    AVCaptureDeviceInput *videoInput;
    AVCaptureVideoPreviewLayer *captureLayer;
    BOOL running;
    AVCaptureMetadataOutput *metadataOutput;
    UIView *cameraPreviewView;
    NSString *scannedBarcode;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [captureSession startRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 60)];
    label.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    UIImage *imageLogo = [UIImage imageNamed:@"mvp-assets/logo-horiz.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(125.0, 28.0, 130.0, 18.0)];
    imageViewLogo.image = imageLogo;
    [self.view addSubview:imageViewLogo];
    
    UILabel *labelScan = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 60.0, self.view.bounds.size.width, 50)];
    labelScan.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.25];
    [self.view addSubview:labelScan];
    
    
    UILabel *labelScanText = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 80.0, 120, 20)];
    labelScanText.text = @"Scan a Barcode";
    labelScanText.textColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    labelScanText.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:labelScanText];
    
    UIButton *btnDone = [[UIButton alloc]initWithFrame:CGRectMake(331.0, 64.0, 40.0, 50.0)];
    [btnDone addTarget:self
                action:@selector(doneClick)
      forControlEvents:UIControlEventTouchUpInside];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:btnDone];
    
    cameraPreviewView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height - 150)];
    [self.view addSubview:cameraPreviewView];
    
    captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"Error Getting Camera Input");
        return;
    }
    
    [captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureSession addOutput:captureMetadataOutput];
    // Create a new queue and set delegate for metadata objects scanned.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("scanQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // Delegate should implement captureOutput:didOutputMetadataObjects:fromConnection: to get callbacks on detected metadata.
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    captureLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    [captureLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [captureLayer setFrame:cameraPreviewView.layer.bounds];
    [cameraPreviewView.layer addSublayer:captureLayer];


}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *capturedBarcode = nil;
    
    NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode,
                                       AVMetadataObjectTypeCode39Code,
                                       AVMetadataObjectTypeCode39Mod43Code,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode93Code,
                                       AVMetadataObjectTypeCode128Code,
                                       AVMetadataObjectTypePDF417Code,
                                       AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeAztecCode
                                       ];
    
    for (AVMetadataObject *barcodeMetadata in metadataObjects) {
        
        for (NSString *supportedBarcode in supportedBarcodeTypes) {
            
            if ([supportedBarcode isEqualToString:barcodeMetadata.type]) {

                AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[captureLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                capturedBarcode = [barcodeObject stringValue];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [captureSession stopRunning];
                    scannedBarcode = capturedBarcode;
                    NSLog(@"scanned Barcode %@", scannedBarcode);
                });
                return;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneClick {
    //[captureSession stopRunning];
    NSLog(@"done");
    [self dismissViewControllerAnimated:YES completion:nil];
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
