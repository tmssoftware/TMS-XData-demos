program JwtAuthDemo;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Server in 'Server.pas',
  Services in 'Services.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
