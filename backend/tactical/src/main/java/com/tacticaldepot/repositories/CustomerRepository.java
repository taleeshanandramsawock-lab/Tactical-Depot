package com.tacticaldepot.repositories;
import com.tacticaldepot.domains.Customer;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
}
