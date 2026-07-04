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
