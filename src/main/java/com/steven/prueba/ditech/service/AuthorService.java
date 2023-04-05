package com.steven.prueba.ditech.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.steven.prueba.ditech.model.Author;
import com.steven.prueba.ditech.repository.AuthorRepository;

@Service
public class AuthorService {
	
	@Autowired
	private AuthorRepository authorRepository;
	
	@Autowired
	private OracleService oracleService;
	
	/**
	 * 
	 * @return
	 */
	public List<Author> getAllAuthors () {
		List<Author> authors = (List<Author>) authorRepository.findAll();
		return authors;
	}
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String getAuthors(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_AUTHORS", "SP_GET_AUTHORS", parameter1);
	}
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String saveAuthor(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_AUTHORS", "SP_SAVE_AUTHOR", parameter1);
	}
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String deleteAuthor(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_AUTHORS", "SP_DELETE_AUTHOR", parameter1);
	}

}
