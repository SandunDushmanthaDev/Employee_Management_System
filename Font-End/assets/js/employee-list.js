var allEmployees      = [];
var filteredEmployees = [];
var departments       = [];
var positions         = [];
var currentPage       = 1;
var pageSize          = 5;

document.addEventListener('DOMContentLoaded', function () {
    loadEmployees();
    loadDepartments();
    loadPositions();
});

function loadEmployees() {
    fetch('/EmployeeManagementSystem/api/employees')
        .then(function(r){ return r.json(); })
        .then(function(data){
            if (data.status) {
                allEmployees = filteredEmployees = data.data || [];
                renderTable(filteredEmployees, 1);
            } else { showEmpty(); }
        }).catch(showError);
}

function loadDepartments() {
    fetch('/EmployeeManagementSystem/api/departments')
        .then(function(r){ return r.json(); })
        .then(function(data){ if(data.status){ departments=data.data||[]; populateSelect('editDepartment',departments,'id','departmentName'); } });
}

function loadPositions() {
    fetch('/EmployeeManagementSystem/api/positions')
        .then(function(r){ return r.json(); })
        .then(function(data){ if(data.status){ positions=data.data||[]; populateSelect('editPosition',positions,'id','positionName'); } });
}

function populateSelect(id, items, vk, lk) {
    var sel = document.getElementById(id);
    sel.innerHTML = '';
    items.forEach(function(item){ var o=document.createElement('option'); o.value=item[vk]; o.text=item[lk]; sel.appendChild(o); });
}

function renderTable(employees, page) {
    var tbody     = document.getElementById('employeeTableBody');
    var tableInfo = document.getElementById('tableInfo');
    var total     = employees.length;
    var totalPages = Math.max(1, Math.ceil(total / pageSize));

    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;
    currentPage = page;

    var start = (page - 1) * pageSize;
    var end   = Math.min(start + pageSize, total);

    if (total === 0) {
        tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;opacity:0.6;padding:40px;">No employees found</td></tr>';
        tableInfo.textContent = 'Showing 0 employees';
    } else {
        tbody.innerHTML = '';
        employees.slice(start, end).forEach(function(emp){
            tbody.innerHTML +=
                '<tr>' +
                '<td><span class="id-badge">' + String(emp.id).padStart(3,'0') + '</span></td>' +
                '<td>' + emp.name + '</td>' +
                '<td><span class="dept-badge">' + (emp.departmentName||'—') + '</span></td>' +
                '<td><span class="post-badge">' + (emp.positionName||'—') + '</span></td>' +
                '<td>' + emp.email + '</td>' +
                '<td>' + emp.mobile + '</td>' +
                '<td>' + (emp.hireDate||'—') + '</td>' +
                '<td><span class="salary-text">Rs. ' + Number(emp.salary).toLocaleString() + '</span></td>' +
                '<td><div class="action-btns">' +
                '<button class="act-btn act-view" onclick="openView('   + emp.id + ')"><i class="fa-solid fa-eye"></i></button>' +
                '<button class="act-btn act-edit" onclick="openEdit('   + emp.id + ')"><i class="fa-solid fa-pen"></i></button>' +
                '<button class="act-btn act-del"  onclick="openDelete(' + emp.id + ')"><i class="fa-solid fa-trash"></i></button>' +
                '</div></td>' +
                '</tr>';
        });
        tableInfo.innerHTML = 'Showing <b>' + (start+1) + '</b> – <b>' + end + '</b> of <b>' + total + '</b> employees';
    }

    renderPagination(total, currentPage);
}

function renderPagination(total, page) {
    var pag        = document.getElementById('pagination');
    var totalPages = Math.max(1, Math.ceil(total / pageSize));
    var singlePage = (totalPages === 1);
    var showCount  = Math.max(totalPages, 3);

    var html = '';

    html += btn('← Prev', page <= 1, false, 'changePage(' + (page-1) + ')');

    for (var i = 1; i <= showCount; i++) {
        var isActive   = (i === page);
        var isDisabled = (i > totalPages);
        html += btn(i, isDisabled, isActive, isDisabled ? '' : 'changePage(' + i + ')');
    }

    html += btn('Next →', page >= totalPages || singlePage, false, 'changePage(' + (page+1) + ')');

    pag.innerHTML = html;
}

function btn(label, disabled, active, onclick) {
    var cls = 'page-btn' + (active ? ' active' : '');
    var dis = disabled ? ' disabled' : '';
    var clk = (!disabled && !active && onclick) ? ' onclick="' + onclick + '"' : '';
    return '<button class="' + cls + '"' + dis + clk + '>' + label + '</button>';
}

function changePage(page) {
    var totalPages = Math.max(1, Math.ceil(filteredEmployees.length / pageSize));
    if (page < 1 || page > totalPages) return;
    renderTable(filteredEmployees, page);
}

function searchEmployees() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    filteredEmployees = allEmployees.filter(function(e){
        return e.name.toLowerCase().includes(q) ||
            (e.departmentName && e.departmentName.toLowerCase().includes(q)) ||
            (e.positionName   && e.positionName.toLowerCase().includes(q))   ||
            e.email.toLowerCase().includes(q);
    });
    renderTable(filteredEmployees, 1);
}

function openView(id) {
    var e = allEmployees.find(function(x){ return x.id===id; }); if(!e) return;
    document.getElementById('viewAvatar').textContent   = e.name.charAt(0).toUpperCase();
    document.getElementById('viewName').textContent     = e.name;
    document.getElementById('viewDept').textContent     = e.departmentName||'—';
    document.getElementById('viewPosition').textContent = e.positionName||'—';
    document.getElementById('viewEmail').textContent    = e.email;
    document.getElementById('viewMobile').textContent   = e.mobile;
    document.getElementById('viewHireDate').textContent = e.hireDate||'—';
    document.getElementById('viewSalary').textContent   = 'Rs. ' + Number(e.salary).toLocaleString();
    openModal('viewModal');
}

function openEdit(id) {
    var e = allEmployees.find(function(x){ return x.id===id; }); if(!e) return;
    document.getElementById('editId').value           = e.id;
    document.getElementById('editName').value         = e.name;
    document.getElementById('editEmail').value        = e.email;
    document.getElementById('editMobile').value       = e.mobile;
    document.getElementById('editHireDate').value     = e.hireDate||'';
    document.getElementById('editSalary').value       = e.salary;
    document.getElementById('editDepartment').value   = e.departmentId;
    document.getElementById('editPosition').value     = e.positionId;
    openModal('editModal');
}

function saveEmployee() {
    var data = {
        id: parseInt(document.getElementById('editId').value),
        name: document.getElementById('editName').value,
        email: document.getElementById('editEmail').value,
        mobile: document.getElementById('editMobile').value,
        hireDate: document.getElementById('editHireDate').value,
        salary: parseFloat(document.getElementById('editSalary').value),
        departmentId: parseInt(document.getElementById('editDepartment').value),
        positionId: parseInt(document.getElementById('editPosition').value)
    };
    fetch('/EmployeeManagementSystem/api/employees',{ method:'PUT', headers:{'Content-Type':'application/json'}, body:JSON.stringify(data) })
        .then(function(r){ return r.json(); })
        .then(function(res){
            if(res.status){ closeModal('editModal'); showToast(res.message,'success'); loadEmployees(); }
            else { showToast(res.message,'error'); }
        }).catch(function(){ showToast('Update failed!','error'); });
}

function openDelete(id) { document.getElementById('deleteId').value=id; openModal('deleteModal'); }

function confirmDelete() {
    var id = document.getElementById('deleteId').value;
    fetch('/EmployeeManagementSystem/api/employees/'+id,{method:'DELETE'})
        .then(function(r){ return r.json(); })
        .then(function(res){
            if(res.status){ closeModal('deleteModal'); showToast(res.message,'success'); loadEmployees(); }
            else { showToast(res.message,'error'); }
        }).catch(function(){ showToast('Delete failed!','error'); });
}

function openModal(id)  { document.getElementById(id).classList.add('show'); }
function closeModal(id) { document.getElementById(id).classList.remove('show'); }

document.querySelectorAll('.modal-overlay').forEach(function(o){
    o.addEventListener('click', function(e){ if(e.target===o) o.classList.remove('show'); });
});

function showToast(msg, type) {
    var t = document.getElementById('toast');
    t.textContent = msg; t.className = 'toast '+type+' show';
    setTimeout(function(){ t.classList.remove('show'); }, 3000);
}

function showEmpty() {
    document.getElementById('employeeTableBody').innerHTML =
        '<tr><td colspan="9" style="text-align:center;opacity:0.6;padding:40px;">No employees found</td></tr>';
    document.getElementById('tableInfo').textContent = 'Showing 0 employees';
    renderPagination(0, 1);
}

function showError() {
    document.getElementById('employeeTableBody').innerHTML =
        '<tr><td colspan="9" style="text-align:center;color:red;padding:40px;">Failed to load employees!</td></tr>';
}

function logout() {
    fetch('/EmployeeManagementSystem/api/auth/logout')
        .then(function(){ window.location.href='/EmployeeManagementSystem/sign-in.jsp'; });
}