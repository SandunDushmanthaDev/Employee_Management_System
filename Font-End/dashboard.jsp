<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard | Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="logo-icon"><i class="fa-solid fa-users"></i></div>
        <div class="logo-text">Employee Management <span>System</span></div>
    </div>
    <nav class="sidebar-nav">
        <span class="nav-label">Main</span>
        <a href="dashboard.jsp" class="nav-item active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
        <a href="employee-list.jsp" class="nav-item"><i class="fa-solid fa-user"></i> Employees</a>
        <a href="add-employee.jsp" class="nav-item"><i class="fa-solid fa-user-plus"></i> Add Employee</a>
        <span class="nav-label">System</span>
        <a href="department.jsp" class="nav-item"><i class="fa-solid fa-building"></i> Departments</a>
        <a href="position.jsp" class="nav-item"><i class="fa-solid fa-briefcase"></i> Positions</a>
    </nav>
    <div class="sidebar-footer">
        <div class="user-pill">
            <div class="avatar">A</div>
            <div class="user-info">
                <div class="user-name">Admin</div>
            </div>
            <button class="logout-btn" title="Logout" onclick="logout()">
                <i class="fa-solid fa-right-from-bracket"></i>
            </button>
        </div>
    </div>
</aside>

<div class="main">
    <div class="topbar">
        <div><div class="page-title">Dashboard</div></div>
        <div class="topbar-right">
            <a href="add-employee.jsp" class="btn btn-primary">
                <i class="fa-solid fa-plus"></i> Add Employee
            </a>
        </div>
    </div>

    <div class="content">
        <div class="stats-row">
            <div class="stat-card c-blue">
                <div class="stat-top">
                    <div class="stat-icon si-blue"><i class="fa-solid fa-users"></i></div>
                    <span class="stat-badge badge-green"><i class="fa-solid fa-arrow-up"></i> Active</span>
                </div>
                <div class="stat-number" id="totalEmployees">0</div>
                <div class="stat-label">Total Employees</div>
            </div>
            <div class="stat-card c-sky">
                <div class="stat-top">
                    <div class="stat-icon si-sky"><i class="fa-solid fa-building"></i></div>
                    <span class="stat-badge badge-green"><i class="fa-solid fa-arrow-up"></i> Active</span>
                </div>
                <div class="stat-number" id="totalDepartments">0</div>
                <div class="stat-label">Total Departments</div>
            </div>
            <div class="stat-card c-gold">
                <div class="stat-top">
                    <div class="stat-icon si-gold"><i class="fa-solid fa-user-plus"></i></div>
                    <span class="stat-badge badge-gold">This Month</span>
                </div>
                <div class="stat-number" id="newlyJoined">0</div>
                <div class="stat-label">Newly Joined Employees</div>
            </div>
        </div>

        <div class="table-section">
            <div class="table-header">
                <div class="table-title">Recent Registered Employees</div>
                <div class="table-actions">
                    <a href="employee-list.jsp" class="btn btn-outline">
                        View All <i class="fa-solid fa-arrow-right"></i>
                    </a>
                    <a href="add-employee.jsp" class="btn btn-primary">
                        <i class="fa-solid fa-plus"></i> Add New
                    </a>
                </div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Employee Name</th>
                        <th>Department</th>
                        <th>Position</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Hire Date</th>
                        <th>Salary</th>
                    </tr>
                    </thead>
                    <tbody id="recentTableBody">
                    <tr>
                        <td colspan="8" style="text-align:center;">
                            <i class="fa-solid fa-spinner fa-spin"></i> Loading...
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="table-footer">
                <div id="tableInfo" style="color: gray; font-size:13px;">Showing last 3 employees</div>
                <a href="employee-list.jsp" class="btn btn-outline" style="font-size:12px; padding:6px 14px;">
                    View All Employees <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/dashboard.js"></script>
</body>
</html>