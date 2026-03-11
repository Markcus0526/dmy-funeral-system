//
//  ServiceMethod.h
//  BinZang
//
//  Created by KimOkChol on 4/13/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#ifndef BinZang_ServiceMethod_h
#define BinZang_ServiceMethod_h

#define SVCERR_SUCCESS                      0
#define SVCERR_FAILURE                      -1

#define SVCMSG_SUCCESS                      @"操作成功"
#define SVCMSG_FAILURE                      @"网络不给力，操作失败"


#define SVC_BASE_URL                        @"http://218.60.131.41:10291/Service.svc/"
//#define SVC_BASE_URL                        @"http://192.168.1.45:10480/Service.svc/"
//#define SVC_BASE_URL                        @"http://192.168.1.18:10241/Service.svc/"

//------------------------- Visitor ----------------------//
#define SVCCMD_GET_AFTERSVC					@"getAfterService"
#define SVCCMD_GET_BANNERIMGS				@"getBannerImages"
#define SVCCMD_GET_COMPANYINTRO				@"getCompanyIntro"
#define SVCCMD_GET_FUNERALPROD				@"getFuneralProducts"
#define SVCCMD_GET_OFFICEINTROS				@"getOfficeIntros"
#define SVCCMD_GET_OFFICEDETAIL				@"getOfficeDetail"
#define SVCCMD_GET_AREAPOINTS				@"getAreaPoints"
#define SVCCMD_GET_AREAPOINTDETAIL			@"getAreaPointDetail"
#define SVCCMD_GET_36VIEWS					@"get36Views"
#define SVCCMD_GET_36DETAIL					@"get36ViewDetail"
#define SVCCMD_GET_NAVDESTINATION			@"getNavDestination"
#define SVCCMD_RSRV_VISIT					@"reserveVisit"
#define SVCCMD_GET_FOODPAGEURL				@"getFoodPageUrl"
#define SVCCMD_GET_SHOPPAGEURL				@"getShopPageUrl"
#define SVCCMD_GET_HOTELPAGEURL				@"getHotelPageUrl"
#define SVCCMD_GET_JOURNALPAGEURL			@"getJournalPageUrl"
#define SVCCMD_GET_CINEMAPAGEURL			@"getCinemaPageUrl"
#define SVCCMD_GET_GAMEPAGEURL				@"getGamePageUrl"
#define SVCCME_GET_EXAMIMAGEURL				@"getExamTimetableImageUrl"
#define SVCCMD_GET_MTQIPANVIEWS				@"getMtQiPanViews"
#define SVCCMD_GET_MTQIPANDET				@"getMtQiPanViewDetail"
#define SVCCMD_GET_ONEDDRAGONAREAS			@"getOneDragonAreas"
#define SVCCMD_GET_ONEDGRAGONAREADET		@"getOneDragonAreaDetail"
#define SVCCMD_GET_ONEDGRAGONCOMPDET		@"getOneDragonCompanyDetail"
#define SVCCMD_GET_TOMBKNOWLEDGE			@"getTombKnowledge"

//------------------------- Customer ---------------------------//
#define SVCCMD_LOGIN						@"loginUser"
#define SVCCMD_FORGOTPWD					@"forgotPassword"
#define SVCCMD_GET_ADVERTS					@"getAdverts"
#define SVCCMD_GET_ACTIVITIES				@"getActivities"
#define SVCCMD_GET_NEWACTCOUNT				@"getNewActivityCount"
#define SVCCMD_GET_BUYPRODUCTACTCOUNT		@"getBuyProductCount"
#define SVCCMD_GET_ACTDETAIL				@"getActivityDetail"
#define SVCCMD_READ_ACTIVITY				@"readActivity"
#define SVCCMD_GET_RELATIVEDATA				@"getRelativeData"
#define SVCCMD_GET_BILLS					@"getBills"
#define SVCCMD_GET_BILLDETAIL				@"getBillDetail"
#define SVCCMD_GET_DEPUTYLOGS				@"getDeputyLogs"
#define SVCCMD_GET_DEPUTYDETAIL				@"getDeputyLogDetail"
#define SVCCMD_GET_SVCPEOPLEINFO			@"getServicePeopleInfo"
#define SVCCMD_RSRV_CEREMONY				@"reserveCeremony"
#define SVCCMD_GET_ACTPRODUCTS				@"getActivityProducts"
#define SVCCMD_GET_TOMBLIST					@"getTombList"
#define SVCCMD_GET_TOMBDETAIL				@"getTombDetail"
#define SVCCMD_GET_TOMBLISTFORCUS			@"getTombListForCustomer"
#define SVCCMD_GET_CUSTOMERLIST				@"getCustomerList"
#define SVCCMD_GET_TOMBSTONEPLACES			@"getTombStonePlaces"
#define SVCCMD_RSRV_TOMBPLACE				@"reserveTombPlace"
#define SVCCMD_GET_BONUSFORMULA				@"getBonusFormula"
#define SVCCMD_GET_BONUSDETAILLIST			@"getBonusDetailList"
#define SVCCMD_GET_AGENTS                   @"getAgents"
#define SVCCMD_GET_DEPOSITLOGS				@"getDepositLogs"
#define SVCCMD_GET_BUYPRODUCTLOGS			@"getBuyProductLogs"
#define SVCCMD_GET_BUYPRODUCTLOGDETAIL		@"getBuyProductLogDetail"
#define SVCCMD_READBYPRODUCTLOG             @"readBuyProductLog"
#define SVCCMD_GET_AGENTDEPOSITLOGS			@"getAgentDepositLogs"
#define SVCCMD_GET_RESERVELOGS				@"getReserveLogs"
#define SVCCMD_CANCEL_RESERVE				@"cancelReserve"
#define SVCCMD_CONFIRM_RESERVE				@"confirmReserve"
#define SVCCMD_GET_VOCATION_DATES           @"getVocationDates"
#define SVCCMD_CANCEL_VOCATION              @"cancelVocation"
#define SVCCMD_SUBMIT_VOCATION              @"submitVocation"
#define SVCCMD_GET_OFFICELIST				@"getOfficeList"
#define SVCCMD_GET_OFFICES_ATTENDANCE		@"getOfficeAttendance"
#define SVCCMD_GET_OFFICES_ATTENDANCELIST	@"getOfficeAttendanceList"
#define SVCCMD_GET_OFFICES_DAILYSCORE		@"getOfficesDailyScore"
#define SVCCMD_GET_EMPLOYEES_DAILYSCORE		@"getEmployeesDailyScore"
#define SVCCMD_GET_OFFICES_CURMONTHSCORE	@"getOfficesCurMonthScore"
#define SVCCMD_GET_OFFICE_MONTHLYSCORE		@"getOfficeMonthlyScore"

#define SVCCMD_GET_OFFICEDEPOSITLOGS		@"getOfficesDepositLogs"

#define SVCCMD_GET_EMPLOYEEPERSONALSCORE	@"getEmployeePersonalScore"
#define SVCCMD_GET_AGENTPERSONALSCORE		@"getAgentPersonalScore"
#define SVCCMD_GET_EMPLOYEEPERSONALSCOREMGR @"getEmployeePersonalScoreMgr"
#define SVCCMD_GET_AGENTPERSONALSCOREMGR	@"getAgentPersonalScoreMgr"

#define SVCCMD_CHK_PARENTBIRTHNOTIFY		@"checkParentBirthNotify"

#endif
