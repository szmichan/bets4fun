using System;
using System.Web;
using Bets4Fun.DBTableAdapters;
using System.ComponentModel;
using System.Web.Security;
using Bets4Fun.Common;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class UsersLogic : MembershipProvider
    {
        private static UsersTableAdapter _usersAdapter;
        public static UsersTableAdapter UsersAdapter
        {
            set => _usersAdapter = value;
            get => _usersAdapter ?? new UsersTableAdapter();
        }

        private static Users_LeaguesTableAdapter _usersLeaguesAdapter;
        public static Users_LeaguesTableAdapter UsersLeaguesAdapter
        {
            set => _usersLeaguesAdapter = value;
            get => _usersLeaguesAdapter ?? new Users_LeaguesTableAdapter();
        }


        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static DB.UsersDataTable GetUsers() => UsersAdapter.GetUsers();

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static bool AddUser(string login, string firstName, string lastName, string password, string email, bool isActive)
        {
            UsersAdapter.Insert(login, firstName, lastName, password, email, isActive, true, out var ret);
            return ret == 0;
        }

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public static bool UpdateUser(string login, string firstName, string lastName, string password, bool isActive, string email, int id)
        {
            if (password == null)
                return UsersAdapter.UpdateWithoutPassword(login, firstName, lastName, isActive, email, id) == 1;

            return UsersAdapter.Update(login, firstName, lastName, password, isActive, email, id) == 1;
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public static bool UpdateOtherData(string firstName, string lastName, string login) 
            => UsersAdapter.UpdateOtherData(firstName, lastName, login) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public static bool DeleteUser(int id) 
            => UsersAdapter.Delete(id) == 1;

        public static bool LoginExists(string login)
        {
            var table = UsersAdapter.GetUsersByLogin(login);

            switch (table.Rows.Count)
            {
                case 1:
                    return true;
                case 0:
                    return false;
                default:
                    throw new ZpException($"There is more than one User with the same Login = {login}");
            }
        }

        public static DB.UsersRow GetUserByLogin(string login)
        {
            var table = UsersAdapter.GetUsersByLogin(login);

            switch (table.Rows.Count)
            {
                case 1:
                    return table[0];
                case 0:
                    return null;
                default:
                    throw new ZpException($"There is more than one User with the same Login = {login}");
            }
        }

        public static DB.UsersRow GetUserById(int id)
        {
            var table = UsersAdapter.GetUserById(id);

            switch (table.Rows.Count)
            {
                case 1:
                    return table[0];
                case 0:
                    return null;
                default:
                    throw new ZpException($"There is more than one User with the same Id = {id}");
            }
        }

        public static bool AssignUserToRole(int userId, int roleId) 
            => UsersAdapter.AssignUserToRole(userId, roleId) == 1;

        public static bool RevokeUserFromRole(int userId, int roleId) 
            => UsersAdapter.RevokeUserFromRole(userId, roleId) == 1;

        public static void ActivateUser(int userId, bool activate) 
            => UsersAdapter.ActivateUser(userId, activate);

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public static int AssignUserToLeague(int userId, int leagueId) 
            => UsersLeaguesAdapter.Insert(userId, leagueId);

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public static int RevokeUserFromLeague(int userId, int leagueId) 
            => UsersLeaguesAdapter.Delete(userId, leagueId);

        public static bool ResetPass(string login, string newPassword)
        {
            var result = UsersAdapter.ResetPassword(login, newPassword);
            switch (result)
            {
                case 1:
                    return true;
                case 0:
                    return false;
                default:
                    throw new ZpException($"Multiple Users with the same login '{login}'");
            }
        }

        public static bool UpdateLanguage(int userId, int languageId) 
            => UsersAdapter.UpdateLanguage(userId, languageId) == 1;

        #region Implemented

        public override bool ValidateUser(string username, string password)
        {
            var user = UsersLogic.GetUserByLogin(username);
            if (user != null)
            {
                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session[SessionKeys.UserId] = user.Id;
                    HttpContext.Current.Session[SessionKeys.CultureInfoName] = user.CultureInfoName;
                    HttpContext.Current.Session[SessionKeys.LanguageId] = user.Language_Id;
                }

                return (PasswordEncoder.EncodePasswordMd5(password).Equals(user.Password) && user.IsActive && user.IsActivated);
            }

            return false;
        }

        public override bool RequiresQuestionAndAnswer => /*throw new NotImplementedException();*/false;

        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            UsersAdapter.Insert(username, null, null, PasswordEncoder.EncodePasswordMd5(password), email, true, false, out var ret);

            switch (ret)
            {
                case -1:
                    status = MembershipCreateStatus.DuplicateUserName;
                    break;
                case -2:
                    status = MembershipCreateStatus.DuplicateEmail;
                    break;
                case 0:
                    status = MembershipCreateStatus.Success;
                    break;
                default:
                    status = MembershipCreateStatus.UserRejected;
                    break;
            }

            return null;
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            var result = UsersAdapter.ChangePassword(username, oldPassword, newPassword);

            switch (result)
            {
                case 1:
                    return true;
                case 0:
                    return false;
                default:
                    throw new ZpException($"Multiple Users with the same login '{username}'");
            }
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            MembershipUser memUser = null;

            var user = UsersLogic.GetUserByLogin(username);

            if (user != null)
                memUser = new MembershipUser(null, user.Login, null, user.Email, null, null, true, false, DateTime.MinValue, DateTime.MinValue, DateTime.MinValue, DateTime.Now.AddDays(-1), DateTime.MinValue);

            return memUser;
        }

        #endregion

        #region Not Implemented

        public override string ApplicationName
        {
            get => throw new NotImplementedException();
            set => throw new NotImplementedException();
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override bool EnablePasswordReset => throw new NotImplementedException();

        public override bool EnablePasswordRetrieval => throw new NotImplementedException();

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }


        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }

        public override int MaxInvalidPasswordAttempts => throw new NotImplementedException();

        public override int MinRequiredNonAlphanumericCharacters => throw new NotImplementedException();

        public override int MinRequiredPasswordLength => throw new NotImplementedException();

        public override int PasswordAttemptWindow => throw new NotImplementedException();

        public override MembershipPasswordFormat PasswordFormat => throw new NotImplementedException();

        public override string PasswordStrengthRegularExpression => throw new NotImplementedException();


        public override bool RequiresUniqueEmail => throw new NotImplementedException();

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(MembershipUser user)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
