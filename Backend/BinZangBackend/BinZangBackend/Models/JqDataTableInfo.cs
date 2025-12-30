using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace BinZangBackend.Models
{
    public class JqDataTableInfo
    {
        public int? sEcho { get; set; }
        public long iTotalRecords { get; set; }
        public long iTotalDisplayRecords { get; set; }
        public IEnumerable aaData { get; set; }
    }
}