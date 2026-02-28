document.addEventListener('DOMContentLoaded', function () {
    loadDepartments();
});

function loadDepartments() {
    const tbody = document.getElementById('departmentTableBody');

    fetch('/EmployeeManagementSystem/api/departments')
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.status && data.data.length > 0) {
                tbody.innerHTML = '';
                data.data.forEach(function(dept) {
                    const idFormatted = 'DEPT-' + String(dept.id).padStart(3, '0');
                    tbody.innerHTML += '<tr>' +
                        '<td><span class="id-badge" style="padding: 6px 12px; font-size: 12px;">' + idFormatted + '</span></td>' +
                        '<td><div class="name-cell"><div class="emp-name" style="font-size: 15px;">' + dept.departmentName + '</div></div></td>' +
                        '</tr>';
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="2" style="text-align:center; opacity:0.6;">No departments found</td></tr>';
            }
        })
        .catch(function(error) {
            console.log('Error: ' + error);
            tbody.innerHTML = '<tr><td colspan="2" style="text-align:center; color:red;">Failed to load departments!</td></tr>';
        });
}