using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
namespace BinZangBackend.Controllers
{
    public class LingMuOrderController : Controller
    {
        //
        // GET: /LingMuOrder/
        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "LingMuOrder";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "陵墓预约管理";
            ViewData["t3"] = "";
            ViewBag.ylist = new LingMuModel().Getyuan();
            //执行一个刷新 将过期的陵墓释放出来k
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        //获得陵墓预约
        public JsonResult GetLingMuOrder(string cname,  string phone, long yuanid, string muwei)
        {
            List<LingMuInfo> list = new LingMuModel().GetLingMuRes(cname,phone,yuanid,muwei);
            JqDataTableInfo jqs= new JqDataTableInfo();
            jqs.aaData =list;
            jqs.iTotalRecords = list.Count;

            return Json(jqs, JsonRequestBehavior.AllowGet);
        }
        //释放陵墓预约
        public JsonResult DelLing(long uid)
        {
            string res = new LingMuModel().DelLingMu(uid);
            return Json(res, JsonRequestBehavior.AllowGet);

        }

    }
}
