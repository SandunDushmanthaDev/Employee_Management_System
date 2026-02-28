<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Employee – Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
   <link rel="stylesheet" href="assets/css/add-employee.css">
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="logo-icon"><i class="fa-solid fa-users"></i></div>
        <div class="logo-text">Employee Management <span>System</span></div>
    </div>
    <nav class="sidebar-nav">
        <span class="nav-label">Main</span>
        <a href="dashboard.jsp" class="nav-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
        <a href="employee-list.jsp" class="nav-item"><i class="fa-solid fa-user"></i> Employees</a>
        <a href="add-employee.jsp" class="nav-item active"><i class="fa-solid fa-user-plus"></i> Add Employee</a>
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
        <div><div class="page-title">Add New Employee</div></div>
        <div class="topbar-right">
            <a href="employee-list.jsp" class="btn btn-outline">
                <i class="fa-solid fa-arrow-left"></i> Back to Employees
            </a>
        </div>
    </div>

    <div class="content">
        <div class="form-container">

            <!-- Basic Information -->
            <div class="section-subtitle">
                <i class="fa-solid fa-circle-info"></i> Basic Information
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" id="name" placeholder="Enter employee Full Name"/>
                    <span class="error-msg" id="nameError">Valid name required (letters only)</span>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" id="email" placeholder="Enter employee Email Address"/>
                    <span class="error-msg" id="emailError">Valid email required</span>
                </div>
                <div class="form-group">
                    <label>Mobile Number</label>
                    <input type="text" id="mobile" placeholder="07XXXXXXXX"/>
                    <span class="error-msg" id="mobileError">Valid mobile required (07XXXXXXXX)</span>
                </div>
                <div class="form-group">
                    <label>Hire Date</label>
                    <input type="date" id="hireDate"/>
                    <span class="error-msg" id="hireDateError">Hire date required</span>
                </div>
            </div>

            <hr>

            <!-- Job Assignment -->
            <div class="section-subtitle">
                <i class="fa-solid fa-briefcase"></i> Job Assignment
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Department</label>
                    <select id="department">
                        <option value="0" disabled selected>Loading departments...</option>
                    </select>
                    <span class="error-msg" id="departmentError">Please select a department</span>
                </div>
                <div class="form-group">
                    <label>Position / Role</label>
                    <select id="position">
                        <option value="0" disabled selected>Loading positions...</option>
                    </select>
                    <span class="error-msg" id="positionError">Please select a position</span>
                </div>
                <div class="form-group">
                    <label>Salary (LKR)</label>
                    <input type="number" id="salary" placeholder="Rs.75,000"/>
                    <span class="error-msg" id="salaryError">Valid salary required</span>
                </div>
            </div>

            <div class="form-footer">
                <button type="button" class="btn btn-outline" onclick="resetForm()">
                    <i class="fa-solid fa-rotate-left"></i> Reset
                </button>
                <button type="button" class="btn btn-primary" id="submitBtn" onclick="submitEmployee()">
                    <i class="fa-solid fa-plus"></i> Add Employee
                </button>
            </div>
        </div>
    </div>
</div>

<div class="toast" id="toast"></div>

<script src="assets/js/add-employee.js"></script>

</body>
</html>