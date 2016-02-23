//
//  RegeocodeViewController.m
//  Geocode
//
//  Created by qingyun on 16/2/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RegeocodeViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RegeocodeViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@end

@implementation RegeocodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //在地图上添加一个长按手势
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [self.mapview addGestureRecognizer:longPress];
    
}

-(void)longPress:(UILongPressGestureRecognizer *)press{
    //用户长按的位置
    CGPoint point = [press locationInView:self.mapview];
    //转化为地图坐标
    CLLocationCoordinate2D coordinate = [self.mapview convertPoint:point toCoordinateFromView:self.mapview];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    //编码器，反编码位置  北京
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *place = placemarks.firstObject;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate =place.location.coordinate;
        point.subtitle = place.name;
        point.title = place.country;
        [self.mapview addAnnotation:point];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
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
