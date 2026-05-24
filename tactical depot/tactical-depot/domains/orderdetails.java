package com.tacticaldepot.domains;

import jakarta.persistence.*;

@Entity
@Table(name = "OrderDetails")
public class OrderDetail {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderDetailID;
    
    private int orderID;
    private int productID;
    private int quantity;
    private double unitPrice;
    
    // constructor
    public OrderDetail() {
    }
    
    // getters and setters
    public int getOrderDetailID() {
        return orderDetailID;
    }
    
    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }
    
    public int getOrderID() {
        return orderID;
    }
    
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
    public int getProductID() {
        return productID;
    }
    
    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getUnitPrice() {
        return unitPrice;
    }
    
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
}