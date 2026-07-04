package com.tacticaldepot.controllers;
import com.tacticaldepot.domains.Product;
import com.tacticaldepot.repositories.ProductRepository;
import io.micronaut.http.annotation.*;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller("/api/products")
public class ProductController {
    
    private static final Logger LOG = LoggerFactory.getLogger(ProductController.class);
    
    @Inject
    private ProductRepository productRepository;
    
    @Get
    public List<Product> getAll() {
        LOG.info("Getting all products");
        return productRepository.findAll();
    }
    
    @Get("/{id}")
    public Optional<Product> getById(Integer id) {
        LOG.info("Getting product with id: {}", id);
        return productRepository.findById(id);
    }
    
    @Post
    public Product create(@Body Product product) {
        LOG.info("Creating new product: {}", product.getProductName());
        return productRepository.save(product);
    }
    
    @Put("/{id}")
    public Product update(Integer id, @Body Product product) {
        LOG.info("Updating product id: {}", id);
        product.setProductID(id);
        return productRepository.update(product);
    }
    
    @Delete("/{id}")
    public void delete(Integer id) {
        LOG.info("Deleting product id: {}", id);
        productRepository.deleteById(id);
    }
}
