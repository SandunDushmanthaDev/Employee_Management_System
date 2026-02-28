document.addEventListener('DOMContentLoaded', function () {
    loadDashboardData();
});

function loadDashboardData() {

    fetch('/EmployeeManagementSystem/api/employees')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status && data.data) {
                var employees = data.data;
                var total = employees.length;

                animateCount('totalEmployees', total);

                var now = new Date();
                var thisMonth = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0');
                var newJoined = employees.filter(function(emp) {
                    return emp.hireDate && emp.hireDate.startsWith(thisMonth);
                }).length;
                animateCount('newlyJoined', newJoined);

                var recent = employees.slice(-3).reverse();
                renderRecentTable(recent);
            }
        })
        .catch(function() {
            document.getElementById('recentTableBody').innerHTML =
                '<tr><td colspan="8" style="text-align:center; color:red;">Failed to load data!</td></tr>';
        });

    fetch('/EmployeeManagementSystem/api/departments')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status && data.data) {
                animateCount('totalDepartments', data.data.length);
            }
        });
}

function renderRecentTable(employees) {
    var tbody = document.getElementById('recentTableBody');
    if (employees.length === 0) {
        tbody.innerHTML = '<tr><td colspan="8" style="text-align:center; opacity:0.6; padding:32px;">No employees found</td></tr>';
        return;
    }
    tbody.innerHTML = '';
    employees.forEach(function(emp) {
        var idBadge = '' + String(emp.id).padStart(3, '0');
        var salary = 'Rs. ' + Number(emp.salary).toLocaleString();
        var hireDate = emp.hireDate ? emp.hireDate : '-';
        tbody.innerHTML +=
            '<tr>' +
            '<td><span class="id-badge">' + idBadge + '</span></td>' +
            '<td><div class="name-cell"><div class="emp-name">' + emp.name + '</div></div></td>' +
            '<td><span class="dept-badge d-it">' + emp.departmentName + '</span></td>' +
            '<td><span class="dept-badge p-it">' + emp.positionName + '</span></td>' +
            '<td>' + emp.email + '</td>' +
            '<td>' + emp.mobile + '</td>' +
            '<td>' + hireDate + '</td>' +
            '<td><span class="salary-text">' + salary + '</span></td>' +
            '</tr>';
    });
}

function animateCount(elementId, target) {
    var el = document.getElementById(elementId);
    var current = 0;
    var step = Math.ceil(target / 40) || 1;
    var timer = setInterval(function() {
        current = Math.min(current + step, target);
        el.textContent = current;
        if (current >= target) clearInterval(timer);
    }, 28);
}

function logout() {
    fetch('/EmployeeManagementSystem/api/auth/logout')
        .then(function() { window.location.href = '/EmployeeManagementSystem/sign-in.jsp'; });
}