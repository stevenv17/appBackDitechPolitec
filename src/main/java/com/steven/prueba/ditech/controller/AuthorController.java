package com.steven.prueba.ditech.controller;

import java.sql.SQLException;
//import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


//import com.steven.prueba.ditech.model.Author;
import com.steven.prueba.ditech.service.AuthorService;

@RestController
@Controller
@CrossOrigin(origins="*", methods = {RequestMethod.GET, RequestMethod.POST})
public class AuthorController {

	@Autowired
	private AuthorService authorService;
	
	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	@GetMapping("/getAuthors") // stereotype rest controller
    public String getAuhtors(@RequestParam("value") String jsonString) throws SQLException {
		// return authorService.getAllAuthors();
        return authorService.getAuthors(jsonString);
    }
	
	@PostMapping("/saveAuthor")
	public String saveAuthor(@RequestBody String jsonInput) throws SQLException {
		return authorService.saveAuthor(jsonInput);
	}
	
	@PostMapping("/deleteAuthor")
	public String deleteAuthor(@RequestBody String jsonInput) throws SQLException {
		return authorService.deleteAuthor(jsonInput);
	}
	
	
	
}
