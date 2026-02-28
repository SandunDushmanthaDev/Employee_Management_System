function signIn() {
    var username = document.getElementById('username').value.trim();
    var password = document.getElementById('password').value.trim();

    document.getElementById('errorAlert').classList.remove('show');

    if (!username || !password) {
        showError('Username and password are required!');
        return;
    }

    var btn = document.getElementById('signinBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Signing in...';

    fetch('/EmployeeManagementSystem/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username: username, password: password })
    })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status) {
                if (data.userTypeId === 1) {

                    window.location.href = '/EmployeeManagementSystem/dashboard.jsp';
                } else if (data.userTypeId === 2) {

                    window.location.href = '/EmployeeManagementSystem/employee-details.jsp';
                } else {
                    showError('Access denied!');
                }
            } else {
                showError(data.message);
            }
        })
        .catch(function() {
            showError('Connection failed! Please try again.');
        })
        .finally(function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="fa-solid fa-right-to-bracket"></i> Sign In';
        });
}

function showError(msg) {
    document.getElementById('errorMsg').textContent = msg;
    document.getElementById('errorAlert').classList.add('show');
}

function togglePassword() {
    var field = document.getElementById('password');
    var icon = document.getElementById('eyeIcon');
    if (field.type === 'password') {
        field.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        field.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}

document.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') signIn();
});