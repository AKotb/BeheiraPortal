package org.opengeoportal.usermanagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.opengeoportal.DBConPgSQL;

//import org.apache.shiro.SecurityUtils;
//import org.hibernate.Session;

import org.hibernate.Session;

/**
 * @author heba.alaa
 *
 */

public class PortalUserDao {
	
private final Session session;

	public PortalUserDao(Session s) {
		session = s;
	}

   

    
         public Boolean SelectSpecificUser(String name) 
         {
        PortalUser user = new PortalUser();
        Connection c = null;
        Statement stmt = null;
        Boolean exist=false;
        try {
            c = DBConPgSQL.establishDBConn();
            stmt = c.createStatement(); 
            String sql ="SELECT * FROM beheiraschema.beheirauser where name = '"+name+"'";
            
            //PreparedStatement ps = c.prepareStatement(sql);
                 
            //ps.setString(1, name);
          //  ps.setString(2, password);
           
            //ResultSet rs = ps.executeQuery();
            ResultSet rs = stmt.executeQuery(sql);
            
                while (rs.next()) 
            {
                user.setId(rs.getInt("id"));
                user.setRoleid(rs.getInt("roleid"));
                exist=true;
             
            }
             
            
            rs.close();
            stmt.close();
            c.close();
            
        } catch (Exception e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
      }
        return exist;
    }
         
         public  String getPasswordByUsername(String username)
         {
             Connection c = null;
             Statement stmt = null;
             String password=null;
             try {
                 c = DBConPgSQL.establishDBConn();
                 stmt = c.createStatement(); 
                 String sql ="SELECT * FROM beheiraschema.beheirauser where name= ?;";
             PreparedStatement ps = c.prepareStatement(sql);
                 
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
                while (rs.next()) 
            {
               
                password=rs.getString("password");
             
            }
             
            
            rs.close();
            stmt.close();
            c.close();
            
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
      }
        System.out.println("Operation done successfully");
             return password;
         }
         
         public int addUser(PortalUser usr)
         { 
             
             boolean exist=true;
             exist=SelectSpecificUser(usr.getName());
             int numOfRows = 0;
             Connection conn = DBConPgSQL.establishDBConn();
             PreparedStatement ps = null;
             if (conn != null)
             { 
                 try
                 {
                     if (!exist)
                     {
                         String sql = "INSERT INTO beheiraschema.beheirauser (name,password,email,identifynumber,phonenumber)"+"VALUES(?,?,?,?,?)";
                         ps = conn.prepareStatement(sql);
                         ps.setString(1, usr.getName());
                         ps.setString(2,usr.getPassword());
                         ps.setString(3,usr.getEmail());
                         ps.setString(4, usr.getIdentificationID());
                         ps.setString(5,usr.getPhoneNumber());
                       
                       
                         numOfRows=ps.executeUpdate();
                         System.out.println("Inserted records into the table...");
                     }
                     else 
                     { 
                         numOfRows = 0;
                     }
                 }
                 catch (Exception e) {
                     System.err.println(e.getClass().getName() + ": " + e.getMessage());
                     System.exit(0);
                 }
             } 
             return numOfRows;
         }
       public int getUserRole(String username,String pwd)
        {
        PortalUser user = new PortalUser();
        RoleDao roledao=new RoleDao();
         // Set<String> role = new HashSet<>();
        String role = null;
        Connection c = null;
        Statement stmt = null;
        String rolename=null;
        try {
            c = DBConPgSQL.establishDBConn();
            stmt = c.createStatement(); 
           SQLQuery query = session.createSQLQuery("select * from beheiraschema.beheirauser where name= ?");
           query.setParameter(0, username);
           
           // ps.setString(1, pwd);
           List<Object[]> rows = query.list();
               for(Object[] row : rows){
  
	user.setName(row[1].toString());
        user.setPassword(row[2].toString());
        user.setEmail(row[3].toString());
        user.setIdentificationID(row[4].toString());
        user.setPhoneNumber(row[5].toString());
	user.setRoleid(Integer.parseInt(row[6].toString()));
        user.setSalt(row[7].toString());
	}
            
            
            
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
      }
        System.out.println("Operation done successfully");
      // role= user.getRoleid();
        return user.getRoleid();
        }	
	   public PortalUser getUserByName(String name) {
		PortalUser user = new PortalUser();
             // String pwd= password.toString();
               SQLQuery query = session.createSQLQuery("select *from beheiraschema.beheirauser where name= ?");
               query.setParameter(0, name);
               //query.setParameter(1, password);
               List<Object[]> rows = query.list();
               for(Object[] row : rows){
  
	user.setName(row[1].toString());
        user.setPassword(row[2].toString());
        user.setEmail(row[3].toString());
        user.setIdentificationID(row[4].toString());
        user.setPhoneNumber(row[5].toString());
	user.setRoleid(Integer.parseInt(row[6].toString()));
        user.setSalt(row[7].toString());
	}
		return user;
	}
           public List<PortalUser> getAllUsers() {
      
              // PortalUser user = new PortalUser();
               List<PortalUser> usersList = new ArrayList<PortalUser>();
              // SQLQuery sq= session.createSQLQuery("select * FROM beheiraschema.beheirauser where name= ?")
		//.setString(0, name).uniqueResult();
               SQLQuery query = session.createSQLQuery("select *from beheiraschema.beheirauser");
               
               List<Object[]> rows = query.list();
               for(Object[] row : rows){
         PortalUser user = new PortalUser();
	//user.setId(Long.parseLong(row[0].toString()));
	try {
           
        user.setName(row[1].toString());
        user.setPassword(row[2].toString());
        user.setEmail(row[3].toString());
        user.setIdentificationID(row[4].toString());
        user.setPhoneNumber(row[5].toString());
	user.setRoleid(Integer.parseInt(row[6].toString()));
        }
        catch(Exception ex) 
        {
         user.setRoleid(1);
        }
        
        usersList.add(user);
	}
		return usersList;
    }
           public boolean editUserRole(int roleid,String name)
           {
               boolean updateResult=false;
             
             int numOfRows = 0;
             Connection conn = DBConPgSQL.establishDBConn();
             PreparedStatement ps = null;
             if (conn != null)
             { 
                 try
                 {
                    
                         String sql = "UPDATE beheiraschema.beheirauser SET roleid=? WHERE name=?;";
                         ps = conn.prepareStatement(sql);
                         ps.setInt(1, roleid);
                         ps.setString(2,name);
                         numOfRows=ps.executeUpdate();
                         System.out.println("Inserted records into the table...");
                    if (numOfRows == 1) {
				updateResult = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
             } 
             return updateResult; 
           }
}
