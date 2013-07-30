using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using MvcColleagues.Models.SiteMembers;

namespace MvcColleagues.Repositories
{
    public interface IRepository<T>
    {
        void BeginTransaction();
        void Commit();
        void Rollback();
        IQueryable<T> GetAll();
    //    IList<T> GetPage(int start, int pageSize, IList<T> secondary);
      
        IQueryable<T> Get(Expression<Func<T, bool>> predicate);
        IEnumerable<T> SaveOrUpdateAll(params T[] entities);
        T SaveOrUpdate(T entity);
    }
}