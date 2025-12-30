using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
namespace BinZangBackend.Controllers
{
    public class ViewsReserveController : Controller
    {
        //
        // GET: /ViewReserve/
        [Authorize]
        public ActionResult Viewreserve()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "ViewsReserve";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "参观预约";
            ViewData["t3"] = "";
            ViewBag.vlist = new VacationModel().GetOffice();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        //参观查询
        public JsonResult GetJsonTable(string name,string phone,string stime,string etime,string banid,string sta0,string sta1,string sta2)
        {    

            JqDataTableInfo list = new ViewReserveModel().ViewTable(name,phone, stime,etime, banid,sta0,sta1,sta2);
            return Json(list, JsonRequestBehavior.AllowGet);




        }

    }
}
