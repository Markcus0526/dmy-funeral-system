
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;

namespace BinZangBackend.Controllers
{
    public class RemarkInfoController : Controller
    {
        //
        // GET: /RemarkInfo/
       [Authorize]
        public ActionResult Index()
        {
            BinZangDataContext db = new BinZangDataContext();
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "Remark";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "预约备注修改";
            ViewData["t3"] = "";
            ViewData["hua"] = "";
            ViewData["gong"] = "";
            ViewData["sui"] = "";
            ViewData["qi"] = "";
            environ envhua = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_xianhua_note").SingleOrDefault();
            if (envhua != null)
            {
                ViewData["hua"] = envhua.txt_value;
            }
        
            environ envgong = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_gongfan_note").FirstOrDefault();
            if (envgong != null)
            {
                ViewData["gong"] = envgong.txt_value;
            }
          
            environ envsui = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_suizangpin_note").FirstOrDefault();
            if (envsui != null)
            {
                ViewData["sui"] = envsui.txt_value ;
            }
         
            environ envqi = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_qita_note").FirstOrDefault();
            if (envqi != null)
            {
                ViewData["qi"] =  envqi.txt_value ;
            }
        
            //ViewData["level3nav"] = "Staff";
            return View();
        }

    }
}
