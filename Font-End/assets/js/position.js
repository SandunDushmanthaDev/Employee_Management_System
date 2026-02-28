document.addEventListener('DOMContentLoaded', function () {
    loadPositions();
});

function loadPositions() {
    const tbody = document.getElementById('positionTableBody');

    fetch('/EmployeeManagementSystem/api/positions')
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.status && data.data.length > 0) {
                tbody.innerHTML = '';
                data.data.forEach(function(pos) {
                    const idFormatted = 'POS-' + String(pos.id).padStart(3, '0');
                    tbody.innerHTML += '<tr>' +
                        '<td><span class="id-badge" style="padding: 6px 12px; font-size: 12px;">' + idFormatted + '</span></td>' +
                        '<td><div class="name-cell"><div class="emp-name" style="font-size: 15px;">' + pos.positionName + '</div></div></td>' +
                        '</tr>';
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="2" style="text-align:center; opacity:0.6;">No positions found</td></tr>';
            }
        })
        .catch(function(error) {
            console.log('Error: ' + error);
            tbody.innerHTML = '<tr><td colspan="2" style="text-align:center; color:red;">Failed to load positions!</td></tr>';
        });
}