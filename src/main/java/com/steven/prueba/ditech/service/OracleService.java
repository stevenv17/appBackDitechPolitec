package com.steven.prueba.ditech.service;

import java.sql.Clob;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

@Service
public class OracleService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 
	 * @param packageName
	 * @param procedureName
	 * @param parameter1
	 * @return
	 * @throws SQLException
	 */
	public String execProcedure(String packageName, String procedureName, String parameter1) throws SQLException {
		
		String result;
 
		SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
									.withCatalogName(packageName)
									.withProcedureName(procedureName)
									.declareParameters(
										new SqlParameter("cjsoninput", Types.CLOB),
										new SqlOutParameter("cjsonoutput", Types.CLOB)
									);
 
		SqlParameterSource in = new MapSqlParameterSource()
								.addValue("cjsoninput", parameter1);
 
		Map<String, Object> out = jdbcCall.execute(in);
		//result = (String) out.get("cjsonoutput");
	    result = ((Clob) out.get("cjsonoutput")).getSubString(1, (int) ((Clob) out.get("cjsonoutput")).length());
		
		return result;
	 }
}
