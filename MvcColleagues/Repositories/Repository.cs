using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using MvcColleagues.Models.SiteMembers;
using NHibernate;
using NHibernate.Linq;

namespace MvcColleagues.Repositories
{
    public class Repository<T> : IRepository<T>
    {
        protected ISession _session;

        public Repository() {} 

        public   Repository(ISession session)
        {
            this._session = session;
        }

    

        public void BeginTransaction()
        {
            _session.BeginTransaction();
        }

        public void Commit()
        {
            _session.Transaction.Commit();
        }

        public void Rollback()
        {
            _session.Transaction.Rollback();
        }

        public IQueryable<T> GetAll()
        {
            return _session.Query<T>();
        }

        public IQueryable<T> Get(Expression<Func<T, bool>> predicate)
        {
            return GetAll().Where(predicate);
        }

        public IEnumerable<T> SaveOrUpdateAll(params T[] entities)
        {
            foreach (T entity in entities)
            {
                _session.SaveOrUpdate(entity);
            }

            return entities;
        }

        public T SaveOrUpdate(T entity)
        {
            _session.SaveOrUpdate(entity);

            return entity;
        }
    }
}