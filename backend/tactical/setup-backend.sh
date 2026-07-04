#!/bin/bash

# Create folder structure
mkdir -p src/main/java/com/tacticaldepot/controllers
mkdir -p src/main/java/com/tacticaldepot/domains
mkdir -p src/main/java/com/tacticaldepot/repositories
mkdir -p src/main/java/com/tacticaldepot/services

# Configure application.yml
cat > src/main/resources/application.yml << 'EOF'
micronaut:
  application:
    name: tacticalDepot
  server:
    port: 8080
    cors:
      enabled: true

datasources:
  default:
    url: jdbc:mysql://${MYSQL_HOST:localhost}:3306/${MYSQL_DB:tactical_depot}
    driverClassName: com.mysql.cj.jdbc.Driver
    username: ${MYSQL_USER:root}
    password: ${MYSQL_PASSWORD:}
    dialect: MYSQL

jpa:
  default:
    properties:
      hibernate:
        hbm2ddl:
          auto: update
        show_sql: true

logger:
  levels:
    com.tacticaldepot: INFO
    org.hibernate.SQL: DEBUG
EOF

# Add snakeyaml dependency
sed -i '/dependencies {/a \    runtimeOnly("org.yaml:snakeyaml:2.0")' build.gradle

# Product Domain
cat > src/main/java/com/tacticaldepot/domains/Product.java << 'EOF'
package com.tacticaldepot.domains;
import jakarta.persistence.*;

@Entity
@Table(name = "Products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productID;
    private String productName;
    private String category;
    private Double price;
    private Integer stockQuantity;
    private String description;
    private String productImage;
    
    public Product() {}
    
    public Integer getProductID() { return productID; }
    public void setProductID(Integer productID) { this.productID = productID; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
}
EOF

# Customer Domain
cat > src/main/java/com/tacticaldepot/domains/Customer.java << 'EOF'
package com.tacticaldepot.domains;
import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Customers")
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer customerID;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    private Date dateRegistered;
    
    public Customer() {}
    
    public Integer getCustomerID() { return customerID; }
    public void setCustomerID(Integer customerID) { this.customerID = customerID; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public Date getDateRegistered() { return dateRegistered; }
    public void setDateRegistered(Date dateRegistered) { this.dateRegistered = dateRegistered; }
}
EOF

# Employee Domain
cat > src/main/java/com/tacticaldepot/domains/Employee.java << 'EOF'
package com.tacticaldepot.domains;
import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Employees")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer employeeID;
    private String fullName;
    private String position;
    private String email;
    private String password;
    private Date hireDate;
    
    public Employee() {}
    
    public Integer getEmployeeID() { return employeeID; }
    public void setEmployeeID(Integer employeeID) { this.employeeID = employeeID; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Date getHireDate() { return hireDate; }
    public void setHireDate(Date hireDate) { this.hireDate = hireDate; }
}
EOF

# Product Repository
cat > src/main/java/com/tacticaldepot/repositories/ProductRepository.java << 'EOF'
package com.tacticaldepot.repositories;
import com.tacticaldepot.domains.Product;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
}
EOF

# Customer Repository
cat > src/main/java/com/tacticaldepot/repositories/CustomerRepository.java << 'EOF'
package com.tacticaldepot.repositories;
import com.tacticaldepot.domains.Customer;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
}
EOF

# Employee Repository
cat > src/main/java/com/tacticaldepot/repositories/EmployeeRepository.java << 'EOF'
package com.tacticaldepot.repositories;
import com.tacticaldepot.domains.Employee;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;
import java.util.Optional;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    Optional<Employee> findByEmailAndPassword(String email, String password);
}
EOF

# Product Controller
cat > src/main/java/com/tacticaldepot/controllers/ProductController.java << 'EOF'
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
EOF

# Employee Controller (Login)
cat > src/main/java/com/tacticaldepot/controllers/AuthController.java << 'EOF'
package com.tacticaldepot.controllers;
import com.tacticaldepot.repositories.EmployeeRepository;
import io.micronaut.http.annotation.*;
import jakarta.inject.Inject;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller("/api/auth")
public class AuthController {
    
    private static final Logger LOG = LoggerFactory.getLogger(AuthController.class);
    
    @Inject
    private EmployeeRepository employeeRepository;
    
    @Post("/login")
    public Map<String, Object> login(@Body Map<String, String> creds) {
        String email = creds.get("email");
        String password = creds.get("password");
        LOG.info("Login attempt for: {}", email);
        
        Map<String, Object> response = new HashMap<>();
        var employee = employeeRepository.findByEmailAndPassword(email, password);
        
        if(employee.isPresent()) {
            response.put("success", true);
            response.put("message", "Login successful");
            response.put("user", employee.get().getFullName());
            LOG.info("Login successful for: {}", email);
        } else {
            response.put("success", false);
            response.put("message", "Invalid credentials");
            LOG.warn("Login failed for: {}", email);
        }
        return response;
    }
}
EOF

echo "Backend setup complete!"
