// Admin JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Delete confirmation
    function confirmDelete(message = 'Are you sure?') {
        return confirm(message);
    }

    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.classList.remove('show');
            alert.classList.add('hide');
        }, 5000);
    });

    // Form validation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function() {
            // Add any validation here
        });
    });

    // Status update via AJAX
    const statusSelects = document.querySelectorAll('select[name="status"]');
    statusSelects.forEach(select => {
        select.addEventListener('change', function() {
            // AJAX update if needed
            console.log('Status changed to:', this.value);
        });
    });
});
