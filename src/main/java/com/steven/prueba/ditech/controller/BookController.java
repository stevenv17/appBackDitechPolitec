package com.steven.prueba.ditech.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.steven.prueba.ditech.service.BookService;


@RestController
@Controller
@CrossOrigin(origins="*", methods = {RequestMethod.GET, RequestMethod.POST})
public class BookController {

	@Autowired
	private BookService bookService;
	
	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	@GetMapping("/getBooks") // stereotype rest controller
    public String getBooks(@RequestParam("value") String jsonString) throws SQLException {
        return bookService.getBooks(jsonString);
    }
	
	@PostMapping("/saveBook")
	public String saveBook(@RequestBody String jsonInput) throws SQLException {
		return bookService.saveBook(jsonInput);
	}
	
	@PostMapping("/deleteBook")
	public String deleteBook(@RequestBody String jsonInput) throws SQLException {
		return bookService.deleteBook(jsonInput);
	}
}
