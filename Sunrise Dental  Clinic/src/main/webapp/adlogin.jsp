<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sunrise Dental Clinic - Admin Login</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adlogin.css">
</head>

<body>

    <div class="page">

        <!-- Left Branding Section -->
        <div class="clinic-section">

            <div class="clinic-content">

                <div class="clinic-logo">
                    <div class="tooth-icon">🦷</div>
                </div>

                <h1>Sunrise</h1>
                <h2>Dental Clinic</h2>

                <div class="line"></div>

                <p>
                    Bright smiles, healthy teeth,<br>
                    and caring dental services.
                </p>

                <div class="clinic-info">
                    <span>✓ Professional Dental Care</span>
                    <span>✓ Modern Treatment</span>
                    <span>✓ Caring Service</span>
                </div>

            </div>

        </div>


        <!-- Login Section -->
        <div class="login-section">

            <div class="login-card">

                <div class="mobile-logo">
                    <div class="small-tooth">🦷</div>
                    <h2>Sunrise Dental Clinic</h2>
                </div>

                <div class="login-header">
                    <h2>Admin Login</h2>
                    <p>Welcome back! Please login to continue.</p>
                </div>


                <!-- Error Message -->
                <%
                    String errorMessage =
                        (String) request.getAttribute("errorMessage");

                    if (errorMessage != null) {
                %>

                    <div class="error-message">
                        <span>⚠</span>
                        <%= errorMessage %>
                    </div>

                <%
                    }
                %>


                <form action="${pageContext.request.contextPath}/adminlogin"
                      method="post"
                      onsubmit="return validateLogin()">

                    <!-- Email -->
                    <div class="form-group">

                        <label for="ademail">
                            Email Address
                        </label>

                        <div class="input-wrapper">

                            <span class="input-icon">✉</span>

                            <input type="email"
                                   id="ademail"
                                   name="ademail"
                                   placeholder="Enter your email address"
                                   autocomplete="email"
                                   required>

                        </div>

                    </div>


                    <!-- Password -->
                    <div class="form-group">

                        <label for="adpassword">
                            Password
                        </label>

                        <div class="input-wrapper">

                            <span class="input-icon">🔒</span>

                            <input type="password"
                                   id="adpassword"
                                   name="adpassword"
                                   placeholder="Enter your password"
                                   autocomplete="current-password"
                                   required>

                            <button type="button"
                                    class="show-password"
                                    onclick="togglePassword()"
                                    id="toggleBtn">
                                Show
                            </button>

                        </div>

                    </div>


                    <!-- Login Button -->
                    <button type="submit" class="login-btn">

                        <span>Login to Dashboard</span>
                        <span class="arrow">→</span>

                    </button>

                </form>


                <div class="login-footer">
                    <p>© 2026 Sunrise Dental Clinic</p>
                    <span>Admin Portal</span>
                </div>

            </div>

        </div>

    </div>


    <script>

        function togglePassword() {

            const password =
                document.getElementById("adpassword");

            const button =
                document.getElementById("toggleBtn");

            if (password.type === "password") {

                password.type = "text";
                button.textContent = "Hide";

            } else {

                password.type = "password";
                button.textContent = "Show";

            }
        }


        function validateLogin() {

            const email =
                document.getElementById("ademail").value.trim();

            const password =
                document.getElementById("adpassword").value.trim();


            if (email === "") {

                alert("Please enter your email address.");
                document.getElementById("ademail").focus();

                return false;
            }


            if (password === "") {

                alert("Please enter your password.");
                document.getElementById("adpassword").focus();

                return false;
            }


            return true;
        }

    </script>

</body>
</html>