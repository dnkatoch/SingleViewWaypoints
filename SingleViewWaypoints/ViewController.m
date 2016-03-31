//
//  ViewController.m
//  SingleViewWaypoints
//
//  Created by Deepa  Katoch on 3/18/15.
//  Copyright (c) 2015 Deepa  Katoch. All rights reserved.
//

#import "ViewController.h"
#import"Waypoint.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *latTV;
@property (weak, nonatomic) IBOutlet UITextField *lonTv;
@property (weak, nonatomic) IBOutlet UITextField *nameTV;
@property (weak, nonatomic) IBOutlet UITextField *distanceTV;
@property (weak, nonatomic) IBOutlet UITextField *toTV;

@property (strong, nonatomic) NSMutableDictionary * wpLib;
@property (strong, nonatomic) UIPickerView * namePicker;
@property (strong, nonatomic) UIPickerView * toPicker;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.latTV.delegate = self;
    self.latTV.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.lonTv.delegate = self;
    self.lonTv.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    Waypoint * ny = [[Waypoint alloc] initWithLat:40.7127 lon:-74.0059 name:@"New-York"];
    Waypoint * asup = [[Waypoint alloc] initWithLat:33.3056 lon:-111.6788 name:@"ASUP"];
    Waypoint * asub = [[Waypoint alloc] initWithLat:33.4235 lon:-111.9389 name:@"ASUB"];
    Waypoint * paris = [[Waypoint alloc] initWithLat:48.8567 lon:2.3508 name:@"Paris"];
    Waypoint * moscow = [[Waypoint alloc] initWithLat:55.75 lon:37.6167 name:@"Moscow"];
    
    self.wpLib = @{@"New-York":ny,@"ASUP":asup,@"ASUB":asub,@"Paris":paris,@"Moscow":moscow };
    
    self.namePicker = [[UIPickerView alloc]init];
    self.namePicker.delegate=self;
    self.namePicker.dataSource = self;
    self.toPicker = [[UIPickerView alloc]init];
    self.toPicker.delegate=self;
    self.toPicker.dataSource = self;
    
    self.toTV.inputView = self.toPicker;
    self.nameTV.inputView = self.namePicker;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addClicked:(id)sender {
    NSLog(@"add got clicked");
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"Input Required"
        message:@"Enter Waypoint Name" delegate:self cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView : (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0]text]);
    
}
- (IBAction)removeClicked:(id)sender {
     NSLog(@"remove got clicked");
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == self.toPicker){
        [self.toTV resignFirstResponder];
        // to do :load the toTV with the name of teh selected waypoint
        NSString * text =[self pickerView:self.toPicker titleForRow:row forComponent:component];
        self.toTV.text = text;
        
    } else{
        [self.nameTV resignFirstResponder];
        //to do: load the latTV, lonTV and nameTV with the selected waypoint information
        NSString * text = [self pickerView:self.namePicker titleForRow:row forComponent:component];
        self.nameTV.text = text;
        Waypoint * value = [self.wpLib valueForKey:text];
        self.latTV.text = [NSString stringWithFormat:@"%.4f", value.lat];
        self.lonTv.text = [NSString stringWithFormat:@"%.4f", value.lon];
        
        //load the distance after calculation
        //Waypoint *waydist = [[Waypoint alloc]init];
       // double dist = [Waypoint dist:(double)details.lat lon:(double)details.lon Scale:@"Statute"];
        //self.distanceTV.text = dist;
    }
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString* ) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray * keys = [self.wpLib allKeys];
    NSString* ret = @"unknown";
    if(row < keys.count){
        ret = keys[row];
    }
    return ret;
    
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.wpLib allKeys].count;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.latTV resignFirstResponder];
    [self.lonTv resignFirstResponder];
    [self.nameTV resignFirstResponder];
    [self.toTV resignFirstResponder];
    
}
@end
