https://github.com/eligrey/FileSaver.js/
http://notjoshmiller.com/server-side-pdf-generation-and-angular-resource/

https://stackoverflow.com/questions/57109641/linking-multiple-social-accounts-to-azur-b2c-local-account-through-custom-polici

https://docs.microsoft.com/en-us/aspnet/core/security/blazor/?view=aspnetcore-3.1&tabs=visual-studio
https://codemilltech.com/adding-azure-ad-b2c-authentication-to-azure-functions/ (2018)
https://blog.simontimms.com/2019/01/30/2019-01-30-Functions-aad-authentication/

https://demos.devexpress.com/blazor/
https://carmaintenancelogfunctions.azurewebsites.net 

https://www.ben-morris.com/custom-token-authentication-in-azure-functions-using-bindings/

## Stuff to do...

 * Get azure functions authenticated with Azure B2C
https://codemilltech.com/adding-azure-ad-b2c-authentication-to-azure-functions/

 * Get azure signalr 
 * Setup some sort of queue

## Notes if stuff is broken

 Install-Package Microsoft.EntityFrameworkCore.Tools 


## Import Database

Scaffold-DbContext "Data Source=(localdb)\ProjectsV13;Initial Catalog=CarMaintenanceLog.Db;Integrated Security=True;Pooling=False;Connect Timeout=30" -Provider Microsoft.EntityFrameworkCore.SqlServer -Project CarMaintenanceLog.Data.Core





https://demos.devexpress.com/blazor/

https://carmaintenancelogfunctions.azurewebsites.net/.auth/login/aad/callback 
http://localhost:7071/.auth/login/aad/callback

/.auth/login/aad/callback

c35db683-d375-4877-a32d-b721e647ba74

https://whitedus.b2clogin.com/tfp/

https://login.microsoftonline.com/

https://whitedus.b2clogin.com/whitedus.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_SignupSignIn

https://whitedus.b2clogin.com/whitedus.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_SignupSignIn&client_id=4a12c32e-327d-448f-8762-228bf2f05b0e&nonce=defaultNonce&redirect_uri=https%3A%2F%2Flocalhost%3A5001%2Fsignin-oidc&scope=openid&response_type=id_token&prompt=login


https://carmaintenancelogfunctions.azurewebsites.net/.auth/logout
https://carmaintenancelogfunctions.azurewebsites.net/api/TestFunction?code=ZS9RRBYyZF8kBzAu50wUosf5AM8oiYQIMcMZpWxLfQE0gGZwUZmVug==
https://carmaintenancelogfunctions.azurewebsites.net/api/TestFunction?code=x8NwJ53Gfsp/Ps0LLYm6gHj0US9xJwwL3zQhqZgfabXIFvGqT5CUPw==

https://daniel-krzyczkowski.github.io/Azure-AD-B2C-Series-External-Service-Call/
https://blogs.msdn.microsoft.com/benjaminperkins/2018/06/13/azure-function-400-bad-request/
https://mcguirev10.com/2019/12/17/blazor-openid-connect-api-token-refresh.html



https://carmaintenancelogfunctions.scm.azurewebsites.net/

https://blogs.msdn.microsoft.com/uk_faculty_connection/2017/05/15/using-kudu-and-deploying-apps-into-azure/


https://stackoverflow.com/questions/24709944/sending-jwt-token-in-the-headers-with-postman





   Request URL: https://carmaintenancelogfunctions.azurewebsites.net/.auth/login/aad/callback
   Request Method: GET
   Status Code: 302 / Redirect
   Request Headers
 - Response Headers
   Content-Length: 254
   Content-Type: text/html; charset=UTF-8
   Date: Tue, 28 Jan 2020 06:25:49 GMT
   Location: https://carmaintenancelogfunctions.azurewebsites.net/api/TestFunction?code=ZS9RRBYyZF8kBzAu50wUosf5AM8oiYQIMcMZpWxLfQE0gGZwUZmVug==
   Set-Cookie: AppServiceAuthSession=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; path=/; secure; HttpOnly; SameSite=None
   Set-Cookie: AppServiceAuthSession1=FjdTzRI0418B8QKJWj5ztHRROQFK7pYeX+4Eh9oG77CXA3zTcw0aGgPxYLvIDR6YGwJlS9R2Y20n3YLW2XlbM1cS3JzELO0E96q3+g8ZueFdw0/+u/oEoXV8VxSVBsQwOk7KAUEYuZiBiOK6Si/K2X2wQeLDa+ROHSC84H14Sk56mpSP64R+h+7wIjBmb7L+YXsEwJw0NvXO1n5jzJdZy9aZLjsJ4VodOyotpbsgG325NF4n; path=/; secure; HttpOnly; SameSite=None
   Set-Cookie: Nonce=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT
   Set-Cookie: RedirectCount=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT
