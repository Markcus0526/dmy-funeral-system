using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.IO;
using System.Web.Hosting;
using System.Text;
using System.Xml;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Web.Mvc;
using System.Web.UI;


namespace BinZangBackend.Models
{
    public class UserInfo
    {
        public long uid { get; set; }
        public string name { get; set; }
        public string password { get; set; }
        public byte type { get; set; }
        public string realname { get; set; }
        public string phone { get; set; }
        public long office_id { get; set; }
        public string imgurl { get; set; }
        public long owner_id { get; set; }
        public string qq { get; set; }
        public string weixin { get; set; }
        public DateTime createtime { get; set; }
        public int planamount_permonth { get; set; }
        public string access_token { get; set; }
        public long adminrightid { get; set; }
        public byte deleted { get; set; }
        public string role { get; set; }
    }
    public class UserModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public void SignIn(string userName, bool createPersistentCookie)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");

            System.Web.Security.FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }
        //验证用户是否存在
        public UserInfo ValidateUser(string username, string password)
        {
            string sha1Pswd = UserModel.GetMD5Hash(password);
            return GetUserByNamePwd(username, sha1Pswd);
        }
        //根据账号密码找到 用户权限等信息
        public UserInfo GetUserByNamePwd(string uname, string upwd)
        {
            UserInfo rst = null;
            try
            {
                var userinfo = db.users.Where(m => m.deleted == 0 &&m.type==0&& m.name == uname && m.password == upwd).FirstOrDefault();

                rst = new UserInfo();
                rst.uid = userinfo.uid;
                rst.realname = userinfo.realname;
                rst.name = userinfo.name;

                var roles = db.admin_rights.Where(a => a.uid == userinfo.adminright_id).FirstOrDefault();

                //  var roleinfo = db.authorities.Where(m => m.deleted == 0 && m.id == userinfo.id).FirstOrDefault();

                if (roles != null)
                {
                    rst.role = roles.role;
                }

            }
            catch (System.Exception ex)
            {
                ex.ToString();
                return null;
            }

            return rst;
        }
        public static string GetMD5Hash(string value)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(value));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }
            return sBuilder.ToString();
        }
        public static string GetUserRoleInfo()
        {
            BinZangDataContext db = new BinZangDataContext();
            FormsIdentity fId = (FormsIdentity)HttpContext.Current.User.Identity;
            FormsAuthenticationTicket authTicket = fId.Ticket;
            string[] udata = authTicket.UserData.Split(new Char[] { '|' });
            string role = db.admin_rights.Where(m => m.deleted == 0 && m.uid == (long)(db.users.Single(s => s.deleted == 0 && s.uid == long.Parse(udata[0])).adminright_id)).FirstOrDefault().role;

            return role;
        }

    }
}
