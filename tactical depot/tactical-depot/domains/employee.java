package com.tacticaldepot.domains;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Employees")
public class Employee {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int employeeID;
    
    private String fullName;
    private String position;
    private String email;
    private String password;
    private Date hireDate;
    
    // constructor
    public Employee() {
    }
    
    // getters and setters
    public int getEmployeeID() {
        return employeeID;
    }
    
    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getPosition() {
        return position;
    }
    
    public void setPosition(String position) {
        this.position = position;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Date getHireDate() {
        return hireDate;
    }
    
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
}