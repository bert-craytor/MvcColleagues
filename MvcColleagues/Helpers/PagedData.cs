using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcColleagues.Views
{
    public class PagedData<T> where T : class
    {
        public IList<T> Data { get; set; }
        public int MemberCount { get; set; }
        public int CurrentPage { get; set; }
    }
}