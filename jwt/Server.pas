unit Server;

interface

uses
  XData.Server.Module, XData.Service.Common, System.SysUtils, Sparkle.HttpSys.Server,
  Services;

type
  [ServiceImplementation]
  THelloService = class(TInterfacedObject, IHelloService)
    function Hello: string;
    function Login(const UserName, Password: string): string;
  end;

procedure StartServer;
procedure StopServer;

implementation

uses
  Aurelius.Drivers.Interfaces, System.IOUtils, XData.Sys.Exceptions,
  Bcl.Jose.Core.JWT, Bcl.Jose.Core.Builder, Sparkle.Middleware.Jwt;

const
  JWT_SECRET = 'mysecret';

var
  SparkleServer: THttpSysServer;

procedure StartServer;
var
  Module : TXDataServerModule;
begin
  if Assigned(SparkleServer) then Exit;
  SparkleServer := THttpSysServer.Create;
  Module := TXDataServerModule.Create('http://+:2001/tms/jwt', IDBConnectionPool(nil));
  // Add JWT Middleware to process the token and transform it to IUserIdentity if valid
  Module.AddMiddleware(TJwtMiddleware.Create(JWT_SECRET));
  SparkleServer.AddModule(Module);
  SparkleServer.Start;
end;

procedure StopServer;
begin
  FreeAndNil(SparkleServer);
end;

{ THelloService }

function THelloService.Hello: string;
var
  User: IUserIdentity;
begin
  User := TXDataOperationContext.Current.Request.User;
  if User = nil then
    raise EXDataHttpUnauthorized.Create('User not authenticated');
  if not User.Claims.Exists('username') then
    raise EXDataHttpForbidden.Create('Not enough privileges. Cannot greet without a name.');
  if User.Claims['username'].AsString = '' then
    raise EXDataHttpForbidden.Create('Not enough privileges. Cannot greet without a name.');

  Result := 'Hello, ' + User.Claims['username'].AsString;
end;

function THelloService.Login(const UserName, Password: string): string;
var
  JWT: TJWT;
begin
  { check if UserName and Password are valid, retrieve User data from database,
   add relevant claims to JWT and return it. In this example, we will accept any
   user as long the password is the same }
  if UserName <> Password then
    raise EXDataHttpUnauthorized.Create('Invalid password');

  // Generate the token
  JWT := TJWT.Create(TJWTClaims);
  try
    JWT.Claims.SetClaimOfType<string>('username', UserName);
    JWT.Claims.Issuer := 'XData Server';
    Result := TJOSE.SHA256CompactToken(JWT_SECRET, JWT);
  finally
    JWT.Free;
  end;
end;

initialization
  RegisterServiceType(THelloService);
  SparkleServer := nil;
finalization
  StopServer;
end.

