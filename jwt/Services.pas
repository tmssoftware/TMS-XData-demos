unit Services;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  IHelloService = interface(IInvokable)
  ['{7283A32C-5920-412C-8BA0-236EF9BF5CF1}']
    [HttpGet] function Hello: string;
    function Login(const UserName, Password: string): string;
  end;

implementation

end.
