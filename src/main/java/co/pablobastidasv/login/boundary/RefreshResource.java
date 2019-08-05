package co.pablobastidasv.login.boundary;

import co.pablobastidasv.login.control.JwtUtils;
import co.pablobastidasv.login.entity.LoginContent;
import com.nimbusds.jwt.SignedJWT;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.jwt.JsonWebToken;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.util.Map;
import java.util.Objects;

import static co.pablobastidasv.ConfigurationConstants.JWT_EXPIRES_IN;
import static co.pablobastidasv.ConfigurationConstants.JWT_EXPIRES_IN_DEFAULT;

@Path("/refresh")
@RequestScoped
@Produces(MediaType.APPLICATION_JSON)
public class RefreshResource {

    @Inject
    JwtUtils jwtUtils;

    @Inject
    JsonWebToken jsonWebToken;

    @Inject
    TokenGenerator tokenGenerator;

    @Inject
    @ConfigProperty(name = JWT_EXPIRES_IN, defaultValue = JWT_EXPIRES_IN_DEFAULT)
    Integer expiresIn;

    @GET
    @Consumes(MediaType.MEDIA_TYPE_WILDCARD)
    public Response refresh(@Context SecurityContext ctx) {
        if(Objects.isNull(ctx.getUserPrincipal())) return Response.status(401).build();

        Map<String, Object> claims = jwtUtils.mapFromClaims(jsonWebToken);

        SignedJWT jwt = tokenGenerator.generateSignedToken(claims);
        LoginContent content = new LoginContent(jwt, expiresIn);

        return Response.ok(content).build();
    }
}
