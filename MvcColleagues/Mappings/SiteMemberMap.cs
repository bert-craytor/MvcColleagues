using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcColleagues.Models;
using MvcColleagues.Models.SiteMembers;
using NHibernate;
using FluentNHibernate.Conventions.Inspections;
using FluentNHibernate.Mapping;

namespace MvcColleagues.Mappings
{
    public class SiteMemberMap : ClassMap<SiteMember>
    {
        public SiteMemberMap()
        {
            Table("SiteMember");
            Id(x => x.Id).GeneratedBy.GuidComb() ;
            Map(d => d.Uid).Not.Nullable();
            Map(d => d.FullName).Not.Nullable().Length(80);
            Map(d => d.Company).Not.Length(80);
            Map(d => d.JobTitle).Not.Length(50);
            Map(d => d.Location).Not.Length(80); 
            Map(d => d.LevelId);
            Map(d => d.FunctionId);
            Map(d => d.IndustryId);
            Map(d => d.JoinDate).Default(DateTime.Now.ToShortDateString());
        }
    }
}