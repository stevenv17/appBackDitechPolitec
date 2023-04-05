package com.steven.prueba.ditech.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.steven.prueba.ditech.model.Author;

@Repository
@Transactional
@EnableTransactionManagement
public interface AuthorRepository extends CrudRepository<Author,Integer> {

}
