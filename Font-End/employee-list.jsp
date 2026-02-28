<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Employee List | Employee Management System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Outfit:wght@300;400;500;600&display=swap"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/employee-list.css"/>

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
        <a href="employee-list.jsp" class="nav-item active"><i class="fa-solid fa-user"></i> Employees</a>
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
        <div><div class="page-title">Employee Details</div></div>
        <div class="topbar-right">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="searchInput" placeholder="Search by name, dept, position..." oninput="searchEmployees()">
            </div>
            <a href="add-employee.jsp" class="btn btn-primary">
                <i class="fa-solid fa-plus"></i> Add New
            </a>
        </div>
    </div>

    <div class="content">
        <div class="table-section">
            <div class="table-header">
                <div class="table-title">All Registered Employees</div>
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
                        <th style="text-align:right;">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="employeeTableBody">
                    <tr><td colspan="9" style="text-align:center;padding:40px;"><i class="fa-solid fa-spinner fa-spin"></i> Loading...</td></tr>
                    </tbody>
                </table>
            </div>

            <!-- Footer: info LEFT | pagination RIGHT -->
            <div class="table-footer">
                <div class="table-info" id="tableInfo">Loading...</div>
                <div class="pagination" id="pagination"></div>
            </div>
        </div>
    </div>
</div>

<!-- VIEW MODAL -->
<div class="modal-overlay" id="viewModal">
    <div class="modal">
        <div class="modal-header">
            <div class="modal-title"><i class="fa-solid fa-eye" style="color:#6366f1;margin-right:8px;"></i>Employee Details</div>
            <button class="modal-close" onclick="closeModal('viewModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="emp-avatar-large" id="viewAvatar"></div>
        <div class="view-grid">
            <div class="view-item"><div class="view-label">Full Name</div><div class="view-value" id="viewName">-</div></div>
            <div class="view-item"><div class="view-label">Department</div><div class="view-value" id="viewDept">-</div></div>
            <div class="view-item"><div class="view-label">Position</div><div class="view-value" id="viewPosition">-</div></div>
            <div class="view-item"><div class="view-label">Email</div><div class="view-value" id="viewEmail">-</div></div>
            <div class="view-item"><div class="view-label">Mobile</div><div class="view-value" id="viewMobile">-</div></div>
            <div class="view-item"><div class="view-label">Hire Date</div><div class="view-value" id="viewHireDate">-</div></div>
            <div class="view-item"><div class="view-label">Salary</div><div class="view-value" id="viewSalary">-</div></div>
        </div>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <div class="modal-header">
            <div class="modal-title"><i class="fa-solid fa-pen" style="color:#6366f1;margin-right:8px;"></i>Edit Employee</div>
            <button class="modal-close" onclick="closeModal('editModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <input type="hidden" id="editId"/>
        <div class="form-row">
            <div class="form-group"><label>Full Name</label><input type="text" id="editName" placeholder="Employee name"/></div>
            <div class="form-group"><label>Email</label><input type="email" id="editEmail" placeholder="Email address"/></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>Mobile</label><input type="text" id="editMobile" placeholder="07XXXXXXXX"/></div>
            <div class="form-group"><label>Hire Date</label><input type="date" id="editHireDate"/></div>
        </div>
        <div class="form-row">
            <div class="form-group"><label>Department</label><select id="editDepartment"></select></div>
            <div class="form-group"><label>Position</label><select id="editPosition"></select></div>
        </div>
        <div class="form-group"><label>Salary (LKR)</label><input type="number" id="editSalary" placeholder="Monthly salary"/></div>
        <div class="modal-footer">
            <button class="btn-cancel" onclick="closeModal('editModal')">Cancel</button>
            <button class="btn-save" onclick="saveEmployee()"><i class="fa-solid fa-floppy-disk"></i> Save Changes</button>
        </div>
    </div>
</div>

<!-- DELETE MODAL -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal" style="max-width:400px;">
        <div class="modal-header" style="justify-content:flex-end;margin-bottom:0;">
            <button class="modal-close" onclick="closeModal('deleteModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="delete-icon"><i class="fa-solid fa-trash"></i></div>
        <div class="delete-title">Delete Employee?</div>
        <div class="delete-subtitle">This action cannot be undone. The employee will be permanently removed.</div>
        <input type="hidden" id="deleteId"/>
        <div class="modal-footer" style="justify-content:center;">
            <button class="btn-cancel" onclick="closeModal('deleteModal')">Cancel</button>
            <button class="btn-delete-confirm" onclick="confirmDelete()"><i class="fa-solid fa-trash"></i> Delete</button>
        </div>
    </div>
</div>

<div class="toast" id="toast"></div>

<script src="assets/js/employee-list.js"></script>
</body>
</html>
