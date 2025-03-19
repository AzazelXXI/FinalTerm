using FinalTerm.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FinalTerm.Controllers
{
    public class AccountController : Controller
    {
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            if (model.Username == "admin" && model.Password == "123")
            {
                return RedirectToAction("Index", "Home");
            }
            else if (model.Username == "test" && model.Password == "test")
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng.");
                return View(model);
            }
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterViewModel model, string Day, string Month, string Year)
        {
            if (ModelState.IsValid)
            {
                // Convert Date of Birth
                if (int.TryParse(Day, out int d) && int.TryParse(Month, out int m) && int.TryParse(Year, out int y))
                {
                    model.DateOfBirth = new DateTime(y, m, d);
                }

                // TODO: Lưu model vào database
                TempData["SuccessMessage"] = "Registration successful!";
                return RedirectToAction("Login");
            }
            return View(model);
        }

        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpGet]
        public ActionResult ResetPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ResetPassword(ResetPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Xử lý logic đổi mật khẩu ở đây (gọi database để cập nhật mật khẩu mới)
                ViewBag.Message = "Your password has been updated successfully!";
                return View();
            }

            return View(model);
        }
    }
}