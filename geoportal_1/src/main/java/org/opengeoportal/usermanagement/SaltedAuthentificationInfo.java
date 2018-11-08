package org.opengeoportal.usermanagement;
/**
 * @author heba.alaa
 *
 */
import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.SimpleByteSource;

public class SaltedAuthentificationInfo implements SaltedAuthenticationInfo {
	private static final long serialVersionUID = -5467967895187234984L;

	private final String username;
	private final String password;
       // private int roleid;
	private final String salt;

	public SaltedAuthentificationInfo(String username, String password,
			String salt) {
		this.username = username;
		this.password = password;
		this.salt = salt;
              //  this.roleid = roleid;
	}

	@Override
	public Object getCredentials() {
		return password;
	}

	@Override
	public org.apache.shiro.util.ByteSource getCredentialsSalt() {
		return new SimpleByteSource(Base64.decode(salt));
	}

	@Override
	public PrincipalCollection getPrincipals() {
		PrincipalCollection coll = new SimplePrincipalCollection(username,
				username);
		return coll;
	}

    /**
     * @return the roleid
     */
  

   

}

