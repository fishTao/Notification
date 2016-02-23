//
//  GeocodeViewController.m
//  Geocode
//
//  Created by qingyun on 16/2/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GeocodeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GeocodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFild;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation GeocodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textFild addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textFild.returnKeyType = UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editEnd:(UITextField *)sender{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.textFild.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        [self.mapView removeAnnotations:self.mapView.annotations];
        
        
        double minLatitude = 90;
        double maxLatitude = -90;
        
        double minLongtitude = 180;
        double maxLongtitude = -180;
        
        if (placemarks.count == 0) {
            return;
        }
        
        
        for (CLPlacemark *place in placemarks) {
            CLLocation *location = place.location;
            
            //添加标注到地图上
            MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
            anno.coordinate = location.coordinate;
            anno.title = place.name;
            [self.mapView addAnnotation:anno];
            
            
            
            minLatitude = location.coordinate.latitude < minLatitude ? location.coordinate.latitude : minLatitude;
            
            maxLatitude = location.coordinate.latitude > maxLatitude ? location.coordinate.latitude : maxLatitude;
            
            minLongtitude = location.coordinate.longitude < minLongtitude ? location.coordinate.longitude : minLongtitude;
            
            maxLongtitude = location.coordinate.longitude > maxLongtitude ? location.coordinate.longitude : maxLongtitude;
        }
        
        //计算地图显示区域
        
        double centerLatitude = (minLatitude + maxLatitude)/2;
        double centerLongtitude = (minLongtitude + maxLongtitude)/2;
        
        double spanLa = (maxLatitude - minLatitude) * 1.2;
        double spanLong = (maxLongtitude  - minLongtitude) * 1.2;
        
        MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(centerLatitude, centerLongtitude), MKCoordinateSpanMake(spanLa, spanLong));
        
        [self.mapView setRegion:region];
        
        
    }];
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
