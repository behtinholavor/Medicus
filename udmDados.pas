unit udmDados;

interface

uses
  SysUtils, Classes, Controls, IBDatabase, DB, IdTelnet, Dialogs, RzCommon, Forms, ufrmMenu, ufrmLogin, ufrmConexao;

type
  TdmDados = class(TDataModule)
    dtbDados: TIBDatabase;
    trnDados: TIBTransaction;
    iniDados: TRzRegIniFile;
  private
    { Private declarations }
    FMenu: TfrmMenu;
    FLogin: TfrmLogin;
    FConexao: TfrmConexao;
    function SetConfigurar(Config: String): String;
    function SetConectar(Section: String): Boolean;
    procedure SetAtualizar;
    procedure SetInstalar;
    procedure SetLogar;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConfig: string; AMenu: TfrmMenu; ALogin: TfrmLogin; AConexao: TfrmConexao);
  end;

var
  dmDados: TdmDados;

implementation

uses uFuncoes;

{$R *.dfm}

{ TdmDados }

constructor TdmDados.Create(AOwner: TComponent; AConfig: string;
  AMenu: TfrmMenu; ALogin: TfrmLogin; AConexao: TfrmConexao);
begin
  inherited Create(AOwner);
  FMenu    := AMenu;
  FLogin   := ALogin;
  FConexao := AConexao;

  if SetConectar(SetConfigurar(AConfig)) then
  begin
    SetAtualizar;
    SetInstalar;
    SetLogar;
  end;
end;

function TdmDados.SetConfigurar(Config: String): String;
begin
  try
    Result := '';
    iniDados.Path := FMenu.Variaveis.DirSistema + Config;
    iniDados.ReadSections(FConexao.rdgConexoes.Items);
    if FConexao.rdgConexoes.Items.Count > 1 then
    begin
      if FConexao.ShowModal = mrOk then
        Result := FConexao.rdgConexoes.Items[FConexao.rdgConexoes.ItemIndex]
      else
      begin
        Application.Terminate;
        Exit;
      end;
    end
    else
      Result := FConexao.rdgConexoes.Items.Strings[0];
  except
    on e: Exception do
    begin
      Result := '';
      FMenu.Mensagens.Aviso(PChar('Não foi possível carregar o aquivo de configuração!' + #13 + e.Message));
    end;
  end;
end;

function TdmDados.SetConectar(Section: String): Boolean;
var
  Telnet: TIdTelnet;
  Cript: TCript;
  Host, Alias,
  Porta: String;
begin
  try
    Result := False;
    Host   := iniDados.ReadString(Section, 'servidor', 'localhost');
    Porta  := iniDados.ReadString(Section, 'porta', '3050');
    Alias  := iniDados.ReadString(Section, 'banco', 'medicus');

    Telnet := TIdTelnet.Create(nil);
    Telnet.Host := Host;
    Telnet.Port := StrToInt(Porta);
    Telnet.Connect;
    if not Telnet.Connected then
      Abort;
    FreeAndNil(Telnet);

    Cript := TCript.Create;
    dtbDados.Close;
    dtbDados.DatabaseName := Host+ '/' + Porta + ':' + Alias;
    dtbDados.Params.Clear;
    dtbDados.Params.Add('lc_ctype=' + iniDados.ReadString(Section, 'charset', 'ISO8859_1'));
    dtbDados.Params.Add('user_name=' + Cript.DesCriptografar(iniDados.ReadString(Section, 'login', Cript.Criptografar('sysmed'))));
    dtbDados.Params.Add('password=' + Cript.DesCriptografar(iniDados.ReadString(Section, 'senha', Cript.Criptografar('medset'))));
    dtbDados.Open;
    Result := dtbDados.Connected;

    FreeAndNil(Cript);
  except
    on e: Exception do
    begin
      Result := False;
      FMenu.Mensagens.Aviso(PChar('Não foi possível conectar ao banco de dados!' + #13 + e.Message));
      Application.Terminate;
      Exit;
    end;
  end;
end;

procedure TdmDados.SetAtualizar;
begin
  // 1º Rotina de atualização do executável
  // boolean = True
  // 2º Rotina de atualização da base de dados
  // boolean = True

//  AFormAtualizaVersao.FormShow(AOwner);
//  if AFormAtualizaVersao.GetVerificaAtualizacao then
//  begin
//    if AFormAtualizaVersao.ShowModal <> mrOk then
//    begin
//      Application.Terminate;
//      Exit;
//    end;
//  end;
//  FreeAndNil(AFormAtualizaVersao);
end;

procedure TdmDados.SetInstalar;
begin
  FMenu.Licenca := TLicenca.Create(dtbDados); //parei aqui !!!!!!!!!!!!!!!!!!!!

//  if FMenu.Licenca.Token = EmptyStr then
//  begin
//    if AFormPrimeiroAcesso.ShowModal <> mrOk then
//      Application.Terminate;
//  end
//  else if not FMenu.Licenca.GetValidaLicenca then
//  begin
//    clsAtualizaLicenca := TclsAtualizaLicenca.Create(Self, 'Atualização de licença', FFormPrincipal);
//    if clsAtualizaLicenca.ShowModal <> mrOk then
//    begin
//      Application.Terminate;
//      Exit;
//    end;
//    FreeAndNil(clsAtualizaLicenca);
//  end;
end;

procedure TdmDados.SetLogar;
begin
  FMenu.Usuario        := TUsuario.Create(dtbDados, FMenu.Licenca);
  FLogin.edtLogin.Text := EmptyStr;
  FLogin.edtSenha.Text := EmptyStr;
  if FLogin.ShowModal = mrOk then
  begin
//    FMenu.SetVerificaPermissoes(FFormPrincipal.Database, FFormPrincipal.Usuario.Login);
    FMenu.rsbMenu.Panels[1].Text := 'Login: ' + FMenu.Usuario.Login;
  end
  else
  begin
    Application.Terminate;
    Exit;
  end;
end;

end.
