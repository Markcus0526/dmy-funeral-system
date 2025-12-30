using System;
using System.Configuration;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Data.OleDb;
using BinZangBackend.Models;
namespace BinZangBackend.Controllers
{
    public class LuoZangReserveController : Controller
    {
        //
        // GET: /LuoZangReserve/
              [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "LuoZangReserve";
            //ViewData["level3nav"] = "Staff";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "落葬仪式预约";
            ViewData["t3"] = "";
            ViewBag.llist = new LuoZangModel().GetServiceType();
            return View();
        }
        //根据查询条件获得落葬预约
        public JsonResult GetLuoBy(string clientname, string clientphone, string stime, string etime, string serviceid, string status)
        {
            JqDataTableInfo list = new LuoZangModel().GetLuoTable(clientname, clientphone, stime, etime, serviceid, status);

            return Json(list, JsonRequestBehavior.AllowGet);


        }
        //取消落葬预约
        public JsonResult DelLuoZang(long uid)
        {
            string res = new LuoZangModel().DeleteLuo(uid);
            return Json(res, JsonRequestBehavior.AllowGet);

        }
        //行事历
        public void ExportLuoZang(string extime)
        {
            string filename = extime+"落葬仪式行事历";
            List<ExportInfo> exlist = new LuoZangModel().ExportBy(extime);
            string rst = "";
            string trs = new LuoZangModel().GetHtml(exlist);
            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
              string html="";
                html += "<tr>";
                html += "<td  colspan='2' rowspan='1' id='1' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'> </td>";
                html += "<td  colspan='3 ' rowspan='1' id='1' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'> </td>";
                html += "<td  colspan='3 ' rowspan='1' id='3' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;v'>" + filename + "</td>";
                html += "<td  colspan='3 ' rowspan='1' id='5' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'> </td>";
                html += "<td  colspan='3 ' rowspan='1' id='65' style='height:40px;font-size:14;border-bottom: 1px solid #000000;border-right:0px solid red;text-align:center;'> </td>";     
                html += "</tr>"; 
            meeting=meeting+html;
            rst = meeting + trs;
           // System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
            System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
        //    System.IO.StringWriter strWriter = null;
         //   System.Web.UI.HtmlTextWriter htmlWriter = null;
     
            byte[] str = null;
            curContext.Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");

            rst += "</table ></body></html>";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(rst);

            //把字符数组写入HTTP响应输出流
            Response.Write(sb.ToString());
            //发送完，关闭
            Response.End();

         
        }
        //导出落葬仪式预约
        public void ExportLuo(string cname, string phone, string stime, string etime, string stype, string status)
        {
            string filename =  "落葬仪式预约";
            List<LuoZangInfo> list = new LuoZangModel().GetExportInfo(cname, phone, stime, etime, stype, status);
            string rst = "";
          
            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
            string html = "";
            html += "<tr>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>"+"客户姓名"+" </td>";
            html += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "联系方式" + "  </td>";
            html += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + "预约日期" + " </td>";
            html += "<td  colspan='3 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "仪式名称" + "  </td>";
            html += "<td  colspan='1 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "是否取消" + "  </td>";
            html += "</tr>";
            meeting = meeting + html;
            for (int i = 0; i < list.Count;i++ )
            {
                rst += "<tr>";
                rst += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_name + " </td>";
                rst += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_phone + "  </td>";
                rst += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].reservetimestr + " </td>";
                rst += "<td  colspan='3 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].service_name + "  </td>";
                rst += "<td  colspan='1 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].isno + "  </td>";
                rst += "</tr>";
                
            }
            rst = meeting + rst;
          //  System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
         System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
         //   System.IO.StringWriter strWriter = null;
         //   System.Web.UI.HtmlTextWriter htmlWriter = null;

            byte[] str = null;
            curContext.Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");

            rst += "</table ></body></html>";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(rst);

            //把字符数组写入HTTP响应输出流
            Response.Write(sb.ToString());
            //发送完，关闭
            Response.End();

        }

    }
}
