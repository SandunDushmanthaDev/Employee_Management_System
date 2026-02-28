<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sandun.employeemanagementsystem.entity.SignIn" %>
<%
    SignIn signIn = (SignIn) session.getAttribute("signIn");
    if (signIn == null) {
        response.sendRedirect(request.getContextPath() + "/sign-in.jsp");
        return;
    }

    String employeeName   = (String) session.getAttribute("employeeName");
    String userTypeStr    = (String) session.getAttribute("userType");
    String departmentName = (String) session.getAttribute("departmentName");
    String positionName   = (String) session.getAttribute("positionName");
    String email          = (String) session.getAttribute("email");
    String mobile         = (String) session.getAttribute("mobile");
    String username       = (String) session.getAttribute("username");
    String hireDate       = (String) session.getAttribute("hireDate");
    double salary         = session.getAttribute("salary") != null ? (double) session.getAttribute("salary") : 0.0;
    int    employeeId     = session.getAttribute("employeeId") != null ? (int) session.getAttribute("employeeId") : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Employee Profile | Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/employee-details.css">
</head>
<body>

<div class="glow" style="top:0; left:5%;"></div>
<div class="glow" style="bottom:0; right:5%;"></div>

<div class="top-nav">
    <div class="nav-brand">Employee Management <span>System</span></div>
</div>

<div class="profile-card">

    <div class="card-header">
        <div class="header-deco"><span></span><span></span><span></span></div>

        <div class="avatar-wrap">
            <div class="avatar"><i class="fa-solid fa-user-tie"></i></div>
            <div class="online-dot"></div>
        </div>
        <div class="emp-name"><%= employeeName %></div>
        <div><span class="role-pill"><i class="fa-solid fa-id-badge"></i> &nbsp;<%= userTypeStr %></span></div>
    </div>

    <div class="card-body">

        <div class="section-label"><i class="fa-solid fa-user-circle"></i> Personal Information</div>
        <div class="fields-grid">

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-user"></i> Full Name</div>
                <div class="field-val"><%= employeeName %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-envelope"></i> Email Address</div>
                <div class="field-val"><%= email != null ? email : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-phone"></i> Mobile</div>
                <div class="field-val"><%= mobile != null ? mobile : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-id-card"></i> Employee ID</div>
                <div class="field-val blue"><%= String.format("%03d", employeeId) %></div>
            </div>

        </div>

        <div class="section-label"><i class="fa-solid fa-building"></i> Job Information</div>
        <div class="fields-grid">

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-layer-group"></i> Department</div>
                <div class="field-val"><%= departmentName != null ? departmentName : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-briefcase"></i> Position</div>
                <div class="field-val"><%= positionName != null ? positionName : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-calendar-days"></i> Hire Date</div>
                <div class="field-val"><%= hireDate != null ? hireDate : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-coins"></i> Salary</div>
                <div class="field-val blue">LKR <%= String.format("%,.2f", salary) %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-user-shield"></i> Username</div>
                <div class="field-val blue"><%= username != null ? username : "—" %></div>
            </div>

            <div class="field-box">
                <div class="field-lbl"><i class="fa-solid fa-circle-check"></i> Status</div>
                <div class="field-val"><span class="field-val green">Active</span></div>
            </div>

        </div>
    </div>

    <div class="card-footer">
        <span><i class="fa-solid fa-shield-halved"></i>Secure Session Active</span>
        <span class="view-only-notice"><i class="fa-solid fa-lock"></i> Read-Only Access</span>
        <span><i class="fa-solid fa-clock"></i><%= new java.util.Date() %></span>
    </div>
</div>

</body>
</html>