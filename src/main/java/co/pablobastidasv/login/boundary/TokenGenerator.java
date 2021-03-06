package co.pablobastidasv.login.boundary;

import co.pablobastidasv.login.control.JwtException;
import co.pablobastidasv.login.control.JwtUtils;
import co.pablobastidasv.login.control.KeysUtils;
import co.pablobastidasv.user.entity.SystemUser;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.Map;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

/** Utilities for generating a JWT for testing. */
@ApplicationScoped
public class TokenGenerator {

  @Inject KeysUtils keysUtils;

  @Inject JwtUtils jwtUtils;

  /**
   * Utility method to generate a SignedJWT from a Map of claims.
   *
   * @param claims - Claims information.
   * @return the JWT Signed.
   */
  public SignedJWT generateSignedToken(Map<String, Object> claims) {
    var claimsBuilder = jwtUtils.generateClaims(claims);
    jwtUtils.mandatoryClaims(claimsBuilder);

    return generateSignedToken(claimsBuilder.build());
  }

  /**
   * Utility method to generate a SignedJWT from a User and tenant.
   *
   * @param systemUser - JWT claims will be based on the information from the user.
   * @param tenant - Tenant ID where the user belongs.
   * @return the JWT Signed.
   */
  public SignedJWT generateSignedToken(SystemUser systemUser, String tenant) {
    var claimsBuilder = jwtUtils.generateClaims(systemUser);
    jwtUtils.mandatoryClaims(claimsBuilder);
    claimsBuilder.claim("tenant", tenant);

    return generateSignedToken(claimsBuilder.build());
  }

  private SignedJWT generateSignedToken(JWTClaimsSet claimsSet) {
    try {
      var pk = keysUtils.readPrivateKey();
      var signer = new RSASSASigner(pk);
      var jwsHeader = jwtUtils.fillJwsHeader();

      var signedJwt = new SignedJWT(jwsHeader, claimsSet);
      signedJwt.sign(signer);

      return signedJwt;
    } catch (NoSuchAlgorithmException | InvalidKeySpecException | JOSEException e) {
      throw new JwtException();
    }
  }
}
