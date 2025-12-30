using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;

namespace BinZangBackend.Controllers
{
    public class JiBaiReserveController : Controller
    {
        //
        // GET: /JiBaiReserve/
        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "JiBaiReserve";
            //ViewData["level3nav"] = "Staff";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "代祭拜预约";
            ViewData["t3"] = "";
            return View();
        }
        //代祭拜的导出
        public void ExportJi(string cname, string phone, string stime, string etime, string status)
        {
            List<JiBaiOrderInfo> list = new ShangPinModel().GetDaiJi(cname, phone, stime, etime, status);
            string filename = "代祭拜仪式预约";
            string rst = "";

            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
            string html = "";
            html += "<tr>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "客户姓名" + " </td>";
            html += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "联系方式" + "  </td>";
            html += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + "预约日期" + " </td>";
            html += "<td  colspan='2 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "代订人" + "  </td>";
            html += "<td  colspan='1 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "是否取消" + "  </td>";
            html += "</tr>";
            meeting = meeting + html;
            for (int i = 0; i < list.Count; i++)
            {
                rst += "<tr>";
                rst += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_name + " </td>";
                rst += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_phone + "  </td>";
                rst += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].reservetimestr + " </td>";
                rst += "<td  colspan='2 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].user_name + " </td>";
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

        //带祭拜行事历的导出
        public void ExportJiBai(string extime)
        {
            string filename = extime + "代祭拜行事历";
            List<ExportInfo> exlist = new ShangPinModel().ExportJiBy(extime);
            string rst = "";
            string trs = new ShangPinModel().GetJIHtml(exlist);
            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
            string html = "";
            html += "<tr>";
            html += "<td  colspan='2' rowspan='1' id='1' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'> </td>";
            html += "<td  colspan='3 ' rowspan='1' id='1' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'> </td>";
            html += "<td  colspan='3 ' rowspan='1' id='3' style='height:40px;font-size:14;border-bottom: 1px solid #000000;text-align:center;v'>" + filename + "</td>";

            html += "<td  colspan='3 ' rowspan='1' id='65' style='height:40px;font-size:14;border-bottom: 1px solid #000000;border-right:0px solid red;text-align:center;'> </td>";
            html += "</tr>";
            meeting = meeting + html;
            rst = meeting + trs;
           // System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
         System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
         //   System.IO.StringWriter strWriter = null;
           // System.Web.UI.HtmlTextWriter htmlWriter = null;

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
