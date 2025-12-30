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
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
	public class Service : IService
	{
		public SVCResult GetData()
		{
			return ServiceModel.Test();
		}


		public SVCResult getBannerImages(int category)
		{
			return ServiceModel.getBannerImages(category);
		}


		public SVCResult getAreaPoints()
		{
			return ServiceModel.getAreaPoints();
		}


		public SVCResult getAreaPointDetail(long area_id)
		{
			return ServiceModel.getAreaPointDetail(area_id);
		}


		public SVCResult getOneDragonAreas()
		{
			return ServiceModel.getOneDragonAreas();
		}

		public SVCResult getOneDragonAreaDetail(long area_id)
		{
			return ServiceModel.getOneDragonAreaDetail(area_id);
		}

		public SVCResult getOneDragonCompanyDetail(long service_id)
		{
			return ServiceModel.getOneDragonCompanyDetail(service_id);
		}

		public SVCResult getTombKnowledge()
		{
			return ServiceModel.getTombKnowledge();
		}

		public SVCResult getAfterService()
		{
			return ServiceModel.getAfterService();
		}


		public SVCResult getFuneralProducts()
		{
			return ServiceModel.getFuneralProducts();
		}


		public SVCResult get36Views()
		{
			return ServiceModel.get36Views();
		}


		public SVCResult get36ViewDetail(long view_id)
		{
			return ServiceModel.get36ViewDetail(view_id);
		}


		public SVCResult getNavDestination()
		{
			return ServiceModel.getNavDestination();
		}


		public SVCResult getOfficeIntros()
		{
			return ServiceModel.getOfficeIntros();
		}


		public SVCResult getOfficeDetail(long office_id)
		{
			return ServiceModel.getOfficeDetail(office_id);
		}

		public SVCResult getCompanyIntro()
		{
			return ServiceModel.getCompanyIntro();
		}


		public SVCResult getFoodPageUrl()
		{
			return ServiceModel.getFoodPageUrl();
		}


		public SVCResult getShopPageUrl()
		{
			return ServiceModel.getShopPageUrl();
		}


		public SVCResult getHotelPageUrl()
		{
			return ServiceModel.getHotelPageUrl();
		}


		public SVCResult getJournalPageUrl()
		{
			return ServiceModel.getJournalPageUrl();
		}


		public SVCResult getCinemaPageUrl()
		{
			return ServiceModel.getCinemaPageUrl();
		}


		public SVCResult getGamePageUrl()
		{
			return ServiceModel.getGamePageUrl();
		}


		public SVCResult getExamTimeTableImageUrl()
		{
			return ServiceModel.getExamTimeTableImageUrl();
		}


		public SVCResult getMtQiPanViews(int page_no)
		{
			return ServiceModel.getMtQiPanViews(page_no);
		}


		public SVCResult getMtQiPanViewDetail(long view_id)
		{
			return ServiceModel.getMtQiPanViewDetail(view_id);
		}


		public SVCResult reserveVisit(String phone, String nick_name, long office_id, String reserve_time)
		{
			return ServiceModel.reserveVisit(phone, nick_name, office_id, reserve_time);
		}


		public SVCResult loginUser(String user_name, String password, int platform, String device_token)
		{
			return ServiceModel.loginUser(user_name, password, platform, device_token);
		}


		public SVCResult forgotPassword(String user_name, String phone, String new_password)
		{
			return ServiceModel.forgotPassword(user_name, phone, new_password);
		}


		public SVCResult getAdverts(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getAdverts(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getActivities(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getActivities(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getNewActivityCount(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getNewActivityCount(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getActivityDetail(long user_id, int user_type, long activity_id, String check_sum)
		{
			return ServiceModel.getActivityDetail(user_id, user_type, activity_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult readActivity(long user_id, int user_type, long activity_id, String check_sum)
		{
			return ServiceModel.readActivity(user_id, user_type, activity_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getRelativeData(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getRelativeData(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getRelativeDateCount(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getRelativeDateCount(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getBills(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getBills(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getBillDetail(long user_id, int user_type, long bill_id, String check_sum)
		{
			return ServiceModel.getBillDetail(user_id, user_type, bill_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getDeputyLogs(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getDeputyLogs(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getDeputyLogDetail(long user_id, int user_type, long log_id, String check_sum)
		{
			return ServiceModel.getDeputyLogDetail(user_id, user_type, log_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult getServicePeopleInfo(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getServicePeopleInfo(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getTombListForCustomer(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getTombListForCustomer(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult reserveCeremony(long user_id,
			int user_type,
			long customer_id,
			String reserve_time,
			long tomb_id,
            int is_deputyservice,
			long bury_service_id,
			String products,
			String check_sum)
		{
			return ServiceModel.reserveCeremony(user_id,
				user_type,
				customer_id,
				reserve_time,
				tomb_id,
                is_deputyservice,
				bury_service_id,
				products,
				check_sum,
				System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getActivityProducts(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getActivityProducts(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getBonusFormula(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getBonusFormula(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getBonusDetailList(long user_id, int user_type, int bonus_type, int page_no, String check_sum)
		{
            return ServiceModel.getBonusDetailList(user_id, user_type, bonus_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum)
		{
			return ServiceModel.getDepositLogs(user_id, user_type, aim_user_id, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getAgentDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum)
		{
			return ServiceModel.getAgentDepositLogs(user_id, user_type, aim_user_id, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getCustomerList(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getCustomerList(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getTombList(long user_id, int user_type, long area_id, String check_sum)
		{
			return ServiceModel.getTombList(user_id, user_type, area_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getTombDetail(long user_id, int user_type, long tomb_id, String check_sum)
		{
			return ServiceModel.getTombDetail(user_id, user_type, tomb_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getTombStonePlaces(long area_id, long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getTombStonePlaces(area_id, user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult reserveTombPlace(long user_id,
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
			String check_sum)
		{
			return ServiceModel.reserveTombPlace(user_id,
				user_type,
				customer_name,
                customer_phone,
				death_people1,
				mgr_people1,
				death_people2,
				mgr_people2,
				tomb_area_id,
				tomb_site_id,
                tomb_tablet_id,
				check_sum,
				System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getAgents(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getAgents(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getBuyProductCount(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getBuyProductCount(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getBuyProductLogs(long user_id, int user_type, int page_no, int state, String check_sum)
		{
			return ServiceModel.getBuyProductLogs(user_id, user_type, page_no, state, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getBuyProductLogDetail(long user_id, int user_type, long log_id, String check_sum)
		{
			return ServiceModel.getBuyProductLogDetail(user_id, user_type, log_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult readBuyProductLog(long user_id, int user_type, long log_id, String check_sum)
		{
			return ServiceModel.readBuyProductLog(user_id, user_type, log_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getVocationDates(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getVocationDates(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult cancelVocation(long user_id, int user_type, long vocation_id, String check_sum)
		{
			return ServiceModel.cancelVocation(user_id, user_type, vocation_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult submitVocation(long user_id, int user_type, int reason, String date, String check_sum)
		{
			return ServiceModel.submitVocation(user_id, user_type, reason, date, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getOfficeList(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getOfficeList(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getOfficeAttendance(long user_id, int user_type, long office_id, String check_sum)
		{
			return ServiceModel.getOfficeAttendance(user_id, user_type, office_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


        public SVCResult getOfficeAttendanceList(long user_id, int user_type, long office_id, String check_sum)
        {
            return ServiceModel.getOfficeAttendanceList(user_id, user_type, office_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
        }


		public SVCResult getOfficesCurMonthScore(long user_id, int user_type, int month, String check_sum)
		{
			return ServiceModel.getOfficesCurMonthScore(user_id, user_type, month, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getOfficeMonthlyScore(long user_id, int user_type, long office_id, String check_sum)
		{
			return ServiceModel.getOfficeMonthlyScore(user_id, user_type, office_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getEmployeesDailyScore(long user_id, int user_type, long office_id, String check_sum)
		{
			return ServiceModel.getEmployeesDailyScore(user_id, user_type, office_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getOfficesDailyScore(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getOfficesDailyScore(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getEmployeePersonalScore(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getEmployeePersonalScore(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getEmployeePersonalScoreMgr(long user_id, int user_type, String check_sum)
		{
			return ServiceModel.getEmployeePersonalScoreMgr(user_id, user_type, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getAgentPersonalScore(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getAgentPersonalScore(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getAgentPersonalScoreMgr(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getAgentPersonalScoreMgr(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getOfficesDepositLogs(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getOfficesDepositLogs(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult getReserveLogs(long user_id, int user_type, int page_no, String check_sum)
		{
			return ServiceModel.getReserveLogs(user_id, user_type, page_no, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}


		public SVCResult cancelReserve(long user_id, int user_type, long log_id, String check_sum)
		{
			return ServiceModel.cancelReserve(user_id, user_type, log_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

		public SVCResult confirmReserve(long user_id, int user_type, long log_id, String check_sum)
		{
			return ServiceModel.confirmReserve(user_id, user_type, log_id, check_sum, System.Reflection.MethodBase.GetCurrentMethod().Name);
		}

        public SVCResult dailyPerformanceReport()
        {
            return ServiceModel.dailyPerformanceReport();
        }

        public SVCResult clientParentBirthdayRemind()
        {
            return ServiceModel.clientParentBirthdayRemind();
        }

        public SVCResult checkParentBirthNotify(long client_id)
        {
            return ServiceModel.checkParentBirthNotify(client_id);
        }
	}
}
