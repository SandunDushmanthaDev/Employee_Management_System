document.addEventListener('DOMContentLoaded', function () {
    loadDepartments();
    loadPositions();
});

function loadDepartments() {
    fetch('/EmployeeManagementSystem/api/departments')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            var sel = document.getElementById('department');
            sel.innerHTML = '<option value="0" disabled selected>Select Department</option>';
            if (data.status) {
                data.data.forEach(function(dept) {
                    sel.innerHTML += '<option value="' + dept.id + '">' + dept.departmentName + '</option>';
                });
            }
        });
}

function loadPositions() {
    fetch('/EmployeeManagementSystem/api/positions')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            var sel = document.getElementById('position');
            sel.innerHTML = '<option value="0" disabled selected>Select Position</option>';
            if (data.status) {
                data.data.forEach(function(pos) {
                    sel.innerHTML += '<option value="' + pos.id + '">' + pos.positionName + '</option>';
                });
            }
        });
}

function submitEmployee() {
    if (!validateForm()) return;

    var submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Adding...';

    var data = {
        name: document.getElementById('name').value.trim(),
        email: document.getElementById('email').value.trim(),
        mobile: document.getElementById('mobile').value.trim(),
        hireDate: document.getElementById('hireDate').value,
        departmentId: parseInt(document.getElementById('department').value),
        positionId: parseInt(document.getElementById('position').value),
        salary: parseFloat(document.getElementById('salary').value)
    };

    fetch('/EmployeeManagementSystem/api/employees', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
        .then(function(r) { return r.json(); })
        .then(function(res) {
            if (res.status) {
                showToast(res.message, 'success');
                resetForm();
                setTimeout(function() {
                    window.location.href = 'employee-list.jsp';
                }, 1500);
            } else {
                showToast(res.message, 'error');
            }
        })
        .catch(function() {
            showToast('Failed to add employee!', 'error');
        })
        .finally(function() {
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<i class="fa-solid fa-plus"></i> Add Employee';
        });
}

function validateForm() {
    var valid = true;

    var name = document.getElementById('name').value.trim();
    var email = document.getElementById('email').value.trim();
    var mobile = document.getElementById('mobile').value.trim();
    var hireDate = document.getElementById('hireDate').value;
    var dept = document.getElementById('department').value;
    var pos = document.getElementById('position').value;
    var salary = document.getElementById('salary').value;


    if (!name || name.length < 2) {
        showError('name'); valid = false;
    } else { hideError('name'); }

    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        showError('email'); valid = false;
    } else { hideError('email'); }


    var mobileRegex = /^07[0-9]{8}$/;
    if (!mobileRegex.test(mobile)) {
        showError('mobile'); valid = false;
    } else { hideError('mobile'); }


    if (!hireDate) {
        showError('hireDate'); valid = false;
    } else { hideError('hireDate'); }


    if (!dept || dept === '0') {
        showError('department'); valid = false;
    } else { hideError('department'); }


    if (!pos || pos === '0') {
        showError('position'); valid = false;
    } else { hideError('position'); }

    if (!salary || parseFloat(salary) <= 0) {
        showError('salary'); valid = false;
    } else { hideError('salary'); }

    return valid;
}

function showError(field) {
    document.getElementById(field).classList.add('input-error');
    document.getElementById(field + 'Error').style.display = 'block';
}

function hideError(field) {
    document.getElementById(field).classList.remove('input-error');
    document.getElementById(field + 'Error').style.display = 'none';
}

function resetForm() {
    ['name','email','mobile','hireDate','salary'].forEach(function(f) {
        document.getElementById(f).value = '';
        hideError(f);
    });
    document.getElementById('department').value = '0';
    document.getElementById('position').value = '0';
    hideError('department');
    hideError('position');
}

function showToast(msg, type) {
    var toast = document.getElementById('toast');
    toast.textContent = msg;
    toast.className = 'toast ' + type + ' show';
    setTimeout(function() { toast.classList.remove('show'); }, 3000);
}

function logout() {
    fetch('/EmployeeManagementSystem/api/auth/logout')
        .then(function() { window.location.href = '/EmployeeManagementSystem/sign-in.jsp'; });
}