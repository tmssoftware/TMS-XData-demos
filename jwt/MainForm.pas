unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  XData.Client, Services, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    edUserName: TEdit;
    Label2: TLabel;
    edPassword: TEdit;
    btLogin: TButton;
    TabSheet2: TTabSheet;
    btHello: TButton;
    btLogout: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btHelloClick(Sender: TObject);
    procedure btLogoutClick(Sender: TObject);
    procedure btLoginClick(Sender: TObject);
  private
    Client: TXDataClient;
    AuthToken: string;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Sparkle.Http.Client,
  Server;

{$R *.dfm}

procedure TForm1.btHelloClick(Sender: TObject);
begin
  ShowMessage(Client.Service<IHelloService>.Hello);
end;

procedure TForm1.btLoginClick(Sender: TObject);
begin
  AuthToken := Client.Service<IHelloService>.Login(edUserName.Text, edPassword.Text);
  ShowMessage('Login succesful. Now you can receive a hello greeting.');
  PageControl1.ActivePageIndex := 1;
end;

procedure TForm1.btLogoutClick(Sender: TObject);
begin
  AuthToken := '';
  PageControl1.ActivePageIndex := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StartServer;
  Client := TXDataClient.Create;
  Client.Uri := 'http://localhost:2001/tms/jwt/';
  Client.HttpClient.OnSendingRequest :=
    procedure(Req: THttpRequest)
    begin
      Req.Headers.SetValue('authorization', 'Bearer ' + AuthToken);
    end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;

end.
