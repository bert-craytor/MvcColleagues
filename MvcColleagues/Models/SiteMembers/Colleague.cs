using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcColleagues.Models.SiteMembers
{
    public class Colleague
    {
        public virtual System.Guid Id { get; set; }
        public virtual int Uid1 { get; set; }
        public virtual int Uid2 { get; set; }
    }
}