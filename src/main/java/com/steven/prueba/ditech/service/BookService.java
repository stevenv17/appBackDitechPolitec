package com.steven.prueba.ditech.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {

	@Autowired
	private OracleService oracleService;
	
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String getBooks(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_BOOKS", "SP_GET_BOOKS", parameter1);
	}
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String saveBook(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_BOOKS", "SP_SAVE_BOOK", parameter1);
	}
	
	/**
	 * 
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String deleteBook(String parameter1) throws SQLException {
		return oracleService.execProcedure("PKG_BOOKS", "SP_DELETE_BOOK", parameter1);
	}

}
