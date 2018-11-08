package org.opengeoportal.usermanagement;
/**
 * @author heba.alaa
 *
 */
import javax.servlet.http.HttpSession;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.hibernate.Session;
import org.opengeoportal.utilities.HibernateUtil;



public class CustomRealm extends JdbcRealm {
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		// identify account to log to
		UsernamePasswordToken userPassToken = (UsernamePasswordToken) token;
		final String username = userPassToken.getUsername();
               Object pwd=userPassToken.getCredentials();
               
                       

		if (username == null) {
			System.out.println("Username is null.");
			return null;
		}

		// read password hash and salt from db
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		try {
			PortalUserDao userDAO = new PortalUserDao(session);
                        
			final PortalUser user = userDAO.getUserByName(username);
                        

			if (user == null) {
				System.out.println("No account found for user [" + username + "]");
				return null;
			}

			// return salted credentials
			SaltedAuthenticationInfo info = new SaltedAuthentificationInfo(
					username, user.getPassword(), user.getSalt());
                       
			return info;
		} finally {
			session.getTransaction().commit();
			if (session.isOpen()) session.close();
		}

	}
       

   // @Override
   // protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {
       /* if (pc == null)
            throw new AuthorizationException("PrincipalCollection was null, which should not happen");
        if (pc.isEmpty())
        {
            System.out.println("principals collection is empty");
            return null;
        }
        if (pc.fromRealm(getName()).size() <= 0)
        {
            System.out.println("principals from realm collection is empty");
            return null;
        }
        Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
        UserDao userDAO = new UserDao(session);
        PortalUser user = userDAO.getUserRole(session.);
        Set<String> rroles = new HashSet<String>(user.getRoles().size());
        Set<Role> roles = user.getRoles();
        for (Role role : roles)
            rroles.add(role.name());  
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(rroles);
       
        Set<Permission> permissions = user.getPermissions();
        for (Permission permission : permissions) {
            String permString = permission.name();
            if (!pc.fromRealm(getName()).isEmpty()) info.addStringPermission(permString);
        }
        return info;*/
    //   SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
     //  return info;
  //  }

}
