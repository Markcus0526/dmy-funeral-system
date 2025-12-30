using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BZService.SvcManager
{
	public class ConstMgr
	{
		#region Number Constants
		#endregion


		#region String Constants
		#endregion


		#region Environment Constants
		#endregion


        public enum TombServiceType
        {
            TOMB_SERVICE_TYPE_LUOZANG,
            TOMB_SERVICE_TYPE_JIBAI,
            TOMB_SERVICE_TYPE_DAIJIBAI,
        }

        public static String getServiceTypeDesc(int type)
        {
            String result = "";

            switch ((TombServiceType)type)
            {
                case TombServiceType.TOMB_SERVICE_TYPE_LUOZANG:
                    result = "落葬仪式";
                    break;
                case TombServiceType.TOMB_SERVICE_TYPE_JIBAI:
                    result = "自行祭拜";
                    break;
                case TombServiceType.TOMB_SERVICE_TYPE_DAIJIBAI:
                    result = "代祭拜";
                    break;                
            }

            return result;
        }

		public enum DeleteState
		{
			DELETE_STATE_NOT_DELETED,
			DELETE_STATE_DELETED,
		}


		public enum MobilePlatform
		{
			MOBILE_PLATFORM_ANDROID,
			MOBILE_PLATFORM_IOS,
		}


		public enum UserType
		{
			USER_TYPE_ADMIN = 0,		// 超管
            USER_TYPE_CHAIRMAN,
            USER_TYPE_GENERALMANAGER,
            USER_TYPE_VICE_GENERALMANAGER,
            USER_TYPE_MANAGER,			// 主任
            USER_TYPE_VICE_MANAGER,		// 副主任
			USER_TYPE_EMPLOYEE,			// 员工
			USER_TYPE_AGENT,			// 代销商			
            USER_TYPE_CUSTOMER,			// 旧客户
		}

        public static String getUserTypeDesc(int userType)
        {
            String result = "";

            switch ((UserType)userType)
            {
                case UserType.USER_TYPE_ADMIN:
                    result = "超管";
                    break;
                case UserType.USER_TYPE_CHAIRMAN:
                    result = "董事长";
                    break;
                case UserType.USER_TYPE_GENERALMANAGER:
                    result = "总经理";
                    break;
                case UserType.USER_TYPE_VICE_GENERALMANAGER:
                    result = "副总经理";
                    break;
                case UserType.USER_TYPE_MANAGER:
                    result = "主任";
                    break;
                case UserType.USER_TYPE_VICE_MANAGER:
                    result = "副主任";
                    break;
                case UserType.USER_TYPE_EMPLOYEE:
                    result = "员工";
                    break;
                case UserType.USER_TYPE_AGENT:
                    result = "代销商";
                    break;
                case UserType.USER_TYPE_CUSTOMER:
                    result = "旧客户";
                    break;
            }

            return result;
        }

		public enum BillState
		{
			BILL_STATE_RESERVED,		// 已预约
			BILL_STATE_CANCELD,		    // 已取消
            BILL_STATE_PERFORMED,		// 已执行
            BILL_STATE_CLIENT_READ,		// 客户已读
		}


		public static String getBillStateDesc(int billState)
		{
			String result = "";

			switch ((BillState)billState)
			{
                case BillState.BILL_STATE_RESERVED:
                    result = "已预约";
					break;
                case BillState.BILL_STATE_CANCELD:
                    result = "已取消";
					break;
                case BillState.BILL_STATE_PERFORMED:
                    result = "已执行";
                    break;
                case BillState.BILL_STATE_CLIENT_READ:
                    result = "客户已读";
                    break;
			}

			return result;
		}


		public enum ProductType
		{
			PRODUCT_TYPE_FLOWER,			// 鲜花
			PRODUCT_TYPE_BURIALS,			// 随葬品
			PRODUCT_TYPE_MEAL,				// 供饭
			PRODUCT_TYPE_OTHERS,			// 其他
            PRODUCT_TYPE_CEREMONY,			// 法会活动祭品
		}


		public static String getProductTypeDesc(int type)
		{
			String result = "";

			switch ((ProductType)type)
			{
				case ProductType.PRODUCT_TYPE_FLOWER:
					result = "鲜花";
					break;
				case ProductType.PRODUCT_TYPE_BURIALS:
					result = "随葬品";
					break;
				case ProductType.PRODUCT_TYPE_MEAL:
					result = "供饭";
					break;
				case ProductType.PRODUCT_TYPE_OTHERS:
					result = "其他";
					break;
                case ProductType.PRODUCT_TYPE_CEREMONY:
                    result = "法会活动祭品";
                    break;
			}

			return result;
		}


		public enum TombState
		{
			TOMB_STATE_EMPTY,				// 空位
			TOMB_STATE_RESERVED,			// 已保留
			TOMB_STATE_DEPOSIT,				// 已付定
			TOMB_STATE_SOLD,				// 已购买
            TOMB_STATE_INVALID,				// 无效
		}


		public static String getTombStateDesc(int state)
		{
			String result = "";

			switch ((TombState)state)
			{
				case TombState.TOMB_STATE_EMPTY:
					result = "空位";
					break;
				case TombState.TOMB_STATE_RESERVED:
					result = "已保留";
					break;
				case TombState.TOMB_STATE_DEPOSIT:
					result = "已付定";
					break;
				case TombState.TOMB_STATE_SOLD:
					result = "已购买";
					break;
			}

			return result;
		}


		public enum BuyProductState
		{
			TOMB_STATE_WAITING,					// 待执行
			TOMB_STATE_COMPLETED,				// 已执行
		}


		public static String getBuyProductStateDesc(int state)
		{
			String result = "";

			switch ((BuyProductState)state)
			{
				case BuyProductState.TOMB_STATE_WAITING:
					result = "待执行";
					break;
				case BuyProductState.TOMB_STATE_COMPLETED:
					result = "已执行";
					break;
			}

			return result;
		}


		public enum VocationType
		{
			VOCATION_TYPE_NORMAL,					// 列休
			VOCATION_TYPE_ILLNESS,					// 病休
			VOCATION_TYPE_OTHER,					// 其他
		}


		public static String getVocationTypeDesc(int state)
		{
			String result = "";

			switch ((VocationType)state)
			{
				case VocationType.VOCATION_TYPE_NORMAL:
					result = "列休";
					break;
				case VocationType.VOCATION_TYPE_ILLNESS:
					result = "病休";
					break;
				case VocationType.VOCATION_TYPE_OTHER:
				default:
					result = "其他";
					break;
			}

			return result;
		}


		public enum VocationState
		{
			VOCATION_STATE_CREATED,					// 已申请
			VOCATION_STATE_CANCELLED,				// 已取消
		}


		public static String getVocationStateDesc(int state)
		{
			String result = "";

			switch ((VocationState)state)
			{
				case VocationState.VOCATION_STATE_CREATED:
					result = "已申请";
					break;				
				case VocationState.VOCATION_STATE_CANCELLED:
					result = "已取消";
					break;
			}

			return result;
		}


		public enum ReserveState
		{
			RESERVE_STATE_WAIT = 0,				// 未处理
			RESERVE_STATE_AGREED = 1,			// 已处理
			RESERVE_STATE_CANCELLED = 2,		// 已取消
		}


		public static String getReserveStateDesc(int state)
		{
			String result = "";

			switch ((ReserveState)state)
			{
				case ReserveState.RESERVE_STATE_WAIT:
					result = "未处理";
					break;
				case ReserveState.RESERVE_STATE_AGREED:
					result = "已处理";
					break;
				case ReserveState.RESERVE_STATE_CANCELLED:
					result = "已取消";
					break;
			}

			return result;
		}



		public enum ActivityCategory
        {
            PUTONGHUODONG = 0,				// 普通活动
            YEWUZHIDU,					    // 业务制度
            YEWUJIANGLI,					// 业务奖励
            FAHUIHUODONG,					// 法会活动
        }


        public static String getActivityCategoryDesc(int category)
        {
            String result = "";

            switch ((ActivityCategory)category)
            {
                case ActivityCategory.PUTONGHUODONG:
                    result = "普通活动";
                    break;
                case ActivityCategory.YEWUZHIDU:
                    result = "业务制度";
                    break;
                case ActivityCategory.YEWUJIANGLI:
                    result = "业务奖励";
                    break;
                case ActivityCategory.FAHUIHUODONG:
                    result = "法会活动";
                    break;
            }

            return result;
        }

        public enum ServiceReserveStatus
        {
            RESERVED,					// 已预约
            CANCELD,					// 已取消
            COMPLETED,					// 已执行
            CLIENT_READ,				// 客户已读
        }

        public static String getServiceReserveStatusDesc(int status)
        {
            String result = "";

            switch ((ServiceReserveStatus)status)
            {
                case ServiceReserveStatus.RESERVED:
                    result = "已预约";
                    break;
                case ServiceReserveStatus.CANCELD:
                    result = "已取消";
                    break;
                case ServiceReserveStatus.COMPLETED:
                    result = "已执行";
                    break;
                case ServiceReserveStatus.CLIENT_READ:
                    result = "客户已读";
                    break;
            }

            return result;
        }

        public enum TombAreaType
        {
            MUDI,
            PAIWEI,
            QITA,            
        }

        public static String getTombAreaTypeDesc(int type)
        {
            String result = "";

            switch ((TombAreaType)type)
            {
                case TombAreaType.MUDI:
                    result = "墓地园区";
                    break;
                case TombAreaType.PAIWEI:
                    result = "牌位园区";
                    break;                
            }

            return result;
        }
	}
}