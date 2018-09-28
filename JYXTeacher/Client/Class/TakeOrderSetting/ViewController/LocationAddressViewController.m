//
//  LocationAddressViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "LocationAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "LocationTableViewCell.h"
#import "BaseTableView.h"


@interface LocationAddressViewController ()<UITextFieldDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
@property (nonatomic, strong)UITextField           *tf_search;
@property (nonatomic) BOOL showsUserLocation;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) MAUserLocationRepresentation *Representation;
@property (nonatomic, strong)UIImageView           *img_mapCenter;
@property (nonatomic ,strong)BaseTableView         *tb_address;
@property (nonatomic ,strong)NSMutableArray        *arr_address;
@property (nonatomic ,strong)NSMutableArray        *arr_searchAddress;
@property (nonatomic ,assign)int                    selectedIndex;
@property (nonatomic ,assign)int                    search_selectedIndex;
@property (nonatomic        )double                latitude;
@property (nonatomic        )double                longitude;
@property (nonatomic ,strong)UIView                *tb_back;
@property (nonatomic ,strong)BaseTableView         *tb_searchAddress;
@property (nonatomic ,strong)NSString              *str_search;
@property (nonatomic ,strong)AMapLocationManager   *locationManager;
@property (nonatomic ,assign)int                    tableIndex;


@end

@implementation LocationAddressViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_address = [[NSMutableArray alloc]init];
        self.arr_searchAddress = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"位置";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    self.selectedIndex = 0;
    self.search_selectedIndex = 0;
    self.tableIndex = 1;
}

- (void)onCreate{
    
    
    self.tf_search = [[UITextField alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight + 6, SCREEN_WIDTH - 20, 30)];
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    [iv_icon setImage:[UIImage imageNamed:@"home_search"]];
    [v_left addSubview:iv_icon];
    self.tf_search.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    self.tf_search.leftView = v_left;
    self.tf_search.leftViewMode = UITextFieldViewModeAlways;
    self.tf_search.placeholder = @"搜索地点";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
    self.tf_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_search.enablesReturnKeyAutomatically = YES;
    self.tf_search.tintColor = [UIColor colorWithHexString:@"#4167B2"];
    [self.view addSubview:self.tf_search];
    
//    [AMapServices sharedServices].apiKey =@"2c81b2b54c03fbdabdbcde8c90d0617c";
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    //   定位超时时间，最低2s，此处设置为2s
//    self.locationManager.locationTimeout =2;
//    //   逆地理请求超时时间，最低2s，此处设置为2s
//    self.locationManager.reGeocodeTimeout = 2;
//    self.locationManager = [[AMapLocationManager alloc]init];
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//
//        NSLog(@"location:%@", location);
//
//        if (regeocode)
//        {
//            self.cityName = regeocode.city;
//            NSLog(@"reGeocode:%@", regeocode);
//        }
//    }];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 40, SCREEN_WIDTH, 300)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.rotateEnabled = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    [self.mapView setZoomLevel:15.2 animated:YES];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor = [UIColor clearColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor clearColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 0;///精度圈 边线宽度，默认0
    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    r.locationDotBgColor = [UIColor clearColor];///定位点背景色，不设置默认白色
    r.locationDotFillColor = [UIColor clearColor];///定位点蓝色圆点颜色，不设置默认蓝色
    r.image = [UIImage imageNamed:@""]; ///定位图标, 与蓝色原点互斥
    [self.mapView updateUserLocationRepresentation:r];
    
    /// 去掉高德地图logo
    for (UIView *view in self.mapView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    UIImage *image = [UIImage imageNamed:@"location"];
    self.img_mapCenter = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - image.size.width / 2 / 2, SafeAreaTopHeight + 40 + 300/2 - image.size.height / 2 / 2,image.size.width / 2 , image.size.height / 2)];
    [self.view addSubview:self.img_mapCenter];
    [self.img_mapCenter setImage:[UIImage imageNamed:@"location"]];
    
    
    self.tb_address = [[BaseTableView alloc]initWithFrame:CGRectMake(0, self.mapView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight - self.mapView.bottom) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_address];
    self.tb_address.delegate = self;
    self.tb_address.dataSource = self;
    self.tb_address.rowHeight = 53;
    self.tb_address.tableFooterView = [UIView new];
    [self.tb_address reloadData];
    
    self.tb_back = [[UIView alloc]initWithFrame:CGRectMake(0, self.mapView.top, SCREEN_WIDTH, SCREEN_HEIGHT - self.tf_search.bottom)];
    [self.view addSubview:self.tb_back];
    [self.tb_back setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
    [self.tb_back setHidden:YES];
    
    self.tb_searchAddress = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tf_search.bottom) style:UITableViewStylePlain];
    [self.tb_back addSubview:self.tb_searchAddress];
    [self.tb_searchAddress setDelegate:self];
    [self.tb_searchAddress setDataSource:self];
    self.tb_searchAddress.rowHeight = 53;
    [self.tb_searchAddress setBackgroundColor:[UIColor whiteColor]];
    self.tb_searchAddress.tableFooterView = [UIView new];
    [self.tb_searchAddress setHidden:YES];
    

}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    MACoordinateRegion region;
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    
    region.center = centerCoordinate;
    
    [self setGegeo:centerCoordinate];
    
}

- (void)setGegeo:(CLLocationCoordinate2D)coor {
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc]init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
    regeo.requireExtension            = YES;
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode !=nil)
    {
//        self.cityName = [response.regeocode.pois objectAtIndex:0].city;
        if (response.regeocode.pois && response.regeocode.pois.count >0) {
            [self.arr_address removeAllObjects];
            [self.arr_address addObjectsFromArray:response.regeocode.pois];
            for (int i = 0;i < self.arr_address.count ; i++) {
                AMapPOI *poiTemp = [self.arr_address objectAtIndex:i];
                if ([poiTemp.address isEqualToString:@""]) {
                    [self.arr_address removeObjectAtIndex:i];
                }
            }
            [self.tb_address reloadData];
        }
    }
}

#pragma textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.tb_back setHidden:NO];
    [self.tb_searchAddress setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [self.tb_back setHidden:YES];
//    [self.tb_searchAddress setHidden:YES];
//    self.str_search = textField.text;
//    [self selectAddress];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.str_search = toBeString;
    [self selectAddress];
    return YES;
}

- (void)selectAddress{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = self.str_search;
    request.city                = self.str_city;
    request.requireExtension    = YES;
//    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        self.tb_searchAddress.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_searchAddress.frame withDefaultImage:nil withNoteTitle:@"无结果" withNoteDetail:nil withButtonAction:nil];
        return;
    }else{
        self.tableIndex = 2;
        [self.arr_searchAddress removeAllObjects];
        [self.arr_searchAddress addObjectsFromArray:response.pois];
        for (int i = 0;i < self.arr_searchAddress.count ; i++) {
            AMapPOI *poiTemp = [self.arr_searchAddress objectAtIndex:i];
            if ([poiTemp.address isEqualToString:@""]) {
                [self.arr_searchAddress removeObjectAtIndex:i];
            }
        }
        [self.tb_searchAddress reloadData];
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tb_address) {
        return self.arr_address.count;
    }
    if (tableView == self.tb_searchAddress) {
        return self.arr_searchAddress.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_address) {
        static NSString *CellIdentifier = @"LocationTableViewCell";
        LocationTableViewCell *cell = (LocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[LocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == self.selectedIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        AMapPOI *poiTemp = [self.arr_address objectAtIndex:indexPath.row];
        cell.lab_name.text = poiTemp.name;
        cell.lab_address.text = poiTemp.address;
        return cell;
    }
    if (tableView == self.tb_searchAddress) {
        static NSString *CellIdentifier = @"LocationTableViewCell";
        LocationTableViewCell *cell = (LocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[LocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == self.search_selectedIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        AMapPOI *poiTemp = [self.arr_searchAddress objectAtIndex:indexPath.row];
        cell.lab_name.text = poiTemp.name;
        cell.lab_address.text = poiTemp.address;
        return cell;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tb_address) {
        self.tableIndex = 1;
        self.selectedIndex = (int)indexPath.row;
        [self.tb_address reloadData];
    }
    if (tableView == self.tb_searchAddress) {
        self.tableIndex = 2;
        self.search_selectedIndex = (int)indexPath.row;
        [self.tb_searchAddress reloadData];
    }
}


- (void)rightBarAction{
//    if (self.tableIndex != 1 && self.self.tableIndex != 2 ) {
//        [MBProgressHUD showErrorMessage:@"请选择地址"];
//        return;
//    }
    if (self.tableIndex == 1) {
        //地图界面上的
        AMapPOI *poiTemp = [self.arr_address objectAtIndex:self.selectedIndex];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.goBackAddress) {
            self.goBackAddress(poiTemp);
        }
    }
    if (self.tableIndex == 2) {
        //搜索界面上的
        AMapPOI *poiTemp = [self.arr_searchAddress objectAtIndex:self.search_selectedIndex];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.goBackAddress) {
            self.goBackAddress(poiTemp);
        }
    }
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
