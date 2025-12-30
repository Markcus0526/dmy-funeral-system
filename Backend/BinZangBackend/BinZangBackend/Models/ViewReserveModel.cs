using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class ViewReserveInfo
    {
        public long uid { get; set; }
        public string name { get; set; }
        public string phone { get; set; }
        public long officeid { get; set; }
        public string officename { get; set; }
        public DateTime reservatime { get; set; }
        public string reservatimestr { get; set; }
        public string reservatimestr1 { get; set; }
        public DateTime createtime { get; set; }
        public byte status { get; set; }
        public long? handlerid { get; set; }
        public DateTime handletime { get; set; }
        public string handlename { get; set; }
    }
    public class ViewReserveModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<ViewReserveInfo> GetVisit()
        {

            return db.visit_reserves.Where(vr => vr.deleted == 0).Join(db.users, vr => vr.handler_id, u => u.uid, (vr, u) => new { vr1 = vr, u1 = u }).Join(db.offices, vr2 => vr2.vr1.office_id, o => o.uid, (vr2, o) => new { vr3 = vr2, o1 = o }).Select(vis => new ViewReserveInfo
            {


                name = vis.vr3.vr1.name,
                phone = vis.vr3.vr1.phone,
                reservatimestr = vis.vr3.vr1.reservetime.ToLongDateString(),
                officename = vis.o1.name,


                status = vis.vr3.vr1.status,






            }).ToList().OrderByDescending(a=>a.reservatime).ToList();
        }
        public List<ViewReserveInfo> GetVisitAll()
        {

            var list = db.visit_reserves.Where(vr => vr.deleted == 0).Join(db.offices, vr2 => vr2.office_id, o => o.uid, (vr2, o) => new { vr3 = vr2, o1 = o }).Select(vis => new ViewReserveInfo
            {

                uid = vis.vr3.uid,
                name = vis.vr3.name,
                phone = vis.vr3.phone,
                officeid = vis.vr3.office_id,
                officename = vis.o1.name,
                reservatimestr = vis.vr3.reservetime.Year + "年" + vis.vr3.reservetime.Month + "月" + vis.vr3.reservetime.Day + "日" + " " + vis.vr3.reservetime.Hour + "点" + vis.vr3.reservetime.Minute + "分",

                reservatime = vis.vr3.reservetime,
                createtime = vis.vr3.createtime,
                status = vis.vr3.status,
                handlerid = vis.vr3.handler_id,







            }).ToList();
            for (int j = 0; j < list.Count; j++)
            {
                if (list[j].handlerid != null)
                {
                    user us = db.users.Where(a => a.uid == list[j].handlerid).FirstOrDefault();
                    list[j].handlename = us.realname;

                }
                else
                {

                }

            }
            return list;
        }
        public JqDataTableInfo ViewTable(string name, string phone, string stime, string etime, string banid, string sta0, string sta1, string sta2)
        {
            JqDataTableInfo res = new JqDataTableInfo();

            List<ViewReserveInfo> list = GetVisitAll();
            if (name != null && name != "")
            {
                list = list.Where(a => a.name.Contains(name)).ToList();
            }
            if (phone != null && phone != "")
            {
                list = list.Where(a => a.phone.Contains(phone)).ToList();
            }
            if (stime != null && stime != "")
            {
                DateTime s = DateTime.Parse(stime);
                list = list.Where(a => a.reservatime >= s).ToList();
            }
            if (etime != null && etime != "")
            {
                DateTime e = DateTime.Parse(etime);
                list = list.Where(a => a.reservatime <= e).ToList();
            }
            if (banid != "" && banid != null)
            {
                long banids = long.Parse(banid);
                list = list.Where(a => a.officeid == banids).ToList();
            }
            if (sta0 == "0" && sta1 == "0" && sta2 == "0")
            {
                list = new List<ViewReserveInfo>();
            }
            if (sta0 == "1" && sta1 == "0" && sta2 == "0")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (sta0 == "0" && sta1 == "2" && sta2 == "0")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (sta0 == "0" && sta1 == "0" && sta2 == "3")
            {
                list = list.Where(a => a.status == 2).ToList();
            }
            if (sta0 == "1" && sta1 == "2" && sta2 == "0")
            {
                list = list.Where(a => a.status == 1 || a.status == 0).ToList();
            }
            if (sta0 == "1" && sta1 == "0" && sta2 == "3")
            {
                list = list.Where(a => a.status == 2 || a.status == 0).ToList();
            }
            if (sta0 == "0" && sta1 == "2" && sta2 == "3")
            {
                list = list.Where(a => a.status == 2 || a.status == 1).ToList();
            }
            if (sta0 == "1" && sta1 == "2" && sta2 == "3")
            {
                list = list.Where(a => a.status == 2 || a.status == 1 || a.status == 0).ToList();
            }
            res.aaData = list.OrderByDescending(m=>m.uid).ToList();

            res.iTotalRecords = list.Count();
            return res;
        }

    }

}
