using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BZService.SvcManager
{
	public class ErrMgr
	{
		#region Error codes
		public const int ERRCODE_NONE = 0;
		public const int ERRCODE_NORMAL = -1;
		#endregion


		#region Error Messages
		public const String ERRMSG_NONE							= "操作成功";
		public const String ERRMSG_NORMAL						= "操作失败";
		public const String ERRMSG_CHECKSUM						= "用户验证失败";

		public const String ERRMSG_ABNORMAL_USERTYPE			= "用户类型未定";
		#endregion
	}
}