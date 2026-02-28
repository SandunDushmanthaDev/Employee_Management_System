<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign In | Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/sign-in.css">

</head>
<body>

<div class="glow" style="top:10%; left:20%;"></div>
<div class="glow" style="bottom:10%; right:20%;"></div>

<div class="login-card">
    <div class="brand-section">
        <div class="logo-icon"><i class="fa-solid fa-lock"></i></div>
        <h1 class="brand-name">Employee Management <span>System</span></h1>
    </div>

    <div class="alert-box alert-error" id="errorAlert">
        <i class="fa-solid fa-circle-xmark"></i>
        <span id="errorMsg">Invalid username or password!</span>
    </div>

    <div class="form-group">
        <label>Username</label>
        <div class="input-wrapper">
            <i class="fa-solid fa-user prefix-icon"></i>
            <input type="text" id="username" placeholder="Enter your username"/>
        </div>
    </div>

    <div class="form-group">
        <label>Password</label>
        <div class="input-wrapper">
            <i class="fa-solid fa-key prefix-icon"></i>
            <input type="password" id="password" placeholder="••••••••"/>
            <i class="fa-solid fa-eye toggle-password" id="eyeIcon" onclick="togglePassword()"></i>
        </div>
    </div>

    <button class="btn-signin" id="signinBtn" onclick="signIn()">
        <i class="fa-solid fa-right-to-bracket"></i> Sign In
    </button>
</div>

<script src="assets/js/sign-in.js"></script>
</body>
</html>