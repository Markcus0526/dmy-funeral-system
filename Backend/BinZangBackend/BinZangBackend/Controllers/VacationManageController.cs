using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;


namespace BinZangBackend.Controllers
{
    public class VacationManageController : Controller
    {
        //
        // GET: /VacatonManage/
        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "Vacation";
            ViewData["level3nav"] = "Employee";
            ViewData["t1"] = "系统用户管理";
            ViewData["t2"] = "休假管理";
            ViewData["t3"] = "员工休假统计";
            ViewBag.vlist = new VacationModel().GetOffice();
            return View();
        }
        [Authorize]
        public ActionResult Index1(long banid)
        {

            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "Vacation";
            ViewData["level3nav"] = "Employee";
            ViewData["t1"] = "系统用户管理";
            ViewData["t2"] = "休假管理";
            ViewData["t3"] = "休假设置";
            string k = new VacationModel().GetSetsInfo1(banid);
            ViewData["evn"] = k;
            ViewData["ban"] = banid;
            ViewBag.vlist = new VacationModel().GetOffice();
            return View();

        }
        //休假管理数据查询
        public JsonResult VacationStatic(string employeename, string phone,long banid)
        {
            List<MonthInfo> mlist = new List<MonthInfo>();
            List<VacationInfo> vlist = new VacationModel().GetEmployeeVacation(employeename,phone,banid);
            if (vlist.Count > 0)
            {
                mlist = new VacationModel().GetMonthDetial(vlist);
                return Json(mlist, JsonRequestBehavior.AllowGet);
            }
            else
            {
                user us = new VacationModel().GetUserNow(employeename, phone, banid);
                if (us == null)
                {
                    return Json(false, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    mlist = new VacationModel().GetMonthDetial(vlist);
                    return Json(mlist, JsonRequestBehavior.AllowGet);
                }
            }


            
        }
        [Authorize]
        public ActionResult VacationSet()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "Vacation";
            ViewData["level3nav"] = "VSet";
            ViewData["t1"] = "系统用户管理";
            ViewData["t2"] = "休假管理";
            ViewData["t3"] = "休假设置";
            ViewBag.vlist = new VacationModel().GetOffice();
            return View();
        }
         [Authorize]
        public ActionResult EmployeeVacation()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "Vacation";
            ViewData["level3nav"] = "VEmployee";
            ViewData["t1"] = "系统用户管理";
            ViewData["t2"] = "休假管理";
            ViewData["t3"] = "员工休假管理";
            ViewData["ban"] = new VacationModel().GetjsonOffice();
            ViewData["vevent"] = new VacationModel().GetEvent();
            return View();
        }
        //添加休假
        public JsonResult AddEmployeeVacation(byte xiutype, long banid, string ename, string sdatestr, string edatestr) {
            DateTime sd = DateTime.Parse(sdatestr);
            DateTime ed = DateTime.Parse(edatestr);

            string str = new VacationModel().AddV(xiutype, banid, ename, sd, ed);

            return Json(str, JsonRequestBehavior.AllowGet);
        }
        //删除休假
        public JsonResult DeletedVacation(long vid)
        {

            string str = new VacationModel().DeletedVacationBy(vid);
            if (str=="ok")
            {
                str = "ok";
            }
            return Json(str, JsonRequestBehavior.AllowGet);


        }
        //改变休假
        public JsonResult ChangeEmployeeVacation(long uid, byte xiutype, long banid, string ename, string sdatestr, string edatestr)
        {       DateTime sd = DateTime.Parse(sdatestr);
            DateTime ed = DateTime.Parse(edatestr);
            string str = new VacationModel().ChangeVacationBy(uid, xiutype, banid, ename, sd, ed);


            return Json(str, JsonRequestBehavior.AllowGet);

        }
        //添加可以休假
        public JsonResult CanVacation(byte type,string st,string et,long banid,int maxperson) {
            string str = new VacationModel().AddCan(type, st, et, banid, maxperson);
            return Json(str, JsonRequestBehavior.AllowGet);
        }
        //添加不可以休假
        public JsonResult CanNotVacation(byte type, string st, string et, long banid, string excuse)
        {
            string str = new VacationModel().AddCanNot(type, st, et, banid, excuse);


            return Json(str, JsonRequestBehavior.AllowGet);
        }
        //根据办事处查询休假设置、
        public JsonResult SearchSet(long banid)
        {
            List<Setinfo> silist = new VacationModel().GetSetsInfo(banid);
            
            return Json(silist, JsonRequestBehavior.AllowGet);

        }
    }
}
