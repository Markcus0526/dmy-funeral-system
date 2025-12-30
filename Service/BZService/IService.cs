using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using BZService.SvcManager;

namespace BZService
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService" in both code and config file together.
	[ServiceContract]
	public interface IService
	{
		[WebGet, OperationContract]
		SVCResult GetData();

		// TODO: Add your service operations here
        [WebGet(UriTemplate = "/getBannerImages?category={category}"),
        OperationContract]
		SVCResult getBannerImages(int category);

		[WebGet, OperationContract]
		SVCResult getAreaPoints();

		[WebGet, OperationContract]
		SVCResult getAreaPointDetail(long area_id);

		[WebGet, OperationContract]
		SVCResult getOneDragonAreas();

		[WebGet, OperationContract]
		SVCResult getOneDragonAreaDetail(long area_id);

		[WebGet, OperationContract]
		SVCResult getOneDragonCompanyDetail(long service_id);

		[WebGet, OperationContract]
		SVCResult getTombKnowledge();

		[WebGet, OperationContract]
		SVCResult getAfterService();

		[WebGet, OperationContract]
		SVCResult getFuneralProducts();

		[WebGet, OperationContract]
		SVCResult get36Views();

		[WebGet, OperationContract]
		SVCResult get36ViewDetail(long view_id);

		[WebGet, OperationContract]
		SVCResult getNavDestination();

		[WebGet, OperationContract]
		SVCResult getOfficeIntros();

		[WebGet, OperationContract]
		SVCResult getOfficeDetail(long office_id);

		[WebGet, OperationContract]
		SVCResult getCompanyIntro();



		[WebGet, OperationContract]
		SVCResult getFoodPageUrl();

		[WebGet, OperationContract]
		SVCResult getShopPageUrl();

		[WebGet, OperationContract]
		SVCResult getHotelPageUrl();

		[WebGet, OperationContract]
		SVCResult getJournalPageUrl();

		[WebGet, OperationContract]
		SVCResult getCinemaPageUrl();

		[WebGet, OperationContract]
		SVCResult getGamePageUrl();

		[WebGet, OperationContract]
		SVCResult getExamTimeTableImageUrl();

		[WebGet, OperationContract]
		SVCResult getMtQiPanViews(int page_no);

		[WebGet, OperationContract]
		SVCResult getMtQiPanViewDetail(long view_id);

		[WebGet, OperationContract]
		SVCResult reserveVisit(String phone, String nick_name, long office_id, String reserve_time);



		[WebGet, OperationContract]
		SVCResult loginUser(String user_name, String password, int platform, String device_token);

		[WebGet, OperationContract]
		SVCResult forgotPassword(String user_name, String phone, String new_password);

		[WebGet, OperationContract]
		SVCResult getAdverts(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getActivities(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getNewActivityCount(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getActivityDetail(long user_id, int user_type, long activity_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult readActivity(long user_id, int user_type, long activity_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getRelativeData(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getRelativeDateCount(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBills(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBillDetail(long user_id, int user_type, long bill_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getDeputyLogs(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getDeputyLogDetail(long user_id, int user_type, long log_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getServicePeopleInfo(long user_id, int user_type, String check_sum);


		[WebGet, OperationContract]
		SVCResult getTombListForCustomer(long user_id, int user_type, String check_sum);


		[WebInvoke(Method = "POST",
			BodyStyle = WebMessageBodyStyle.WrappedRequest,
			RequestFormat = WebMessageFormat.Json,
			ResponseFormat = WebMessageFormat.Json)]
		SVCResult reserveCeremony(long user_id,
			int user_type,
			long customer_id,
			String reserve_time,
			long tomb_id,
            int is_deputyservice,
			long bury_service_id,
			String products,
			String check_sum);

		[WebGet, OperationContract]
		SVCResult getActivityProducts(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBonusFormula(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBonusDetailList(long user_id, int user_type, int bonus_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getAgentDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getCustomerList(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getTombList(long user_id, int user_type, long area_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getTombDetail(long user_id, int user_type, long tomb_id, String check_sum);
        
		[WebGet, OperationContract]
		SVCResult getTombStonePlaces(long area_id, long user_id, int user_type, String check_sum);

 		[WebInvoke(Method = "POST",
 			BodyStyle = WebMessageBodyStyle.WrappedRequest,
 			RequestFormat = WebMessageFormat.Json,
 			ResponseFormat = WebMessageFormat.Json)]
		SVCResult reserveTombPlace(long user_id,
			int user_type,
			String customer_name,
            String customer_phone,
			String death_people1,
			String mgr_people1,
			String death_people2,
			String mgr_people2,
			long tomb_area_id,
            long tomb_site_id,
            long tomb_tablet_id,
			String check_sum);

		[WebGet, OperationContract]
		SVCResult getAgents(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBuyProductCount(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBuyProductLogs(long user_id, int user_type, int page_no, int state, String check_sum);

		[WebGet, OperationContract]
		SVCResult getBuyProductLogDetail(long user_id, int user_type, long log_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult readBuyProductLog(long user_id, int user_type, long log_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getVocationDates(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult cancelVocation(long user_id, int user_type, long vocation_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult submitVocation(long user_id, int user_type, int reason, String date, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficeList(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficeAttendance(long user_id, int user_type, long office_id, String check_sum);

        [WebGet, OperationContract]
        SVCResult getOfficeAttendanceList(long user_id, int user_type, long office_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficesCurMonthScore(long user_id, int user_type, int month, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficeMonthlyScore(long user_id, int user_type, long office_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getEmployeesDailyScore(long user_id, int user_type, long office_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficesDailyScore(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getEmployeePersonalScore(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getEmployeePersonalScoreMgr(long user_id, int user_type, String check_sum);

		[WebGet, OperationContract]
		SVCResult getAgentPersonalScore(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getAgentPersonalScoreMgr(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getOfficesDepositLogs(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult getReserveLogs(long user_id, int user_type, int page_no, String check_sum);

		[WebGet, OperationContract]
		SVCResult cancelReserve(long user_id, int user_type, long log_id, String check_sum);

		[WebGet, OperationContract]
		SVCResult confirmReserve(long user_id, int user_type, long log_id, String check_sum);

        [WebGet, OperationContract]
        SVCResult dailyPerformanceReport();

        [WebGet, OperationContract]
        SVCResult clientParentBirthdayRemind();

        [WebGet, OperationContract]
        SVCResult checkParentBirthNotify(long client_id);
	}

}
