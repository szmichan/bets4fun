using Bets4Fun.DBTableAdapters;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class RolesLogic : RoleProvider
    {
        private static RolesTableAdapter _adapter;

        public static RolesTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new RolesTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static DB.RolesDataTable GetRoles()
            => Adapter.GetRoles();

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.RolesDataTable GetUserRoles(int id)
            => Adapter.GetUserRoles(id);

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.RolesDataTable GetNotUserRoles(int id)
            => Adapter.GetNotUserRoles(id);

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static bool AddRole(string name, string description)
            => Adapter.Insert(name, description) == 1;

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public static bool UpdateRole(string name, string description, int id)
            => Adapter.Update(name, description, id) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public static bool DeleteRole(int id) =>
            Adapter.Delete(id) == 1;


        #region Implemented

        public override string[] GetRolesForUser(string username)
        {
            var roles = new List<string>();
            if (HttpContext.Current?.Session?["UserRoles"] != null)
                roles = (List<string>) HttpContext.Current?.Session["UserRoles"];
            else
            {
                var user = UsersLogic.GetUserByLogin(username);

                if (user != null)
                    roles.AddRange(RolesLogic.GetUserRoles(user.Id).Select(role => role.Name));

                if (HttpContext.Current?.Session != null)
                    HttpContext.Current.Session["UserRoles"] = roles;
            }

            return roles?.ToArray();
        }

        public override bool RoleExists(string roleName) => Adapter.RoleExists(roleName) == 1;

        public override bool IsUserInRole(string username, string roleName)
        {
            var roles = this.GetRolesForUser(username);
            return roles.Any(e => e == roleName);
        }

        #endregion

        #region Not implemented

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get => throw new NotImplementedException();
            set => throw new NotImplementedException();
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
