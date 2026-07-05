$(document).ready(function() {
    loadProducts();
});

function loadProducts() {
    $.ajax({
        url: 'http://localhost:8082/api/products',
        method: 'GET',
        success: function(products) {
            displayProducts(products);
        },
        error: function() {
            showError();
        }
    });
}

function displayProducts(products) {
    let html = '';
    products.forEach(function(product) {
        html += `
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${product.productName}</h5>
                        <p class="card-text">${product.description}</p>
                        <p class="text-danger fw-bold">Rs ${product.price}</p>
                        <span class="badge bg-success">Stock: ${product.stockQuantity}</span>
                    </div>
                </div>
            </div>
        `;
    });
    $('#productList').html(html);
}

function showError() {
    $('#productList').html('<p class="text-danger">Error loading products from API</p>');
}
