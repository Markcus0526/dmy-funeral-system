using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;

namespace BinZangBackend.Models
{
	[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
	public class SessionExpireFilterAttribute : AuthorizeAttribute
	{
		protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
		{
			if (filterContext.HttpContext.Request.IsAjaxRequest())
			{
// 				filterContext.Result = new JsonResult
// 				{
// 					Data = new
// 					{
// 						// put whatever data you want which will be sent
// 						// to the client
// 						message = "sorry, but you were logged out"
// 					},
// 					JsonRequestBehavior = JsonRequestBehavior.AllowGet
// 				};
				//HttpContext.Current.Response.Redirect("~/Account/LogOn");
				HttpContext.Current.Response.StatusCode = 404;
				HttpContext.Current.Response.End();
			}
			else
			{
				base.HandleUnauthorizedRequest(filterContext);
			}
		}
	}
}