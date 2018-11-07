/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.opengeoportal.usermanagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Set;
import org.opengeoportal.DBConPgSQL;

/**
 *
 * @author heba
 */
public class RoleDao {
    
    public Set<String> getRole(int id)
        {
        Role role = new Role();
        Set<String> roles = new HashSet<>();
        Connection c = null;
        Statement stmt = null;
        
        try {
            c = DBConPgSQL.establishDBConn();
            stmt = c.createStatement(); 
            String sql ="SELECT role FROM beheiraschema.userrole where id= ?;";
             PreparedStatement ps = c.prepareStatement(sql);
           ps.setInt(1, id);
           ResultSet rs = ps.executeQuery();
            
                while (rs.next()) 
            {
                role.setId(rs.getInt("id"));
                role.setRole(rs.getString("role"));
                roles.add(rs.getString("role"));
            }
               
            
            rs.close();
            stmt.close();
            c.close();
            
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
      }
        System.out.println("Operation done successfully");
       
        return roles;
        }
     public int getRoleid (String name)
        {
        Role role = new Role();
        int roleid = 0 ;
        Connection c = null;
        Statement stmt = null;
        
        try {
            c = DBConPgSQL.establishDBConn();
            stmt = c.createStatement(); 
            String sql ="SELECT * FROM beheiraschema.userrole where role= ?;";
             PreparedStatement ps = c.prepareStatement(sql);
           ps.setString(1, name);
           ResultSet rs = ps.executeQuery();
            
                while (rs.next()) 
            {
                role.setId(rs.getInt("id"));
                role.setRole(rs.getString("role"));
                roleid=rs.getInt("id");
                
            }
               
            
            rs.close();
            stmt.close();
            c.close();
            
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
      }
        System.out.println("Operation done successfully");
       
        return roleid;
        }
    
}
