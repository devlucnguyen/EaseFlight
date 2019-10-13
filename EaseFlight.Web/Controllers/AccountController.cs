﻿using EaseFlight.BLL.Interfaces;
using EaseFlight.Common.Constants;
using EaseFlight.Common.EmailSenders;
using EaseFlight.Common.Utilities;
using EaseFlight.Models.EntityModels;
using EaseFlight.Web.WebUtilities;
using System;
using System.Web.Mvc;

namespace EaseFlight.Web.Controllers
{
    public class AccountController : Controller
    {
        #region Properties
        private IAccountService AccountService { get; set; }
        private IAccountTypeService AccountTypeService { get; set; }
        #endregion

        #region Constructors
        public AccountController(IAccountService accountService, IAccountTypeService accountTypeService)
        {
            this.AccountService = accountService;
            this.AccountTypeService = accountTypeService;
        }
        #endregion

        #region Actions
        [HttpPost]
        public JsonResult Login(FormCollection collection)
        {
            var userModel = this.AccountService.FindByUsername(collection.Get("username"));

            if (userModel != null && !string.IsNullOrEmpty(userModel.Password) && EncryptionUtility.BcryptCheckPassword(collection.Get("password"), userModel.Password))
            {
                SessionUtility.SetAuthenticationToken(userModel, 60);

                return new JsonResult { ContentType = "text", Data = new { msg = "success" } };

            }

            return new JsonResult { ContentType = "text", Data = new { msg = Constant.CONST_MESSAGE_LOGIN_INVALID } };
        }

        [HttpGet]
        public ActionResult Logout()
        {
            SessionUtility.Logout();

            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public ActionResult AccessDenied()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Register(FormCollection collection)
        {
            var result = new JsonResult { ContentType = "text" };
            var userModel = new AccountModel
            {
                Username = collection.Get("username"),
                FullName = collection.Get("fullname"),
                Email = collection.Get("email"),
                Password = EncryptionUtility.BcryptHashPassword(collection.Get("password")),
                AccountTypeID = this.AccountTypeService.FindByName(Constant.CONST_ROLE_USER).ID,
                Status = true
            };

            this.AccountService.Insert(userModel);

            return result;
        }

        [HttpPost]
        public JsonResult ForgotPassword(FormCollection collection)
        {
            var result = new JsonResult { ContentType = "text" };
            var userModel = this.AccountService.CheckUsernameExists(collection.Get("username"), collection.Get("username"));
            var baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";

            if (userModel != null)
            {
                if (string.IsNullOrEmpty(userModel.Password))
                    result.Data = new { type = "error", msg = Constant.CONST_MESSAGE_USERNAME_LOGIN_WITH_GG_FB };
                else
                {
                    var salt = EncryptionUtility.BcryptGenerateSalt(12);
                    var token = EncryptionUtility.Base64Encode(userModel.ID + " " + salt);

                    if (EmailSender.Send(userModel.Email, baseUrl, token))
                    {
                        result.Data = new { type = "success", msg = Constant.CONST_MESSAGE_EMAIL_SENT_RESET_PASSWORD_SUCCESS };
                        userModel.ResetPasswordToken = salt;
                        userModel.ExpireToken = DateTime.Now.AddMinutes(30);

                        this.AccountService.Update(userModel);
                    }
                }
            }
            else result.Data = new { type = "error", msg = Constant.CONST_MESSAGE_USERNAME_OR_EMAIL_INVALID };

            return result;
        }

        [HttpGet]
        public ActionResult ResetPassword(string rt)
        {
            try
            {
                var token = EncryptionUtility.Base64Decode(rt).Split(' '); // [0] is Id user, [1] is token
                var currentUser = this.AccountService.Find(int.Parse(token[0]));

                if (currentUser != null)
                    if (currentUser.ExpireToken >= DateTime.Now && currentUser.ResetPasswordToken.Equals(token[1]))
                        return View(currentUser);
                    else if (currentUser.ExpireToken < DateTime.Now)
                    {
                        currentUser.ResetPasswordToken = null;
                        currentUser.Password = null;

                        this.AccountService.Update(currentUser);
                    }
            }
            catch
            {
            }

            return RedirectToAction("Login", "Account");
        }

        [HttpPost]
        public ActionResult ResetPassword(AccountModel model)
        {
            var userModel = this.AccountService.Find(model.ID);

            userModel.Password = EncryptionUtility.BcryptHashPassword(model.Password);
            userModel.ResetPasswordToken = null;
            userModel.ExpireToken = null;
            this.AccountService.Update(userModel);

            return RedirectToAction("Login", "Account");
        }

        [HttpPost]
        public JsonResult CheckUsernameExist(FormCollection collection)
        {
            var result = new JsonResult { ContentType = "text", Data = new { msg = "" } };
            var username = collection.Get("username");
            var email = collection.Get("email");
            var user = this.AccountService.CheckUsernameExists(username, email);

            if (user != null)
            {
                if (user.Username.Equals(username)) result.Data = new { msg = "Username" };
                else result.Data = new { msg = "Email" };
            }

            return result;
        }

        [HttpPost]
        public JsonResult ThirdPartyLogin(string id, string name, string email, string picture)
        {
            var currentUser = this.AccountService.FindByUsername(id);

            if (currentUser == null)
            {
                var user = new AccountModel
                {
                    Username = id,
                    FullName = name,
                    Email = email,
                    Photo = picture,
                    AccountTypeID = this.AccountTypeService.FindByName(Constant.CONST_ROLE_USER).ID,
                    Status = true
                };

                this.AccountService.Insert(user);
                SessionUtility.SetAuthenticationToken(user, 60);
            }
            else SessionUtility.SetAuthenticationToken(currentUser, 60);

            return new JsonResult { ContentType = "text" };
        }

        [HttpGet]
        public ActionResult MyProfile()
        {
            return View();
        }

        [HttpPost]
        public JsonResult AnyUserLogged()
        {
            var result = new JsonResult { ContentType = "text", Data = new { msg = "false" } };

            if (SessionUtility.IsSessionAlive())
                result.Data = new { msg = "true" };

            return result;
        }
        #endregion
    }
}