using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims;
using System.IdentityModel.Tokens.Jwt;

namespace WebApplication1
{
    class ThisTokenValidator : JwtSecurityTokenHandler
    {
        public new ClaimsPrincipal ValidateTokenPayload(JwtSecurityToken jwt, TokenValidationParameters validationParameters)
        {
           return base.ValidateTokenPayload(jwt, validationParameters);
        }
    }

    public class JwtSecurityValidator : ISecurityTokenValidator
    {
        public bool CanValidateToken => true;

        public int MaximumTokenSizeInBytes { get; set; }

        public bool CanReadToken(string securityToken)
        {
            return true;
        }

        public ClaimsPrincipal ValidateToken(string securityToken, TokenValidationParameters validationParameters, out SecurityToken validatedToken)
        {

            var jwt = new JwtSecurityToken(securityToken);
            validatedToken = jwt;
            return new ThisTokenValidator().ValidateTokenPayload(jwt, validationParameters);
        }
    }
}
