package com.damytech.communication;

import com.damytech.structure.baidu.*;
import com.damytech.structure.custom.*;

import java.util.ArrayList;

/**
 * Created by KimHM on 2015-01-30.
 */
public class CommDelegate {
	/**
	 * Public api results
	 */
	public void requestWeatherInfoResult(int retcode,
										 String retmsg,
										 ArrayList<STBaiduWeather> arrWeatherInfos) {}

	public void google2baiduResult(int retcode,
								   String retmsg,
								   double latitude,
								   double longitude) {}

	public void reverseGeocodeResult(int retcode,
									 String retmsg,
									 STBaiduGeocode geocode) {}

	public void nearbySearchResult(int retcode,
								   String retmsg,
								   ArrayList<STBaiduNearbyPlace> arrPlaces) {}

	public void placeDetailResult(int retcode,
								  String retmsg,
								  ArrayList<STBaiduPlaceDetail> arrPlaces) {}


	/**
	 * Project api results.
	 */
	public void getBannerImagesResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages) {}
	public void getAreaPointsResult(int retcode, String retmsg, ArrayList<STAreaPoint> arrPoints) {}
	public void getAreaPointDetailResult(int retcode, String retmsg, STAreaPoint point_info) {}
	public void getOneDragonAreasResult(int retcode, String retmsg, ArrayList<STDragonServiceCity> arrCities) {}
	public void getOneDragonAreaDetailResult(int retcode, String retmsg, STDragonServiceArea area_info) {}
	public void getOneDragonCompanyDetailResult(int retcode, String retmsg, STDragonService service_info) {}
	public void getTombKnowledgeResult(int retcode, String retmsg, STTombKnowledge knowledge) {}
	public void getAfterServiceResult(int retcode, String retmsg, STAfterService afterService) {}
	public void getFuneralProductsResult(int retcode, String retmsg, ArrayList<STProduct> arrFuneralProducts) {}
	public void get36ViewsResult(int retcode, String retmsg, ArrayList<ST36View> arrViews) {}
	public void get36ViewDetailResult(int retcode, String retmsg, ST36View view_info) {}
	public void getNavDestinationResult(int retcode, String retmsg, double lat, double lng) {}
	public void getOfficeIntrosResult(int retcode, String retmsg, ArrayList<STOfficeCity> arrCities) {}
	public void getOfficeDetailResult(int retcode, String retmsg, STOffice office_info) {}
	public void getCompanyIntroResult(int retcode, String retmsg, String contents, String phone, String image_url) {}
	public void getFoodPageUrlResult(int retcode, String retmsg, String page_url) {}
	public void getShopPageUrlResult(int retcode, String retmsg, String page_url) {}
	public void getHotelPageUrlResult(int retcode, String retmsg, String page_url) {}
	public void getJournalPageUrlResult(int retcode, String retmsg, String plane_url, String train_url) {}
	public void getCinemaPageUrlResult(int retcode, String retmsg, String page_url) {}
	public void getGamePageUrlResult(int retcode, String retmsg, String page_url) {}
	public void getExamTimeTableImageUrlResult(int retcode, String retmsg, String worker_url, String school_url, String photo_url) {}
	public void getMtQiPanViewsResult(int retcode, String retmsg, ArrayList<STMtQiPanView> arrViews) {}
	public void getMtQiPanViewDetailResult(int retcode, String retmsg, STMtQiPanView view_info) {}
	public void reserveVisitResult(int retcode, String retmsg) {}
	public void loginUserResult(int retcode, String retmsg, long user_id, String user_realname, String access_token, int user_type, long office_id, String office_name, String id_image_url) {}
	public void forgotPasswordResult(int retcode, String retmsg) {}
	public void getAdvertsResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrAdverts, ArrayList<STRelative> arrRelatives) {}
	public void getActivitiesResult(int retcode, String retmsg, ArrayList<STActivity> arrActivities) {}
	public void getNewActivityCountResult(int retcode, String retmsg, int count) {}
	public void getActivityDetailResult(int retcode, String retmsg, STActivity activity_info) {}
	public void readActivityResult(int retcode, String retmsg) {}
	public void getRelativeDataResult(int retcode, String retmsg, ArrayList<STRelative> arrRelatives) {}
	public void getBillsResult(int retcode, String retmsg, ArrayList<STBill> arrBills) {}
	public void getBillDetailResult(int retcode, String retmsg, STBill bill_info) {}
	public void getDeputyLogsResult(int retcode, String retmsg, ArrayList<STDeputyLog> arrDeputyLogs) {}
	public void getDeputyLogDetailResult(int retcode, String retmsg, STDeputyLog deputy_log) {}
	public void getServicePeopleInfoResult(int retcode, String retmsg, STEmployee employee) {}
	public void getTombListForCustomerResult(int retcode, String retmsg, ArrayList<STTomb> arrTombs) {}
	public void reserveCeremonyResult(int retcode, String retmsg) {}
	public void getActivityProductsResult(int retcode, String retmsg, ArrayList<STProduct> arrProducts) {}
	public void getBonusFormulaResult(int retcode, String retmsg, double discount_limit, double commission, double tax_rate) {}
	public void getBonusDetailListResult(int retcode, String retmsg, ArrayList<STBonusLog> arrLogs) {}
	public void getDepositLogsResult(int retcode, String retmsg, ArrayList<STDepositLog> arrLogs) {}
	public void getAgentDepositLogsResult(int retcode, String retmsg, ArrayList<STDepositLog> arrLogs) {}
	public void getCustomerListResult(int retcode, String retmsg, ArrayList<STCustomer> arrCustomers) {}
	public void getTombListResult(int retcode, String retmsg, ArrayList<STTomb> arrTombs) {}
	public void getTombDetailResult(int retcode, String retmsg, STTomb tomb_detail) {}
	public void getTombStonePlacesResult(int retcode, String retmsg, ArrayList<STTombStoneArea> arrTombStoneAreas) {}
	public void reserveTombPlaceResult(int retcode, String retmsg) {}
	public void getAgentsResult(int retcode, String retmsg, ArrayList<STAgent> arrAgents) {}
	public void getBuyProductCountResult(int retcode, String retmsg, int count) {}
	public void getBuyProductLogsResult(int retcode, String retmsg, ArrayList<STBuyProductLog> arrBuyProductLogs) {}
	public void getBuyProductLogDetailResult(int retcode, String retmsg, STBuyProductLog log_detail_info) {}
	public void readBuyProductLogResult(int retcode, String retmsg) {}
	public void getVocationDatesResult(int retcode, String retmsg, ArrayList<STVocation> arrVocations) {}
	public void cancelVocationResult(int retcode, String retmsg, long cancelled_id) {}
	public void submitVocationResult(int retcode, String retmsg) {}
	public void getOfficeListResult(int retcode, String retmsg, ArrayList<STOfficeCity> arrCities) {}
	public void getOfficeAttendanceResult(int retcode, String retmsg, ArrayList<STVocation> arrVocations) {}
	public void getOfficesCurMonthScoreResult(int retcode, String retmsg, ArrayList<STMonthlyScore> arrScores) {}
	public void getOfficeMonthlyScoreResult(int retcode, String retmsg, ArrayList<STMonthlyScore> arrScores) {}
	public void getEmployeesDailyScoreResult(int retcode, String retmsg, ArrayList<STDailyScore> arrScores) {}
	public void getOfficesDailyScoreResult(int retcode, String retmsg, ArrayList<STDailyScore> arrScores) {}
	public void getEmployeePersonalScoreResult(int retcode, String retmsg, ArrayList<STPersonalScore_Boss> arrScores) {}
	public void getEmployeePersonalScoreMgrResult(int retcode, String retmsg, ArrayList<STEmpScore_Manager> arrScores) {}
	public void getAgentPersonalScoreResult(int retcode, String retmsg, ArrayList<STPersonalScore_Boss> arrScores) {}
	public void getOfficesDepositLogsResult(int retcode, String retmsg, ArrayList<STOfficeDepositLog> arrLogs) {}
	public void getAgentPersonalScoreMgrResult(int retcode, String retmsg, ArrayList<STAgentScore_Mgr> arrScores) {}
	public void getReserveLogsResult(int retcode, String retmsg, ArrayList<STReserveLog> arrLogs) {}
	public void cancelReserveResult(int retcode, String retmsg, long cancelled_id) {}
	public void confirmReserveResult(int retcode, String retmsg, long confirmed_id) {}
	public void checkParentBirthNotifyResult(int retcode, String retmsg, ArrayList<STParentBirthNotify> arrNotify) {}
}

