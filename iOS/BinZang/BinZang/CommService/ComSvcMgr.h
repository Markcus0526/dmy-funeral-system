//
//  ComSvcMgr.h
//  BinZang
//
//  Created by Beids on 5/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComSvcDelegate;

@interface ComSvcMgr : NSObject

@property(strong, nonatomic) id<ComSvcDelegate> delegate;

- (void) GetBannerImages;
- (void) GetCompanyIntro;
- (void) GetAfterService;
- (void) GetFuneralProducts;
- (void) GetOfficeIntros;
- (void) GetOfficeDetail : (long)office_id;
- (void) GetAreaPoints;
- (void) GetAreaPointDetail : (long)area_id;
- (void) Get36Views;
- (void) GetNavDestination;
- (void) Get36ViewDetail : (long)view_id;
- (void) ReserveVisit : (NSString *)phone nick_name:(NSString *)nick_name office_id:(long)office_id reserve_time:(NSString*)reserve_time;

- (void) GetFoodPageUrl;
- (void) GetHotelPageUrl;
- (void) GetJournalPageUrl;
- (void) GetCinemaPageUrl;
- (void) GetGamePageUrl;
- (void) GetExamImageUrl;
- (void) GetMtQiPanViews;
- (void) GetMtQiPanDetail : (long)view_id;
- (void) GetOneDragonAreas;
- (void) GetOneDragonAreaDetail : (long)area_id;
- (void) GetOneDragonCompDetail : (long)service_id;
- (void) GetTombKnowledge;
- (void) LoginUser : (NSString *)user_name password:(NSString *)password;
- (void) ForgetPassword : (NSString *)user_name phone:(NSString *)phone new_password:(NSString *)new_password;
- (void) GetAdverts;
- (void) GetActivities;
- (void) GetNewActCount;
- (void) GetActDetail : (long)activity_id;
- (void) ReadActivity : (long)activity_id;
- (void) GetRelativeData;
- (void) GetBills : (int)page_no;
- (void) GetBillDetail : (long)bill_id;
- (void) GetDeputyLogs : (int)page_no;
- (void) GetDeputyLogDetail : (long)log_id;
- (void) GetSvcPeopleInfo;
- (void) ReserveCerermony : (long)customer_id reserve_time:(NSString *)reserve_time tomb_id:(long)tomb_id is_deputyservice:(bool)is_deputyservice bury_service_id:(long)bury_service_id products:(NSString *)products;
- (void) GetActivityProducts;
- (void) GetTombListForCustomer;
- (void) GetCustomerList;
- (void) GetTombList : (long)area_id;
- (void) GetTombStonePlaces : (long)area_id;
- (void) ReserveTombPlace : (NSString*)customer_name
            customer_phone:(NSString*)customer_phone
             death_people1:(NSString*)death_people1
               mgr_people1:(NSString*)mgr_people1
             death_people2:(NSString*)death_people2
               mgr_people2:(NSString*)mgr_people2
              tomb_area_id:(long)tomb_area_id
              tomb_site_id:(long)tomb_site_id
            tomb_tablet_id:(long)tomb_tablet_id;
- (void) GetAgents;
- (void) GetTombDetail : (long)tomb_id;
- (void) GetBonusFormula;
- (void) GetBonusDetailList : (long)user_id bonus_type:(int)bonus_type page_no:(int)page_no;
- (void) GetDepositLogs :(long) aim_user_id page_no:(int)page_no;
- (void) GetBuyProductCount;
- (void) GetBuyProductLogs :(int) state page_no:(int)page_no;
- (void) GetBuyProductLogDetails : (long)log_id;
- (void) ReadBuyProductLog : (long)log_id;
- (void) GetAgentDepositLogs :(long) aim_user_id page_no:(int)page_no;
- (void) GetVocationDates ;
- (void) SubmitVocation:(int) reason voc_date:(NSString*)voc_date;
- (void) CancelVocation:(long)vocation_id;

- (void) GetOfficeList;
- (void) GetOfficesAttendance : (long) office_id;
- (void) GetOfficesAttendanceList : (long) office_id;
- (void) GetOfficesDepositLogs : (int)page_no;

- (void) GetOfficesDailyScore : (int)page_no;
- (void) GetEmployeesDailyScore : (long) office_id;
- (void) GetOfficesCurMonthScore : (long) month;
- (void) GetOfficeMonthlyScore : (long) office_id;

- (void) GetEmployeePersonalScore : (int)page_no;
- (void) GetEmployeePersonalScoreMgr;
- (void) GetAgentPersonalScore;
- (void) GetAgentPersonalScoreMgr : (int)page_no;

- (void) GetReserveLogs : (int)page_no;
- (void) cancelReserve : (long)log_id;
- (void) confirmReserve : (long)log_id;

- (void) checkParentBirthNotify : (long)client_id;

@end

// service protocol
@protocol ComSvcDelegate <NSObject>

@optional
- (void) getBannerImagesResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getCompanyIntroResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg image_url:(NSString *)image_url contents:(NSString *)contents phone:(NSString *)phone;
- (void) getAfterServiceResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STAfterService *)datainfo;
- (void) getFuneralProdResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getOfficeIntrosResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getOfficeDetailResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STOffice *)datainfo;
- (void) getAreaPointsResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getAreaPointDetail         : (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STAreaPointDetail *)datainfo;
- (void) get36ViewsResult 			: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) get36ViewDetail			: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(ST36View *)datainfo;
- (void) getNavDestination          : (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STGpsPos*) datainfo;

- (void) reserveVisitResult			: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) getFoodPageUrlResult		: (NSInteger)retcode retmsg:(NSString *)retmsg page_url:(NSString *)page_url;
- (void) getHotelPageUrlResult		: (NSInteger)retcode retmsg:(NSString *)retmsg page_url:(NSString *)page_url;
- (void) getJournalPageUrlResult	: (NSInteger)retcode retmsg:(NSString *)retmsg plane_page_url:(NSString *)plane_page_url train_page_url:(NSString *)train_page_url;
- (void) getCinemaPageUrlResult 	: (NSInteger)retcode retmsg:(NSString *)retmsg page_url:(NSString *)page_url;
- (void) getGamePageUrlResult		: (NSInteger)retcode retmsg:(NSString *)retmsg page_url:(NSString *)page_url;
- (void) getExamImageUrlResult		: (NSInteger)retcode retmsg:(NSString *)retmsg worker_img_url:(NSString *)worker_img_url school_img_url:(NSString *)school_img_url photo_img_url:(NSString *)photo_img_url;
- (void) getMtQiPanViewsResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getMTQiPanDetailResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STMtQiPan *)datainfo;
- (void) getOneDragonAreasResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getOneDragonAreaDetResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDragonServiceArea *)datainfo;
- (void) getOneDragonCompDetResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDragonService *)datainfo;
- (void) getTombKnowledgeResult		: (NSInteger)retcode retmsg:(NSString *)retmsg buy_tomb_flow:(NSString *)buy_tomb_flow precaution:(NSString *)precaution bury_custom:(NSString *)bury_custom bury_news_url:(NSString *)bury_news_url;
- (void) loginUserResult			: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STUserInfo *)datainfo;
- (void) forgotPasswordResult		: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) getAdvertsResult			: (NSInteger)retcode retmsg:(NSString *)retmsg adverts:(NSMutableArray *)adverts relatives:(NSMutableArray *)relatives;
- (void) getActivitiesResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getNewActCountResult		: (NSInteger)retcode retmsg:(NSString *)retmsg count:(int)count;
- (void) getBuyProductCountResult		: (NSInteger)retcode retmsg:(NSString *)retmsg count:(int)count;
- (void) getActDetailResult			: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STActivity *)datainfo;
- (void) readActivityResult			: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) getRelativeDataResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getBillsResult				: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getBillDetailResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STBill *)datainfo;
- (void) getDeputyLogsResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getDeputyLogDetailResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDeputyLog *)datainfo;
- (void) getSvcPeopleInfoResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STOfficeEmp *)datainfo;
- (void) reserveCeremonyResult		: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) getActivityProdResult		: (NSInteger)retcode retmsg:(NSString *)retmsg  datalist:(NSMutableArray *)datalist;
- (void) GetCustomerListResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getTombListForCusResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getTombListResult			: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getTombDetailResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STTomb *)datainfo;
- (void) getTombStonePlacesResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) reserveTombPlaceResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) getBonusFormulaResult		: (NSInteger)retcode retmsg:(NSString *)retmsg discount:(double)discount_limit commission:(double) commission tax_rate:(double)tax_rate;
- (void) getDepositLogsResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getBuyProductLogsResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getBuyProductLogDetailsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STBuyProductLogDetail *)datainfo;
- (void) getBonusDetailListResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getAgentsResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) getVocationDatesResult: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;

- (void) cancelVocationResult: (NSInteger)retcode retmsg:(NSString *)retmsg cancelled_id:(long)cancelled_id;
- (void) submitVocationResult				: (NSInteger)retcode retmsg:(NSString *)retmsg;

- (void) GetOfficeListResult 				: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficesAttendanceResult			: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficesAttendanceListResult		: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficesDepositLogsResult 		: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficesDailyScoreResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetEmployeesDailyScoreResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficesCurMonthScoreResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetOfficeMonthlyScoreResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;

- (void) GetEmployeePersonalScoreResult 	: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetAgentPersonalScoreResult 		: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetEmployeePersonalScoreMgrResult 	: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) GetAgentPersonalScoreMgrResult 	: (NSInteger) retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;

- (void) getReserveLogsResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;
- (void) cancelReserveResult	: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) confirmReserveResult	: (NSInteger)retcode retmsg:(NSString *)retmsg;
- (void) checkParentBirthNotifyResult : (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist;

@end

