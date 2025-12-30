using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class VacationInfo
    {
        public long uid { get; set; }
        public long user_id { get; set; }
        public DateTime leavedate { get; set; }
        public DateTime createtime { get; set; }
        public byte excuse { get; set; }
        public byte deleted { get; set; }
        public string username { get; set; }
        public string phone { get; set; }
        public long banid { get; set; }

    }
    public class Setinfo
    {
        public long id { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }
        public string text { get; set; }


    }
    public class MonthInfo
    {

        public int mon { get; set; }
        public int num { get; set; }
        public byte type { get; set; }
        public int total { get; set; }

    }
    public class banshichu { long key { get; set; }
    string label { get; set;}
    }
    public class VacationModel
    {
        BinZangDataContext db = new BinZangDataContext();
        //获得办事处list
        public string GetjsonOffice()
        {
            var list = db.offices.Where(a => a.deleted == 0).ToList();
            string st = "[";
            string subst = "";
            for (int i = 0; i < list.Count; i++)
            {
                if (list.Count>0)
                {
                    if (subst != "")
                    {
                        subst+= ",";

                    }
                    subst += "{key:" + list[i].uid + ", label:\"" + list[i].name + "\", img:\"" + "" + "\"}";
                }


            }
            st += subst;
            st += "]";
            return st;
        }
        public List<office> GetOffice()
        {


            return db.offices.Where(a => a.deleted == 0).ToList();
        }
        //根据输入条件查询出该员工所有的请假信息
        public List<VacationInfo> GetEmployeeVacation(string name, string phone, long banid)
        {
           
            var list = db.user_leaves.Where(a => a.deleted == 0).Join(db.users, ul => ul.user_id, u => u.uid, (ul, u) => new { ul1 = ul, u1 = u }).Select(uls => new VacationInfo
            {

                uid = uls.ul1.uid,
                user_id = uls.ul1.user_id,
                leavedate = uls.ul1.leavedate,
                createtime = uls.ul1.createtime,
                excuse = uls.ul1.excuse,
                username = uls.u1.realname,
                phone = uls.u1.phone,
                banid = (long)uls.u1.office_id




            }).ToList();
            List<VacationInfo> vlist = list.Where(a => a.username == name && a.phone == phone && a.banid == banid).ToList();
            return vlist;



        }
        //判断用户是否存在
        public user GetUserNow(string employeename, string phone, long banid)
        {
            user us = db.users.Where(m => m.deleted == 0 && m.realname == employeename && m.phone == phone && m.office_id == banid).FirstOrDefault();
            return us;

        }
        //找到个月份的离休信息
        public List<MonthInfo> GetMonthDetial(List<VacationInfo> v)
        {
            List<MonthInfo> ml = new List<MonthInfo>();
            
            for (int i = 1; i < 13;i++ )
            {
                MonthInfo mi = new MonthInfo();
                mi.total = v.Count;
                int con = 0;
                con = v.Where(a => a.leavedate.Month == i&&a.excuse==0).ToList().Count;
                mi.mon = i;
                mi.num = con;
                mi.type = 0;
                ml.Add(mi);
            }
            for (int i = 1; i < 13; i++)
            {
                MonthInfo mi = new MonthInfo();
                mi.total = v.Count;
                int con = 0;
                con = v.Where(a => a.leavedate.Month == i && a.excuse == 1).ToList().Count;
                mi.mon = i;
                mi.num = con;
                mi.type = 1;
                ml.Add(mi);
            }
            for (int i = 1; i < 13; i++)
            {
                MonthInfo mi = new MonthInfo();
                mi.total = v.Count;
                int con = 0;
                con = v.Where(a => a.leavedate.Month == i && a.excuse == 2).ToList().Count;
                mi.mon = i;
                mi.num = con;
                mi.type =2;
                ml.Add(mi);
            }
            return ml;


        }
        //添加一个休假
        public string AddV(byte xiutype, long banid, string ename, DateTime sdatestr, DateTime edatestr)
        {
            string str = "ok";
            sdatestr = sdatestr.AddHours(-sdatestr.Hour).AddMinutes(-sdatestr.Minute).AddSeconds(-sdatestr.Second);
            user u = db.users.Where(a => a.office_id == banid && a.realname == ename).FirstOrDefault();

            user_leave ul = new user_leave();
            List<user_leave> ullist = new List<user_leave>();
            if (u==null)
            {
                str = "员工姓名与办事处不符合！";
            }
            else
            {ullist=db.user_leaves.Where(a => a.user_id == u.uid && a.leavedate == sdatestr && a.deleted == 0).ToList();
                if (ullist.Count > 0)
                {
                    str = "对不起，员工今天有休假了！";
                }
                else
                {
                    try
                    {
                        ul.leavedate = sdatestr;
                        ul.user_id = u.uid;
                        ul.excuse = xiutype;
                        ul.createtime = DateTime.Now;
                        ul.deleted = 0;
                        db.user_leaves.InsertOnSubmit(ul);
                        db.SubmitChanges();
                    }
                    catch (System.Exception ex)
                    {
                        str = ex.ToString();
                    }

                }
            }
            
            
            return str;
        }
        //获得事件
        public string GetEvent()
        {

            List<user_leave> ullist = db.user_leaves.Where(a => a.deleted == 0).ToList();
            string evns = "";
            string subevns = "";


            evns += "[	";

            for (int i = 0; i < ullist.Count; i++)
            {
                user u = db.users.Where(a => a.uid == ullist[i].user_id).FirstOrDefault();
                office o= db.offices.Where(a => a.uid == u.office_id).FirstOrDefault();
                if (subevns != "")
                {
                    subevns += ",";

                }
                subevns += "{start_date:\"" + ullist[i].leavedate + "\", end_date:\"" + ullist[i].leavedate.AddHours(23) + "\", text:\"" + u.realname + "\",bx_id:" + ullist[i].excuse + ", ban_id:" + o.uid + ",id:"+ullist[i].uid+",ename:\"" + u.realname + "\"" + "}";


            }
            evns += subevns;
            evns += "]";
            return evns;

        }
        //获得休假设置
        public List<Setinfo> GetSetsInfo(long banid)
        {
            List<Setinfo> silist = new List<Setinfo>();

            List<leave_restrict> lrlist = db.leave_restricts.Where(a => a.deleted == 0 && a.office_id == banid).ToList();
            if (lrlist.Count>0)
            {
                for (int i = 0; i < lrlist.Count;i++ )
                {
                    Setinfo si = new Setinfo();
                    si.start_date = lrlist[i].restrictdate.ToString();
                    si.end_date = lrlist[i].restrictdate.AddHours(23).ToString();
                    si.id = lrlist[i].uid;
                    if (lrlist[i].type == 0)
                    {
                        si.text = "休假人数：" + lrlist[i].maxperson;
                    }
                    else
                    {
                        si.text = lrlist[i].excuse;
                    }
                    silist.Add(si);
                }
            }
          
            return silist;

        }

        public string GetSetsInfo1(long banid)
        {
            List<Setinfo> silist = new List<Setinfo>();

            List<leave_restrict> lrlist = db.leave_restricts.Where(a => a.deleted == 0 && a.office_id == banid).ToList();
            if (lrlist.Count > 0)
            {
                for (int i = 0; i < lrlist.Count; i++)
                {
                    Setinfo si = new Setinfo();
                    si.start_date = lrlist[i].restrictdate.ToString();
                    si.end_date = lrlist[i].restrictdate.AddHours(23).ToString();
                    si.id = lrlist[i].uid;
                    if (lrlist[i].type == 0)
                    {
                        si.text = "休假人数：" + lrlist[i].maxperson;
                    }
                    else
                    {
                        si.text = lrlist[i].excuse;
                    }
                    silist.Add(si);
                }
            }
            string evns = "";
            string subevns = "";


            evns += "[	";

            for (int i = 0; i < silist.Count; i++)
            {
              
                if (subevns != "")
                {
                    subevns += ",";

                }
                subevns += "{start_date:\"" + silist[i].start_date + "\", end_date:\"" + silist[i].end_date + "\", text:\"" + silist[i].text + "\",id:" + silist[i].id +  "}";


            }
            evns += subevns;
            evns += "]";
            return evns;
           

        }
        //删除休假
        public string DeletedVacationBy(long uid)
        {string str="ok";
            try
            {
                user_leave ul = db.user_leaves.Where(a => a.deleted == 0 && a.uid == uid).Single();
                db.user_leaves.DeleteOnSubmit(ul);
                db.SubmitChanges();
            }
            catch (System.Exception ex)
            {
            	str =ex.ToString();
            }

            return str;


        }
        //改变休假
        public string ChangeVacationBy(long uid, byte xiutype, long banid, string ename, DateTime sdatestr, DateTime edatestr)
        {
            string str = "ok";
            try
            {
                user_leave ul = db.user_leaves.Where(a => a.uid == uid && a.deleted == 0).Single();
                ul.excuse = xiutype;
                ul.leavedate = sdatestr = sdatestr.AddHours(-sdatestr.Hour).AddMinutes(-sdatestr.Minute).AddSeconds(-sdatestr.Second);
                db.SubmitChanges();
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }

            return str;

        }
        public string AddCan(byte type, string st, string et, long banid, int maxperson)
        {
            string str = "ok";
            DateTime std = DateTime.Parse(st);
            DateTime std1 = DateTime.Parse(st);
            DateTime etd = DateTime.Parse(et);
            TimeSpan num = etd - std;
            double n = num.TotalDays;
            List<DateTime> dtlist = new List<DateTime>();
            for (double k = 0; k <=n; k++)
            {

               std1 = std.AddDays(k);
                 
                dtlist.Add(std1);
            }
            try
            {
                for (int i = 0; i < dtlist.Count; i++)
                {
                    leave_restrict lr = new leave_restrict();
                    try
                    {
                        leave_restrict lr2 = db.leave_restricts.Where(a => a.deleted == 0 && a.restrictdate == dtlist[i] && a.office_id == banid).Single();
                         if (lr2.uid > 0)
                    {
                        lr2.type = type;
                        lr2.maxperson = maxperson;
                        lr2.office_id = banid;
                        lr2.restrictdate = dtlist[i];
                        lr2.deleted = 0;
                        lr2.excuse = "";
                        lr2.createtime = DateTime.Now;
                        db.SubmitChanges();
                    }
                    }
                    catch (System.Exception ex)
                    {
                        lr.type = type;
                        lr.maxperson = maxperson;
                        lr.office_id = banid;
                        lr.restrictdate = dtlist[i];
                        lr.deleted = 0;
                        lr.excuse = "";
                        lr.createtime = DateTime.Now;
                        db.leave_restricts.InsertOnSubmit(lr);
                        db.SubmitChanges();
                    }
                   
                 
               
                      
                    
                }
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }
           

            return str;

        }
        public string AddCanNot(byte type, string st, string et, long banid, string excuse)
        {
            string str = "ok";
   
            DateTime std = DateTime.Parse(st);
            DateTime std1 = DateTime.Parse(st);
            DateTime etd = DateTime.Parse(et);
            TimeSpan num = etd - std;
            double n = num.TotalDays;
            List<DateTime> dtlist = new List<DateTime>();
            for (double k = 0; k <= n; k++)
            {

                std1 = std.AddDays(k);

                dtlist.Add(std1);
            }
            try
            {
                for (int i = 0; i < dtlist.Count; i++)
                {
                    leave_restrict lr = new leave_restrict();
                    try
                    {
                        leave_restrict lr2 = db.leave_restricts.Where(a => a.deleted == 0 && a.restrictdate == dtlist[i] && a.office_id == banid).Single();
                        if (lr2.uid > 0)
                        {
                            lr2.type = type;
                            lr2.maxperson = 0;
                            lr2.office_id = banid;
                            lr2.restrictdate = dtlist[i];
                            lr2.deleted = 0;
                            lr2.excuse = excuse;
                            lr2.createtime = DateTime.Now;
                            db.SubmitChanges();
                        }
                    }
                    catch (System.Exception ex)
                    {
                        lr.type = type;
                        lr.maxperson = 0;
                        lr.office_id = banid;
                        lr.restrictdate = dtlist[i];
                        lr.deleted = 0;
                        lr.excuse = excuse;
                        lr.createtime = DateTime.Now;
                        db.leave_restricts.InsertOnSubmit(lr);
                        db.SubmitChanges();
                    }





                }
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }


    

            return str;
            
        }
    }
       




}
