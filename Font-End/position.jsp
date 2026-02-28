<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Positions | Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/position.css">
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="logo-icon"><i class="fa-solid fa-users"></i></div>
        <div class="logo-text">Employee Management <span>System</span></div>
    </div>
    <nav class="sidebar-nav">
        <span class="nav-label">Main</span>
        <a href="dashboard.jsp" class="nav-item">
            <i class="fa-solid fa-gauge-high"></i> Dashboard
        </a>
        <a href="employee-list.jsp" class="nav-item">
            <i class="fa-solid fa-user"></i> Employees
        </a>
        <a href="add-employee.jsp" class="nav-item">
            <i class="fa-solid fa-user-plus"></i> Add Employee
        </a>
        <span class="nav-label">System</span>
        <a href="department.jsp" class="nav-item">
            <i class="fa-solid fa-building"></i> Departments
        </a>
        <a href="position.jsp" class="nav-item active">
            <i class="fa-solid fa-briefcase"></i> Positions
        </a>
    </nav>
</aside>

<div class="main">
    <div class="topbar">
        <div class="page-title">Positions</div>
    </div>

    <div class="content">
        <div class="table-container-slim">
            <div class="table-section">
                <div class="table-header">
                    <div class="table-title">Job Designations</div>
                </div>

                <div class="table-wrap">
                    <table>
                        <thead>
                        <tr>
                            <th style="width: 150px;">Pos. Code</th>
                            <th>Position Name</th>
                        </tr>
                        </thead>
                        <tbody id="positionTableBody">
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <i class="fa-solid fa-spinner fa-spin"></i> Loading...
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-footer" style="justify-content: center; opacity: 0.7;">
                    <small>System managed All Positions</small>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/position.js"></script>

</body>
</html>