//
//  ComSvcMgr.m
//  BinZang
//
//  Created by Beids on 5/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ComSvcMgr.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@implementation ComSvcMgr
@synthesize delegate;

//////////////////////////////////////////////////////////
#pragma mark - User Info Manager Interface

- (void) GetBannerImages
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_BANNERIMGS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBannerImagesResult:retmsg:datalist:)])
         {
             [self parseBannerImages:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBannerImagesResult:retmsg:datalist:)])
         {
             [delegate getBannerImagesResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetCompanyIntro
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_COMPANYINTRO];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getCompanyIntroResult:retmsg:image_url:contents:phone:)])
         {
             [self parseCompanyIntro:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getCompanyIntroResult:retmsg:image_url:contents:phone:)])
         {
             [delegate getCompanyIntroResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE image_url:nil contents:nil phone:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAfterService
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_AFTERSVC];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAfterServiceResult:retmsg:datainfo:)])
         {
             [self parseAfterSvc:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAfterServiceResult:retmsg:datainfo:)])
         {
             [delegate getAfterServiceResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetFuneralProducts
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_FUNERALPROD];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getFuneralProdResult:retmsg:datalist:)])
         {
             [self parseFuneralProds:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAfterServiceResult:retmsg:datainfo:)])
         {
             [delegate getFuneralProdResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficeIntros
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_OFFICEINTROS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOfficeIntrosResult:retmsg:datalist:)])
         {
             [self parseOfficeIntros:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOfficeIntrosResult:retmsg:datalist:)])
         {
             [delegate getOfficeIntrosResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}


- (void) GetOfficeDetail : (long)office_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_OFFICEDETAIL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:office_id], @"office_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOfficeDetailResult:retmsg:datainfo:)])
         {
             [self parseOfficeDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOfficeDetailResult:retmsg:datainfo:)])
         {
             [delegate getOfficeDetailResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAreaPoints
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_AREAPOINTS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         //		NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(getAreaPointsResult:retmsg:datalist:)])
         {
             [self parseAreaPoints:responseObject];
         }
         //		MyLog(@"Request Successful, response '%@'", responseStr);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAreaPointsResult:retmsg:datalist:)])
         {
             [delegate getAreaPointsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAreaPointDetail : (long)area_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_AREAPOINTDETAIL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:area_id], @"area_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAreaPointDetail:retmsg:datainfo:)])
         {
             [self parseAreaPointDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAreaPointDetail:retmsg:datainfo:)])
         {
             [delegate getAreaPointDetail:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}


- (void) Get36Views
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_36VIEWS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(get36ViewsResult:retmsg:datalist:)])
         {
             [self parse36Views:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(get36ViewsResult:retmsg:datalist:)])
         {
             [delegate get36ViewsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) Get36ViewDetail : (long)view_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_36DETAIL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:view_id], @"view_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(get36ViewDetail:retmsg:datainfo:)])
         {
             [self parse36ViewDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(get36ViewDetail:retmsg:datainfo:)])
         {
             [delegate get36ViewDetail:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetNavDestination
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_NAVDESTINATION];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getNavDestination:retmsg:datainfo:)])
         {
             [self parseNavDestination:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getNavDestination:retmsg:datainfo:)])
         {
             [delegate getNavDestination:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ReserveVisit : (NSString *)phone nick_name:(NSString *)nick_name office_id:(long)office_id reserve_time:(NSString*)reserve_time;
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_RSRV_VISIT];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phone, @"phone",
                            nick_name, @"nick_name",
                            [NSNumber numberWithLong:office_id], @"office_id",
                            reserve_time, @"reserve_time",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveVisitResult:retmsg:)])
         {
             [self parseReserveVisit:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveVisitResult:retmsg:)])
         {
             [delegate reserveVisitResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetFoodPageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_FOODPAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getFoodPageUrlResult:retmsg:page_url:)])
         {
             [self parseFoodPageUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getFoodPageUrlResult:retmsg:page_url:)])
         {
             [delegate getFoodPageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE page_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetHotelPageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_HOTELPAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getHotelPageUrlResult:retmsg:page_url:)])
         {
             [self parseHotelPageUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getHotelPageUrlResult:retmsg:page_url:)])
         {
             [delegate getHotelPageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE page_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetJournalPageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_JOURNALPAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getJournalPageUrlResult:retmsg:plane_page_url:train_page_url:)])
         {
             [self parseJournalPageUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getJournalPageUrlResult:retmsg:plane_page_url:train_page_url:)])
         {
             [delegate getJournalPageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE plane_page_url:nil train_page_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetCinemaPageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_CINEMAPAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getCinemaPageUrlResult:retmsg:page_url:)])
         {
             [self parseCinemaPageUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getCinemaPageUrlResult:retmsg:page_url:)])
         {
             [delegate getCinemaPageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE page_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetGamePageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_GAMEPAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getGamePageUrlResult:retmsg:page_url:)])
         {
             [self parseGamePageUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getGamePageUrlResult:retmsg:page_url:)])
         {
             [delegate getGamePageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE page_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetExamImageUrl
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCME_GET_EXAMIMAGEURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getExamImageUrlResult:retmsg:worker_img_url:school_img_url:photo_img_url:)])
         {
             [self parseExamImgUrl:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getExamImageUrlResult:retmsg:worker_img_url:school_img_url:photo_img_url:)])
         {
             [delegate getExamImageUrlResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE worker_img_url:nil school_img_url:nil photo_img_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetMtQiPanViews
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_MTQIPANVIEWS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getMtQiPanViewsResult:retmsg:datalist:)])
         {
             [self parseMtQiPanViews:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getMtQiPanViewsResult:retmsg:datalist:)])
         {
             [delegate getMtQiPanViewsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetMtQiPanDetail : (long)view_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_MTQIPANDET];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:view_id], @"view_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getMTQiPanDetailResult:retmsg:datainfo:)])
         {
             [self parseMtQiPanDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getMTQiPanDetailResult:retmsg:datainfo:)])
         {
             [delegate getMTQiPanDetailResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOneDragonAreas
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_ONEDDRAGONAREAS];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonAreasResult:retmsg:datalist:)])
         {
             [self parseOneDragonAreas:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonAreasResult:retmsg:datalist:)])
         {
             [delegate getOneDragonAreasResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOneDragonAreaDetail : (long)area_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_ONEDGRAGONAREADET];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:area_id], @"area_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonAreaDetResult:retmsg:datainfo:)])
         {
             [self parseOneDragonAreaDet:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonAreaDetResult:retmsg:datainfo:)])
         {
             [delegate getOneDragonAreaDetResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOneDragonCompDetail : (long)service_id
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_ONEDGRAGONCOMPDET];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:service_id], @"service_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonCompDetResult:retmsg:datainfo:)])
         {
             [self parseOneDragonCompDet:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getOneDragonCompDetResult:retmsg:datainfo:)])
         {
             [delegate getOneDragonCompDetResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTombKnowledge
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_TOMBKNOWLEDGE];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombKnowledgeResult:retmsg:buy_tomb_flow:precaution:bury_custom:bury_news_url:)])
         {
             [self parseTombKnowledge:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombKnowledgeResult:retmsg:buy_tomb_flow:precaution:bury_custom:bury_news_url:)])
         {
             [delegate getTombKnowledgeResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE buy_tomb_flow:nil precaution:nil bury_custom:nil bury_news_url:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

/////////////////////////////////////////////////////////////////////////////
///////////////////////////////// event implementation //////////////////////
/////////////////////////////////////////////////////////////////////////////

#pragma mark - Service Event Implementation

- (void) parseBannerImages:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STBannerImg * iteminfo = [[STBannerImg alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getBannerImagesResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseCompanyIntro:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * image_url = @"";
    NSString * contents = @"";
    NSString * phone = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:jsonDic];
            contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:jsonDic];
            phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:jsonDic];
        }
    }
    
    [delegate getCompanyIntroResult:jsonRet retmsg:retmsg image_url:image_url contents:contents phone:phone];
}

- (void) parseAfterSvc:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STAfterService * datainfo = [[STAfterService alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getAfterServiceResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseFuneralProds:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STProduct * iteminfo = [[STProduct alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getFuneralProdResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseOfficeIntros:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeCity * iteminfo = [[STOfficeCity alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getOfficeIntrosResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseOfficeDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STOffice * datainfo = [[STOffice alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getOfficeDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}



- (void)parseAreaPoints:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STAreaPoint * iteminfo = [[STAreaPoint alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getAreaPointsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void)parseAreaPointDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STAreaPointDetail * datainfo = [[STAreaPointDetail alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    //[delegate getAreaPointDetail:(NSInteger) retmsg:<#(NSString *)#> datainfo:(STAreaPointDetail *):jsonRet retmsg:retmsg datalist:datalist];
    [delegate getAreaPointDetail:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parse36Views:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                ST36View * iteminfo = [[ST36View alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate get36ViewsResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parse36ViewDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    ST36View * datainfo = [[ST36View alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate get36ViewDetail:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseNavDestination:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STGpsPos * datainfo = [[STGpsPos alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getNavDestination:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseReserveVisit:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
        }
    }
    
    [delegate reserveVisitResult:jsonRet retmsg:retmsg];
}


- (void) parseFoodPageUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl = [GlobalFunc getStringValueWithKey:@"page_url" Dict:jsonDic];
        }
    }
    
    [delegate getFoodPageUrlResult:jsonRet retmsg:retmsg page_url:pageUrl];
}

- (void) parseHotelPageUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl = [GlobalFunc getStringValueWithKey:@"page_url" Dict:jsonDic];
        }
    }
    
    [delegate getHotelPageUrlResult:jsonRet retmsg:retmsg page_url:pageUrl];
}

- (void) parseJournalPageUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl1 = @"";
    NSString * pageUrl2 = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl1 = [GlobalFunc getStringValueWithKey:@"plane_page_url" Dict:jsonDic];
            pageUrl2 = [GlobalFunc getStringValueWithKey:@"train_page_url" Dict:jsonDic];
        }
    }
    
    [delegate getJournalPageUrlResult:jsonRet retmsg:retmsg plane_page_url:pageUrl1 train_page_url:pageUrl2];
}

- (void) parseGamePageUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl = [GlobalFunc getStringValueWithKey:@"page_url" Dict:jsonDic];
        }
    }
    
    [delegate getGamePageUrlResult:jsonRet retmsg:retmsg page_url:pageUrl];
}

- (void) parseCinemaPageUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl = [GlobalFunc getStringValueWithKey:@"page_url" Dict:jsonDic];
        }
    }
    
    [delegate getCinemaPageUrlResult:jsonRet retmsg:retmsg page_url:pageUrl];
}


- (void) parseExamImgUrl:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * pageUrl1 = @"";
    NSString * pageUrl2 = @"";
    NSString * pageUrl3 = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            pageUrl1 = [GlobalFunc getStringValueWithKey:@"worker_image_url" Dict:jsonDic];
            pageUrl2 = [GlobalFunc getStringValueWithKey:@"school_image_url" Dict:jsonDic];
            pageUrl3 = [GlobalFunc getStringValueWithKey:@"photo_image_url" Dict:jsonDic];
        }
    }
    
    [delegate getExamImageUrlResult:jsonRet retmsg:retmsg worker_img_url:pageUrl1 school_img_url:pageUrl2 photo_img_url:pageUrl3];
}


- (void) parseMtQiPanViews:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STMtQiPan * iteminfo = [[STMtQiPan alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getMtQiPanViewsResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseMtQiPanDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STMtQiPan * datainfo = [[STMtQiPan alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getMTQiPanDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseOneDragonAreas:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STDragonServiceCity * iteminfo = [[STDragonServiceCity alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getOneDragonAreasResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseOneDragonAreaDet:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STDragonServiceArea * datainfo = [[STDragonServiceArea alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getOneDragonAreaDetResult:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseOneDragonCompDet:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STDragonService * datainfo = [[STDragonService alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getOneDragonCompDetResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseTombKnowledge:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSString * bury_tomb_flow = @"";
    NSString * precaution = @"";
    NSString * bury_custom = @"";
    NSString * bury_news_url = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            bury_tomb_flow = [GlobalFunc getStringValueWithKey:@"buy_tomb_flow" Dict:jsonDic];
            precaution = [GlobalFunc getStringValueWithKey:@"precaution" Dict:jsonDic];
            bury_custom = [GlobalFunc getStringValueWithKey:@"bury_custom" Dict:jsonDic];
            bury_news_url = [GlobalFunc getStringValueWithKey:@"bury_news_url" Dict:jsonDic];
        }
    }
    
    [delegate getTombKnowledgeResult:jsonRet retmsg:retmsg buy_tomb_flow:bury_tomb_flow precaution:precaution bury_custom:bury_custom bury_news_url:bury_news_url];
}


- (void) LoginUser : (NSString *)user_name password:(NSString *)password
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_LOGIN];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user_name, @"user_name",
                            password, @"password",
                            PLATFORM, @"platform",
                            [GlobalFunc getDeviceMacAddress], @"device_token",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(loginUserResult:retmsg:datainfo:)])
         {
             [self parseLoginUser:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(loginUserResult:retmsg:datainfo:)])
         {
             [delegate loginUserResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ForgetPassword : (NSString *)user_name phone:(NSString *)phone new_password:(NSString *)new_password
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_FORGOTPWD];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user_name, @"user_name",
                            phone, @"phone",
                            new_password, @"new_password",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(forgotPasswordResult:retmsg:)])
         {
             [self parseForgotPwd:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(forgotPasswordResult:retmsg:)])
         {
             [delegate forgotPasswordResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAdverts
{
    NSString * method_name = SVCCMD_GET_ADVERTS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAdvertsResult:retmsg:adverts:relatives:)])
         {
             [self parseAdverts:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAdvertsResult:retmsg:adverts:relatives:)])
         {
             [delegate getAdvertsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE adverts:nil relatives:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetActivities
{
    NSString * method_name = SVCCMD_GET_ACTIVITIES;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActivitiesResult:retmsg:datalist:)])
         {
             [self parseActivities:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActivitiesResult:retmsg:datalist:)])
         {
             [delegate getActivitiesResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetNewActCount
{
    NSString * method_name = SVCCMD_GET_NEWACTCOUNT;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getNewActCountResult:retmsg:count:)])
         {
             [self parseNewActCount:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getNewActCountResult:retmsg:count:)])
         {
             [delegate getNewActCountResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE count:0];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}





- (void) GetActDetail : (long)activity_id
{
    NSString * method_name = SVCCMD_GET_ACTDETAIL;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:activity_id], @"activity_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActDetailResult:retmsg:datainfo:)])
         {
             [self parseActDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActDetailResult:retmsg:datainfo:)])
         {
             [delegate getActDetailResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ReadActivity : (long)activity_id
{
    NSString * method_name = SVCCMD_READ_ACTIVITY;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:activity_id], @"activity_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(readActivityResult:retmsg:)])
         {
             [self parseReadActivity:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(readActivityResult:retmsg:)])
         {
             [delegate readActivityResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetRelativeData
{
    NSString * method_name = SVCCMD_GET_RELATIVEDATA;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getRelativeDataResult:retmsg:datalist:)])
         {
             [self parseRelativeData:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getRelativeDataResult:retmsg:datalist:)])
         {
             [delegate getRelativeDataResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBills : (int)page_no
{
    NSString * method_name = SVCCMD_GET_BILLS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBillsResult:retmsg:datalist:)])
         {
             [self parseBills:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBillsResult:retmsg:datalist:)])
         {
             [delegate getBillsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBillDetail : (long)bill_id
{
    NSString * method_name = SVCCMD_GET_BILLDETAIL;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:bill_id], @"bill_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBillDetailResult:retmsg:datainfo:)])
         {
             [self parseBillDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBillsResult:retmsg:datalist:)])
         {
             [delegate getBillsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetDeputyLogs : (int)page_no
{
    NSString * method_name = SVCCMD_GET_DEPUTYLOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDeputyLogsResult:retmsg:datalist:)])
         {
             [self parseDeputyLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDeputyLogsResult:retmsg:datalist:)])
         {
             [delegate getDeputyLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetDeputyLogDetail : (long)log_id
{
    NSString * method_name = SVCCMD_GET_DEPUTYDETAIL;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:log_id], @"log_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDeputyLogDetailResult:retmsg:datainfo:)])
         {
             [self parseDeputyLogDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDeputyLogDetailResult:retmsg:datainfo:)])
         {
             [delegate getDeputyLogDetailResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetSvcPeopleInfo
{
    NSString * method_name = SVCCMD_GET_SVCPEOPLEINFO;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getSvcPeopleInfoResult:retmsg:datainfo:)])
         {
             [self parseSvcPeopleInfo:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getSvcPeopleInfoResult:retmsg:datainfo:)])
         {
             [delegate getSvcPeopleInfoResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ReserveCerermony : (long)customer_id reserve_time:(NSString *)reserve_time tomb_id:(long)tomb_id is_deputyservice:(bool)is_deputyservice bury_service_id:(long)bury_service_id products:(NSString *)products
{
    NSString * method_name = SVCCMD_RSRV_CEREMONY;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSString stringWithFormat:@"%ld", customer_id], @"customer_id",
                            reserve_time, @"reserve_time",
                            [NSString stringWithFormat:@"%ld", tomb_id], @"tomb_id",
                            [NSString stringWithFormat:@"%ld", bury_service_id], @"bury_service_id",
                            products, @"products",
                            nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveCeremonyResult:retmsg:)])
         {
             [self parseReserveCeremony:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveCeremonyResult:retmsg:)])
         {
             [delegate reserveCeremonyResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetActivityProducts
{
    NSString * method_name = SVCCMD_GET_ACTPRODUCTS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActivityProdResult:retmsg:datalist:)])
         {
             [self parseActivityProducts:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getActivityProdResult:retmsg:datalist:)])
         {
             [delegate getActivityProdResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTombListForCustomer
{
    NSString * method_name = SVCCMD_GET_TOMBLISTFORCUS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombListForCusResult:retmsg:datalist:)])
         {
             [self parseTombListForCus:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombListForCusResult:retmsg:datalist:)])
         {
             [delegate getTombListForCusResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetCustomerList
{
    NSString * method_name = SVCCMD_GET_CUSTOMERLIST;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetCustomerListResult:retmsg:datalist:)])
         {
             [self parseGetCustomerList:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetCustomerListResult:retmsg:datalist:)])
         {
             [delegate GetCustomerListResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTombList : (long)area_id
{
    NSString * method_name = SVCCMD_GET_TOMBLIST;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSString stringWithFormat:@"%ld", area_id], @"area_id",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombListResult:retmsg:datalist:)])
         {
             [self parseTombList:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombListResult:retmsg:datalist:)])
         {
             [delegate getTombListResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTombDetail : (long)tomb_id
{
    NSString * method_name = SVCCMD_GET_TOMBDETAIL;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSString stringWithFormat:@"%ld", tomb_id], @"tomb_id",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombDetailResult:retmsg:datainfo:)])
         {
             [self parseTombDetail:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombDetailResult:retmsg:datainfo:)])
         {
             [delegate getTombDetailResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTombStonePlaces : (long)area_id
{
    NSString * method_name = SVCCMD_GET_TOMBSTONEPLACES;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSString stringWithFormat:@"%ld", area_id], @"area_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombStonePlacesResult:retmsg:datalist:)])
         {
             [self parseTombStonePlaces:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombStonePlacesResult:retmsg:datalist:)])
         {
             [delegate getTombStonePlacesResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ReserveTombPlace : (NSString*)customer_name
            customer_phone:(NSString*)customer_phone
             death_people1:(NSString*)death_people1
               mgr_people1:(NSString*)mgr_people1
             death_people2:(NSString*)death_people2
               mgr_people2:(NSString*)mgr_people2
              tomb_area_id:(long)tomb_area_id
              tomb_site_id:(long)tomb_site_id
            tomb_tablet_id:(long)tomb_tablet_id
{
    NSString * method_name = SVCCMD_RSRV_TOMBPLACE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            customer_name, @"customer_name",
                            customer_phone, @"customer_phone",
                            death_people1, @"death_people1",
                            mgr_people1, @"mgr_people1",
                            death_people2, @"death_people2",
                            mgr_people2, @"mgr_people2",
                            [NSString stringWithFormat:@"%ld", tomb_area_id], @"tomb_area_id",
                            [NSString stringWithFormat:@"%ld", tomb_site_id], @"tomb_site_id",
                            [NSString stringWithFormat:@"%ld", tomb_tablet_id], @"tomb_tablet_id",
                            nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveTombPlaceResult:retmsg:)])
         {
             [self parseReserveTombPlace:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(reserveTombPlaceResult:retmsg:)])
         {
             [delegate reserveTombPlaceResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBonusFormula
{
    NSString * method_name = SVCCMD_GET_BONUSFORMULA;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBonusFormulaResult:retmsg:discount:commission:tax_rate:)])
         {
             [self parsegetBonusFormula:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getTombListForCusResult:retmsg:datalist:)])
         {
             [delegate getBonusFormulaResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE discount:0.f commission:0.f tax_rate:0.f];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAgents
{
    NSString * method_name = SVCCMD_GET_AGENTS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAgentsResult:retmsg:datalist:)])
         {
             [self parseGetAgents:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getAgentsResult:retmsg:datalist:)])
         {
             [delegate getAgentsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBonusDetailList :(long)user_id bonus_type:(int)bonus_type page_no:(int)page_no
{
    NSString * method_name = SVCCMD_GET_BONUSDETAILLIST;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithLong:user_id], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
							[NSNumber numberWithInt:bonus_type], @"bonus_type",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBonusDetailListResult:retmsg:datalist:)])
         {
             [self parseGetBonusDetailList:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBonusDetailListResult:retmsg:datalist:)])
         {
             [delegate getBonusDetailListResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetDepositLogs :(long) aim_user_id page_no:(int)page_no
{
    NSString * method_name = SVCCMD_GET_DEPOSITLOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithLong:aim_user_id], @"aim_user_id",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDepositLogsResult:retmsg:datalist:)])
         {
             [self parseDepositLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDepositLogsResult:retmsg:datalist:)])
         {
             [delegate getDepositLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBuyProductCount
{
    NSString * method_name = SVCCMD_GET_BUYPRODUCTACTCOUNT;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductCountResult:retmsg:count:)])
         {
             [self parseGetBuyProductCount:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getNewActCountResult:retmsg:count:)])
         {
             [delegate getBuyProductCountResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE count:0];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBuyProductLogs :(int) state page_no:(int)page_no
{
    NSString * method_name = SVCCMD_GET_BUYPRODUCTLOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithInt:state], @"state",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogsResult:retmsg:datalist:)])
         {
             [self parseBuyProductLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogsResult:retmsg:datalist:)])
         {
             [delegate getBuyProductLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBuyProductLogDetails : (long)log_id
{
    NSString * method_name = SVCCMD_GET_BUYPRODUCTLOGDETAIL;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithLong:log_id], @"log_id",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogDetailsResult:retmsg:datainfo:)])
         {
             [self parseBuyProductLogDetails:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogDetailsResult:retmsg:datainfo:)])
         {
             [delegate getBuyProductLogDetailsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) ReadBuyProductLog : (long)log_id
{
    NSString * method_name = SVCCMD_READBYPRODUCTLOG;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithLong:log_id], @"log_id",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         /*
          if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogDetailsResult:retmsg:datainfo:)])
          {
          [self parseBuyProductLogDetails:responseObject];
          }
          */
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         /*
          if (delegate != nil && [delegate respondsToSelector:@selector(getBuyProductLogDetailsResult:retmsg:datainfo:)])
          {
          [delegate getBuyProductLogDetailsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datainfo:nil];
          }*/
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAgentDepositLogs :(long) aim_user_id page_no:(int)page_no
{
    NSString * method_name = SVCCMD_GET_AGENTDEPOSITLOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithLong:aim_user_id], @"aim_user_id",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDepositLogsResult:retmsg:datalist:)])
         {
             [self parseDepositLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getDepositLogsResult:retmsg:datalist:)])
         {
             [delegate getDepositLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) CancelVocation:(long)vocation_id
{
    NSString * method_name = SVCCMD_CANCEL_VOCATION;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithLong:vocation_id], @"vocation_id",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(cancelVocationResult:retmsg:cancelled_id:)])
         {
             [self parseCancelVocationResult:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(cancelVocationResult:retmsg:cancelled_id:)])
         {
             [delegate cancelVocationResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE cancelled_id:-1];
             
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
    
}

- (void) GetVocationDates
{
    NSString * method_name = SVCCMD_GET_VOCATION_DATES;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getVocationDatesResult:retmsg:datalist:)])
         {
             
             //[self parseSubmitVocationResult:responseObject];
             [self parseGetVocationDatesResult:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getVocationDatesResult:retmsg:datalist:)])
         {
             [delegate getVocationDatesResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
    
}
- (void) SubmitVocation:(int) reason voc_date:(NSString*)voc_date
{
    NSString * method_name = SVCCMD_SUBMIT_VOCATION;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            [NSNumber numberWithInt:reason],@"reason",
                            voc_date, @"date",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(submitVocationResult:retmsg:)])
         {
             [self parseSubmitVocationResult:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(submitVocationResult:retmsg:)])
         {
             [delegate submitVocationResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE ];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficeList
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_OFFICELIST];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:SVCCMD_GET_OFFICELIST];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficeListResult:retmsg:datalist:)])
         {
             [self parseOfficeList:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficeListResult:retmsg:datalist:)])
         {
             [delegate GetOfficeListResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficesAttendance : (long) office_id
{
    NSString * method_name = SVCCMD_GET_OFFICES_ATTENDANCE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:office_id], @"office_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesAttendanceResult:retmsg:datalist:)])
         {
             [self parseGetOfficesAttendanceResult:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesAttendanceResult:retmsg:datalist:)])
         {
             [delegate GetOfficesAttendanceResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficesAttendanceList : (long) office_id
{
    NSString * method_name = SVCCMD_GET_OFFICES_ATTENDANCELIST;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:office_id], @"office_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesAttendanceListResult:retmsg:datalist:)])
         {
             [self parseGetOfficesAttendanceListResult:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesAttendanceListResult:retmsg:datalist:)])
         {
             [delegate GetOfficesAttendanceListResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficesDepositLogs : (int)page_no
{
    NSString * method_name = SVCCMD_GET_OFFICEDEPOSITLOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesDepositLogsResult:retmsg:datalist:)])
         {
             [self parseGetOfficeDepositLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesDepositLogsResult:retmsg:datalist:)])
         {
             [delegate GetOfficesDepositLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficesDailyScore : (int)page_no
{
    NSString * method_name = SVCCMD_GET_OFFICES_DAILYSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesDailyScoreResult:retmsg:datalist:)])
         {
             [self parseGetOfficesDailyScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesDailyScoreResult:retmsg:datalist:)])
         {
             [delegate GetOfficesDailyScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetEmployeesDailyScore : (long) office_id
{
    NSString * method_name = SVCCMD_GET_EMPLOYEES_DAILYSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:office_id], @"office_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeesDailyScoreResult:retmsg:datalist:)])
         {
             [self parseGetEmployeesDailyScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeesDailyScoreResult:retmsg:datalist:)])
         {
             [delegate GetEmployeesDailyScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficesCurMonthScore : (long) month
{
    NSString * method_name = SVCCMD_GET_OFFICES_CURMONTHSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:month], @"month",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesCurMonthScoreResult:retmsg:datalist:)])
         {
             [self parseGetOfficesCurMonthScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficesCurMonthScoreResult:retmsg:datalist:)])
         {
             [delegate GetOfficesCurMonthScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetOfficeMonthlyScore : (long) office_id
{
    NSString * method_name = SVCCMD_GET_OFFICE_MONTHLYSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:office_id], @"office_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficeMonthlyScoreResult:retmsg:datalist:)])
         {
             [self parseGetOfficeMonthlyScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetOfficeMonthlyScoreResult:retmsg:datalist:)])
         {
             [delegate GetOfficeMonthlyScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetEmployeePersonalScore : (int)page_no
{
    NSString * method_name = SVCCMD_GET_EMPLOYEEPERSONALSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeePersonalScoreResult:retmsg:datalist:)])
         {
             [self parseGetEmployeePersonalScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeePersonalScoreResult:retmsg:datalist:)])
         {
             [delegate GetEmployeePersonalScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAgentPersonalScore
{
    NSString * method_name = SVCCMD_GET_AGENTPERSONALSCORE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetAgentPersonalScoreResult:retmsg:datalist:)])
         {
             [self parseGetAgentPersonalScore:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetAgentPersonalScoreResult:retmsg:datalist:)])
         {
             [delegate GetAgentPersonalScoreResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}


- (void) GetEmployeePersonalScoreMgr
{
    NSString * method_name = SVCCMD_GET_EMPLOYEEPERSONALSCOREMGR;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeePersonalScoreMgrResult:retmsg:datalist:)])
         {
             [self parseGetEmployeePersonalScoreMgr:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetEmployeePersonalScoreMgrResult:retmsg:datalist:)])
         {
             [delegate GetEmployeePersonalScoreMgrResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetAgentPersonalScoreMgr:(int)page_no
{
    NSString * method_name = SVCCMD_GET_AGENTPERSONALSCOREMGR;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetAgentPersonalScoreMgrResult:retmsg:datalist:)])
         {
             [self parseGetAgentPersonalScoreMgr:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(GetAgentPersonalScoreMgrResult:retmsg:datalist:)])
         {
             [delegate GetAgentPersonalScoreMgrResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetReserveLogs:(int)page_no
{
    NSString * method_name = SVCCMD_GET_RESERVELOGS;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithInt:page_no], @"page_no",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(getReserveLogsResult:retmsg:datalist:)])
         {
             [self parseGetReserveLogs:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(getReserveLogsResult:retmsg:datalist:)])
         {
             [delegate getReserveLogsResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) cancelReserve : (long)log_id
{
    NSString * method_name = SVCCMD_CANCEL_RESERVE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:log_id], @"log_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(cancelReserveResult:retmsg:)])
         {
             [self parseCancelReserve:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(cancelReserveResult:retmsg:)])
         {
             [delegate cancelReserveResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) confirmReserve : (long)log_id
{
    NSString * method_name = SVCCMD_CONFIRM_RESERVE;
    
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:method_name];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * checkSum = [Common createCheckSum:method_name];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Common strUserId], @"user_id",
                            [Common strUserType], @"user_type",
                            checkSum, @"check_sum",
                            [NSNumber numberWithLong:log_id], @"log_id",
                            nil];
    
    [manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         if (delegate != nil && [delegate respondsToSelector:@selector(confirmReserveResult:retmsg:)])
         {
             [self parseConfirmReserve:responseObject];
         }
         MyLog(@"Request Successful, response '%@'", responseObject);
     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(confirmReserveResult:retmsg:)])
         {
             [delegate confirmReserveResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE];
         }
         MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}


- (void) checkParentBirthNotify : (long)client_id
{
	NSString * method_name = SVCCMD_CHK_PARENTBIRTHNOTIFY;
	
	NSMutableString *method = [NSMutableString string];
	[method appendString:SVC_BASE_URL];
	[method appendString:method_name];
	
	AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[NSNumber numberWithLong:client_id], @"client_id",
							nil];
	
	[manager GET:method parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject)
	 {
		 if (delegate != nil && [delegate respondsToSelector:@selector(checkParentBirthNotifyResult:retmsg:datalist:)])
		 {
			 [self parseCheckParentBirthNotify:responseObject];
		 }
		 MyLog(@"Request Successful, response '%@'", responseObject);
	 } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
		 if (delegate != nil && [delegate respondsToSelector:@selector(checkParentBirthNotifyResult:retmsg:datalist:)])
		 {
			 [delegate checkParentBirthNotifyResult:SVCERR_FAILURE retmsg:SVCMSG_FAILURE datalist:nil];
		 }
		 MyLog(@"[HTTPClient Error]: %@", error.localizedDescription);
	 }];
}
/////////////////////////////////////////////////////////////////////////////
///////////////////////////////// event implementation //////////////////////
/////////////////////////////////////////////////////////////////////////////

#pragma mark - Service Event Implementation

- (void) parseLoginUser:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STUserInfo * datainfo = [[STUserInfo alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate loginUserResult:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseForgotPwd:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
        }
    }
    
    [delegate forgotPasswordResult:jsonRet retmsg:retmsg];
}


- (void) parseAdverts:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * adverts = [[NSMutableArray alloc] init];
    NSMutableArray * relatives = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            NSDictionary * jsonAdverts = [jsonDic objectForKey:@"adverts"];
            NSDictionary * jsonRelatives = [jsonDic objectForKey:@"relative_dates"];
            
            for (NSDictionary * jsonItem in jsonAdverts)
            {
                STAdvertImage * iteminfo = [[STAdvertImage alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [adverts addObject:iteminfo];
            }
            
            for (NSDictionary * jsonItem in jsonRelatives)
            {
                STRelative * iteminfo = [[STRelative alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [relatives addObject:iteminfo];
            }
        }
    }
    
    [delegate getAdvertsResult:jsonRet retmsg:retmsg adverts:adverts relatives:relatives];
}

- (void) parseActivities:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STActivity * iteminfo = [[STActivity alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getActivitiesResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseNewActCount:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    int count = 0;
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            count = [GlobalFunc getIntValueWithKey:@"count" Dict:jsonDic];
        }
    }
    
    [delegate getNewActCountResult:jsonRet retmsg:retmsg count:count];
}



- (void) parseActDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STActivity * datainfo = [[STActivity alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getActDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseRelativeData:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STRelative * iteminfo = [[STRelative alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getRelativeDataResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseReadActivity:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
        }
    }
    
    [delegate readActivityResult:jsonRet retmsg:retmsg];
}


- (void) parseBills:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STBill * iteminfo = [[STBill alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getBillsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseBillDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STBill * datainfo = [[STBill alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getBillDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseDeputyLogs:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STDeputyLog * iteminfo = [[STDeputyLog alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getDeputyLogsResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseDeputyLogDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STDeputyLog * datainfo = [[STDeputyLog alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getDeputyLogDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseSvcPeopleInfo:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STOfficeEmp * datainfo = [[STOfficeEmp alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getSvcPeopleInfoResult:jsonRet retmsg:retmsg datainfo:datainfo];
}


- (void) parseReserveCeremony:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
        }
    }
    
    [delegate reserveCeremonyResult:jsonRet retmsg:retmsg];
}


- (void) parseActivityProducts:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STProduct * iteminfo = [[STProduct alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getActivityProdResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseGetCustomerList:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STCustomer * iteminfo = [[STCustomer alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetCustomerListResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseTombListForCus:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STTombInfo * iteminfo = [[STTombInfo alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getTombListForCusResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseTombList:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STTombItem * iteminfo = [[STTombItem alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getTombListResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseTombDetail:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STTomb * datainfo = [[STTomb alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    [delegate getTombDetailResult:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseTombStonePlaces:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STTombStoneArea * iteminfo = [[STTombStoneArea alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getTombStonePlacesResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseReserveTombPlace:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
    }
    
    [delegate reserveTombPlaceResult:jsonRet retmsg:retmsg];
}

- (void) parsegetBonusFormula:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    double discount, commis, taxrate;
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            
            NSString *value;
            value = [jsonDic valueForKey:@"discount_limit"];
            discount = [value doubleValue];
            value = [jsonDic valueForKey:@"commission"];
            commis = [value doubleValue];
            value = [jsonDic valueForKey:@"tax_rate"];
            taxrate = [value doubleValue];
        }
    }
    
    [delegate getBonusFormulaResult:jsonRet retmsg:retmsg discount:discount commission:commis tax_rate:taxrate];
}

- (void) parseGetAgents:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STAgents * iteminfo = [[STAgents alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getAgentsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetBonusDetailList:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STBonusDetailInfo * iteminfo = [[STBonusDetailInfo alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getBonusDetailListResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseDepositLogs:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STDepositLog * iteminfo = [[STDepositLog alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getDepositLogsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetBuyProductCount:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    int count = 0;
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            count = [GlobalFunc getIntValueWithKey:@"count" Dict:jsonDic];
        }
    }
    
    [delegate getBuyProductCountResult:jsonRet retmsg:retmsg count:count];
}

- (void) parseBuyProductLogs:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STBuyProductLog * iteminfo = [[STBuyProductLog alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getBuyProductLogsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void)parseBuyProductLogDetails:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    STBuyProductLogDetail * datainfo = [[STBuyProductLogDetail alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            // parse data info
            [datainfo parseFromDictionary:jsonDic];
        }
    }
    
    //[delegate getAreaPointDetail:(NSInteger) retmsg:<#(NSString *)#> datainfo:(STAreaPointDetail *):jsonRet retmsg:retmsg datalist:datalist];
    [delegate getBuyProductLogDetailsResult:jsonRet retmsg:retmsg datainfo:datainfo];
}

- (void) parseOfficeList:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeCity * iteminfo = [[STOfficeCity alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficeListResult:jsonRet retmsg:retmsg datalist:datalist];
    //[delegate GetOfficeListResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetOfficesAttendanceResult:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STVocation * iteminfo = [[STVocation alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficesAttendanceResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetOfficesAttendanceListResult:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STVocationList * iteminfo = [[STVocationList alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficesAttendanceListResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetVocationDatesResult:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STYVocation * iteminfo = [[STYVocation alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getVocationDatesResult:jsonRet retmsg:retmsg datalist:datalist];
}


- (void) parseCancelVocationResult:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    long resultCancelled = -1;
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            
            if (!jsonDic || ![jsonDic isKindOfClass:[NSDictionary class]]
                || [jsonDic count] <= 0)
            {
                
            }
            else
                resultCancelled = [GlobalFunc getLongValueWithKey:@"cancelled_id" Dict:jsonDic];		
        }
    }
    
    [delegate cancelVocationResult:jsonRet retmsg:retmsg cancelled_id:resultCancelled];
}

- (void) parseSubmitVocationResult:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    long resultCancelled = -1;
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            
            if (!jsonDic || ![jsonDic isKindOfClass:[NSDictionary class]]
                || [jsonDic count] <= 0)
            {
                
            }
            else
                resultCancelled = [GlobalFunc getLongValueWithKey:@"cancelled_id" Dict:jsonDic];
        }
    }
    
    [delegate submitVocationResult:jsonRet retmsg:retmsg];
}

- (void) parseGetOfficeDepositLogs:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeDepositLog * iteminfo = [[STOfficeDepositLog alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficesDepositLogsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetOfficesDailyScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeDailyScore * iteminfo = [[STOfficeDailyScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficesDailyScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetEmployeesDailyScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STEmployeeDailyScore * iteminfo = [[STEmployeeDailyScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetEmployeesDailyScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetOfficesCurMonthScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeCurMonthScore * iteminfo = [[STOfficeCurMonthScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficesCurMonthScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetOfficeMonthlyScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STOfficeMonthlyScore * iteminfo = [[STOfficeMonthlyScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetOfficeMonthlyScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetEmployeePersonalScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STScore * iteminfo = [[STScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetEmployeePersonalScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetEmployeePersonalScoreMgr:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STEmpScore_Manager * iteminfo = [[STEmpScore_Manager alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetEmployeePersonalScoreMgrResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetAgentPersonalScore:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STScore * iteminfo = [[STScore alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetAgentPersonalScoreResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetAgentPersonalScoreMgr:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STAgentScore_Manager * iteminfo = [[STAgentScore_Manager alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate GetAgentPersonalScoreMgrResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseGetReserveLogs:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    NSMutableArray * datalist = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
        // check result
        if (jsonRet == SVCERR_SUCCESS)
        {
            NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
            for (NSDictionary * jsonItem in jsonDic)
            {
                STReserveLog * iteminfo = [[STReserveLog alloc] init];
                
                [iteminfo parseFromDictionary:jsonItem];
                [datalist addObject:iteminfo];
            }
        }
    }
    
    [delegate getReserveLogsResult:jsonRet retmsg:retmsg datalist:datalist];
}

- (void) parseCancelReserve:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
    }
    
    [delegate cancelReserveResult:jsonRet retmsg:retmsg];
}

- (void) parseConfirmReserve:(NSDictionary *)responseStr
{
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * retmsg = @"";
    
    if (responseStr)
    {
        // get service result
        jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
        retmsg = [responseStr objectForKey:SVCC_RETMSG];
    }
    
    [delegate confirmReserveResult:jsonRet retmsg:retmsg];
}


- (void) parseCheckParentBirthNotify:(NSDictionary *)responseStr
{
	NSInteger jsonRet = SVCERR_FAILURE;
	NSString * retmsg = @"";
	NSMutableArray * datalist = [[NSMutableArray alloc] init];
	
	if (responseStr)
	{
		// get service result
		jsonRet = [[responseStr objectForKey:SVCC_RET] intValue];
		retmsg = [responseStr objectForKey:SVCC_RETMSG];
		// check result
		if (jsonRet == SVCERR_SUCCESS)
		{
			NSDictionary * jsonDic = [responseStr objectForKey:SVCC_DATA];
			for (NSDictionary * jsonItem in jsonDic)
			{
				STParentBirthNotify * iteminfo = [[STParentBirthNotify alloc] init];
				
				[iteminfo parseFromDictionary:jsonItem];
				[datalist addObject:iteminfo];
			}
		}
	}
	
	[delegate checkParentBirthNotifyResult:jsonRet retmsg:retmsg datalist:datalist];
}
@end
