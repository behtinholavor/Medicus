program Medicus;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  SysUtils,
  ufrmMenu in 'ufrmMenu.pas' {frmMenu},
  ufrmForm in 'ufrmForm.pas' {frmForm},
  udmDados in 'udmDados.pas' {dmDados: TDataModule},
  ufrmSplash in 'ufrmSplash.pas' {frmSplash},
  uFuncoes in 'uFuncoes.pas',
  uGuidEx in 'uGuidEx.pas',
  ufrmLogin in 'ufrmLogin.pas' {frmLogin},
  ufrmBloquear in 'ufrmBloquear.pas' {frmBloquear},
  ufrmConexao in 'ufrmConexao.pas' {frmConexao},
  ufrmCadastro in 'ufrmCadastro.pas' {frmCadastro},
  ufrmUsuarios in 'ufrmUsuarios.pas' {frmUsuarios};

{$R *.res}

begin
//  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TfrmMenu, frmMenu);
//  Application.Run;

//  Application.Initialize;
//  frmSplash := TfrmSplash.Create(Application);
//  frmSplash.Show;
//  frmSplash.Update;
//  Application.MainFormOnTaskbar := True;
//  Application.Title := 'Gestorant';
//  Application.CreateForm(TfrmPrincipal, frmPrincipal);
//  Sleep(1000);
//  frmSplash.Hide;
//  FreeAndNil(frmSplash);
//  frmConexao := TfrmConexao.Create(Application, '', frmPrincipal);
//  frmLogin := TfrmLogin.Create(Application, '', frmPrincipal);
//  frmPrimeiroAcesso := TfrmPrimeiroAcesso.Create(Application, '', frmPrincipal);
//  frmAtualizaVersao := TfrmAtualizaVersao.Create(Application, '', frmPrincipal);
//  dtmDados := TdtmDados.Create(Application, 'gestorant.ini', frmPrincipal, frmLogin, frmPrimeiroAcesso, frmAtualizaVersao, frmConexao);
//  dtmFast := TdtmFast.Create(Application, frmPrincipal);
//  clsEsmaecer := TclsEsmaecer.Create(Application, dtmDados);
//  frmAbout := TfrmAbout.Create(Application, 'About', frmPrincipal);
//  frmPrincipal.About := frmAbout;
//  Application.Run;

  Application.Initialize;
  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Medicus';
  Application.CreateForm(TfrmMenu, frmMenu);
  Sleep(2000);
  frmSplash.Hide;
  FreeAndNil(frmSplash);
  frmConexao  := TfrmConexao.Create(Application, 'Conexão', frmMenu);
  frmLogin    := TfrmLogin.Create(Application, 'Login', frmMenu);
  dmDados     := TdmDados.Create(Application, 'Medicus.ini', frmMenu, frmLogin, frmConexao);
//  dmFast      := TdtmFast.Create(Application, frmPrincipal);
  frmBloquear := TfrmBloquear.Create(Application);
//  frmMenu.About := frmAbout;
  Application.Run;
end.
