$(document).ready(function() {
    $('#loginForm').submit(function(e) {
        e.preventDefault();
        
        let email = $('#email').val();
        let password = $('#password').val();
        
        if(email === '' || password === '') {
            $('#loginMessage').html('<div class="alert alert-danger">Please fill all fields</div>');
            return;
        }
        
        $.ajax({
            url: 'http://localhost:8082/api/auth/login',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({email: email, password: password}),
            success: function(response) {
                if(response.success) {
                    $('#loginMessage').html('<div class="alert alert-success">' + response.message + '</div>');
                    setTimeout(function() {
                        window.location.href = 'product.html';
                    }, 1500);
                } else {
                    $('#loginMessage').html('<div class="alert alert-danger">' + response.message + '</div>');
                }
            },
            error: function() {
                $('#loginMessage').html('<div class="alert alert-danger">Connection error</div>');
            }
        });
    });
});
