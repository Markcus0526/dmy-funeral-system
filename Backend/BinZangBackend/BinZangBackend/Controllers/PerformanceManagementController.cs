using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
using System.Data;

namespace BinZangBackend.Controllers
{
    public class PerformanceManagementController : Controller
    {
        //
        // GET: /PerformanceManagement/
        [Authorize]
        public ActionResult PerformanceManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "PerformanceManagement";
            ViewData["level2nav"] = "PerformanceManagement";
            ViewData["t1"] = "业绩管理";
            ViewData["t2"] = "业绩管理";
            ViewData["t3"] = "";
            ViewBag.office = new PerformanceModel().GetallOffice();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        [Authorize]
        public ActionResult OldCus(string name, string phone)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "PerformanceManagement";
            ViewData["level2nav"] = "PerformanceDetail";
            ViewData["t1"] = "业绩管理";
            ViewData["t2"] = "业绩管理";
            ViewData["t3"] = "业绩添加";
            ViewData["name"] = name;
            ViewData["phone"] = phone;
            ViewBag.ylist = new PerformanceModel().GetYuan();
            //ViewData["level3nav"] = "Staff";
            return View();

        }
        [Authorize]
        public ActionResult PerformanceDetail()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "PerformanceManagement";
            ViewData["level2nav"] = "PerformanceDetail";
            ViewData["t1"] = "业绩管理";
            ViewData["t2"] = "业绩管理";
            ViewData["t3"] = "业绩添加";
            ViewBag.ylist = new PerformanceModel().GetYuan();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        public class Comparint : IEqualityComparer<grave_site>
        {

            public bool Equals(grave_site x, grave_site y)
            {
                if (x == null && y == null)
                    return false;
                return x.row_number == y.row_number;
            }

            public int GetHashCode(grave_site obj)
            {
                return obj.ToString().GetHashCode();
            }
        }
        public JsonResult GetPai(long yuanid)
        {
            BinZangDataContext db = new BinZangDataContext();
            List<grave_site> gs = new List<grave_site>();

            gs = db.grave_sites.Where(a => a.deleted == 0 && a.tombarea_id == yuanid).ToList().Distinct(new Comparint()).ToList();

            return Json(gs, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetHao(long yuanid, int paiid)
        {
            BinZangDataContext db = new BinZangDataContext();
            List<grave_site> gs = new List<grave_site>();

            gs = db.grave_sites.Where(a => a.deleted == 0 && a.tombarea_id == yuanid && a.row_number == paiid).ToList().Distinct(new Comparint()).ToList();

            return Json(gs, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ValidClient(string name, string phone)
        {
            string jiu = "yes";
            BinZangDataContext db = new BinZangDataContext();
            client c = new client();
            c = db.clients.Where(a => a.realname == name && a.phone == phone&&a.deleted==0).FirstOrDefault();
            if (c == null)
            {
                jiu = "no";
            }
            return Json(jiu, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetallUser(long uid)
        {
            List<user> list = new PerformanceModel().GetallUser(uid);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetallDUser(long uid)
        {
            List<user> list = new PerformanceModel().GetallDUser(uid);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchdPerforance(long officename, long yname, long dname, string dstarttime,string dendtime, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new PerformanceModel().SerchdPerforance(officename, yname, dname, dstarttime, dendtime,sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Serchdyperformance(long yofficename, long yyname,  string ystarttime, string yendtime, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new PerformanceModel().Serchdyperformance(yofficename, yyname, ystarttime, yendtime, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchOfficeperformance(long offname, string ostarttime, string oendtime, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new PerformanceModel().SerchOfficeperformance(offname, ostarttime, oendtime, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SendManageOffice()
        {
            bool success = false;
            success = new PerformanceModel().SendManageOffice();
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SendManageHead()
        {
            bool success = false;
            success = new PerformanceModel().SendManageHead();
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public void GetPgExcel(long offname, string ostarttime, string oendtime)
        {
            List<OfficePerformance> list = new List<OfficePerformance>();
            list = new PerformanceModel().SerchOfficeTOExcel(offname, ostarttime, oendtime);
            ListToDatatable ltd = new ListToDatatable();
            DataTable dtData = ltd.listToDatatable(list, 8);

            System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
            System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
            System.IO.StringWriter strWriter = null;
            System.Web.UI.HtmlTextWriter htmlWriter = null;
            string filename = ostarttime + "至" + oendtime + "办事处总业绩";
            byte[] str = null;
            for (int i = 0; i < dtData.Rows.Count; i++)
            {
                
                     //dtData.Rows[i]["officename"] = "固定测报点";
                     dtData.Rows[i]["dperformance"] =dtData.Rows[i]["dperformance"]+ "元";
                     dtData.Rows[i]["yperformance"] = dtData.Rows[i]["yperformance"] + "元";
                     dtData.Rows[i]["ownsale"] =dtData.Rows[i]["ownsale"]+ "%";
                     dtData.Rows[i]["cover"] = dtData.Rows[i]["cover"] + "元";
                     dtData.Rows[i]["allperformance"] = dtData.Rows[i]["allperformance"] + "元";
                     dtData.Rows[i]["reachratio"] = dtData.Rows[i]["reachratio"] + "%";
                     dtData.Rows[i]["officesurplus"] = dtData.Rows[i]["officesurplus"] + "元";

            }
            if (dtData != null)
            {
                // 设置编码和附件格式 
                dtData.Columns["officename"].ColumnName = "办事处名称";
                dtData.Columns["dperformance"].ColumnName = "代销商业绩累计";
                dtData.Columns["yperformance"].ColumnName = "员工业绩累计";
                dtData.Columns["ownsale"].ColumnName = "自营比例";
                dtData.Columns["cover"].ColumnName = "责任额";
                dtData.Columns["allperformance"].ColumnName = "总业绩";
                dtData.Columns["reachratio"].ColumnName = "达成比例";
                dtData.Columns["officesurplus"].ColumnName = "办事处营余";
                curContext.Response.ContentType = "application/vnd.ms-excel";
                curContext.Response.ContentEncoding = System.Text.Encoding.UTF8;
                curContext.Response.Charset = "gb2312";

                Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");
                // 导出excel文件 
                strWriter = new System.IO.StringWriter();
                htmlWriter = new System.Web.UI.HtmlTextWriter(strWriter);

                // 为了解决dgData中可能进行了分页的情况，需要重新定义一个无分页的DataGrid 
                dgExport = new System.Web.UI.WebControls.DataGrid();
                dgExport.DataSource = dtData;
                dgExport.AllowPaging = false;
                dgExport.DataBind();
                dgExport.Font.Size = 14;
                dgExport.HeaderStyle.Font.Bold = true;
                dgExport.RenderControl(htmlWriter);
                // 返回客户端 
                str = System.Text.Encoding.UTF8.GetBytes(strWriter.ToString());
                //string meeting = "<Workbook>"
                // + "<Worksheet>";
                string meeting = "<html>"
                   + "<head>"
                   + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
                   + "</head>"
                   + "<body>"
                   + "<table style='text-align:center;font-size:20px;border:0.5px solid black;border-collapse:collapse;border-spacing:0px;width:100%;Color:black'><tr><td colspan='8' style='text-align:center;font-size:20px;font-weight:bold'>" + filename + "</td></tr><tr></tr></table>";
                //string meeting1 = "</Worksheet><Worksheet></Worksheet></Workbook>";
                string meeting1 = "</body></html>";
                String a = meeting + strWriter.ToString() + meeting1;
                Response.Write(a);
                //发送完，关闭
                Response.End();
            }

        }
        public void YPgExcel(long yofficename, long yyname, string ystarttime, string yendtime)
        {
            List<YPerformance> list = new List<YPerformance>();
            list = new PerformanceModel().SerchYToExcel(yofficename, yyname, ystarttime, yendtime);
            ListToDatatable ltd = new ListToDatatable();
            DataTable dtData = ltd.listToDatatable(list, 7);

            System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
            System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
            System.IO.StringWriter strWriter = null;
            System.Web.UI.HtmlTextWriter htmlWriter = null;
            string filename = ystarttime + "至" + yendtime + "办事处员工业绩";
            byte[] str = null;
            for (int i = 0; i < dtData.Rows.Count; i++)
            {

                //dtData.Rows[i]["officename"] = "固定测报点";
                dtData.Rows[i]["dperformance"] = dtData.Rows[i]["dperformance"] + "元";
                dtData.Rows[i]["yperformance"] = dtData.Rows[i]["yperformance"] + "元";
                dtData.Rows[i]["ownsale"] = dtData.Rows[i]["ownsale"] + "%";
                dtData.Rows[i]["cover"] = dtData.Rows[i]["cover"] + "元";
                dtData.Rows[i]["allperformance"] = dtData.Rows[i]["allperformance"] + "元";
                dtData.Rows[i]["reachratio"] = dtData.Rows[i]["reachratio"] + "%";
                //dtData.Rows[i]["officesurplus"] = dtData.Rows[i]["officesurplus"] + "元";

            }
            if (dtData != null)
            {
                // 设置编码和附件格式 
                dtData.Columns["yyname"].ColumnName = "员工名称";
                dtData.Columns["dperformance"].ColumnName = "代销商业绩累计";
                dtData.Columns["yperformance"].ColumnName = "员工业绩累计";
                dtData.Columns["ownsale"].ColumnName = "自营比例";
                dtData.Columns["cover"].ColumnName = "责任额";
                dtData.Columns["allperformance"].ColumnName = "总业绩";
                dtData.Columns["reachratio"].ColumnName = "达成比例";
                //dtData.Columns["officesurplus"].ColumnName = "办事处营余";
                curContext.Response.ContentType = "application/vnd.ms-excel";
                curContext.Response.ContentEncoding = System.Text.Encoding.UTF8;
                curContext.Response.Charset = "gb2312";

                Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");
                // 导出excel文件 
                strWriter = new System.IO.StringWriter();
                htmlWriter = new System.Web.UI.HtmlTextWriter(strWriter);

                // 为了解决dgData中可能进行了分页的情况，需要重新定义一个无分页的DataGrid 
                dgExport = new System.Web.UI.WebControls.DataGrid();
                dgExport.DataSource = dtData;
                dgExport.AllowPaging = false;
                dgExport.DataBind();
                dgExport.Font.Size = 14;
                dgExport.HeaderStyle.Font.Bold = true;
                dgExport.RenderControl(htmlWriter);
                // 返回客户端 
                str = System.Text.Encoding.UTF8.GetBytes(strWriter.ToString());
                //string meeting = "<Workbook>"
                // + "<Worksheet>";
                string meeting = "<html>"
                   + "<head>"
                   + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
                   + "</head>"
                   + "<body>"
                   + "<table style='text-align:center;font-size:20px;border:0.5px solid black;border-collapse:collapse;border-spacing:0px;width:100%;Color:black'><tr><td colspan='7' style='text-align:center;font-size:20px;font-weight:bold'>" + filename + "</td></tr><tr></tr></table>";
                //string meeting1 = "</Worksheet><Worksheet></Worksheet></Workbook>";
                string meeting1 = "</body></html>";
                String a = meeting + strWriter.ToString() + meeting1;
                Response.Write(a);
                //发送完，关闭
                Response.End();
            }

        }
        public JsonResult AddYeji(string chengbanren, string chengphone, string buyname, string buyphone, string muqu, string pai, string hao, string guanxi1,
    string mozhe1,
    string shengri1,
    string jiri1,
    string guanxi2,
    string mozhe2,
    string shengri2,
    string jiri2,
            string buytime,
    string paijia,
    string chengjiaojia)
        {

            string res = new PerformanceModel().AddPerformance(chengbanren, chengphone, buyname, buyphone, muqu, pai, hao, guanxi1, mozhe1,shengri1,jiri1,
     guanxi2,
     mozhe2,
     shengri2,
    jiri2,
    buytime,
     paijia,
    chengjiaojia);
            return Json(res, JsonRequestBehavior.AllowGet);
        }

    }
}
