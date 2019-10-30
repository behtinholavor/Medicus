unit uFuncoes;

interface

uses
  SysUtils, Classes, Windows, Controls, Forms, IBDatabase, IdIPWatch, IBQuery,
  Mask, DB, IB, IBCustomDataSet, Graphics, StdCtrls, RzDBEdit, RzDBBnEd, RzBtnEdt, RzTabs, cxGridDBTableView;

type

  TCript = class
  public
    function Criptografar(AValue: string): string;
    function DesCriptografar(AValue: string): string;
  end;

  TMensagens = class
  public
    constructor Create;
    procedure Aviso(Menssagem: string; Sair: Boolean = False; Focar: TWinControl = nil);
    function Pergunta(Mensagem: string; Padrao: Integer = MB_ICONQUESTION + MB_DEFBUTTON2): Boolean;
  end;

  TVariaveis = class
  private
    FDirTemp: string;
    FDirSistema: string;
    FNomeComputador: string;
    FIPComputador: string;
    FVersao: string;
    procedure SetDirSistema(const Value: string);
    procedure SetDirTemp(const Value: string);
    function GetEnvVarValue(const VarName: string): string;
    procedure SetNomeComputador(const Value: string);
    procedure SetIPComputador(const Value: string);
  public
    constructor Create(AApplication: TApplication);
    function GetBuildInfo(FileName: string): string;
    property DirTemp: string read FDirTemp write SetDirTemp;
    property DirSistema: string read FDirSistema write SetDirSistema;
    property NomeComputador: string read FNomeComputador write SetNomeComputador;
    property IPComputador: string read FIPComputador write SetIPComputador;
    property Versao: string read FVersao;
  end;

  TLicenca = class
  private
    FDocumento: string;
    FToken: string;
    FLicenca: string;
    FAcessos: Integer;
    FData: TTimeStamp;
    FValidade: TTimeStamp;
    FStatus: Integer;
    FLogados: Integer;
    FDias: Integer;
    FDiasUsados: Integer;
    FUtimaVerificacao: TTimeStamp;
    FCript: TCript;
    FDatabase: TIBDatabase;
    FMensagens: TMensagens;
    function GetDocumento: string;
    function GetToken: string;
    function GetLicenca: string;
    function GetAcessos: Integer;
    function GetData: TDate;
    function GetValidade: TDate;
    function GetStatus: Integer;
    function GetLogados: Integer;
    function GetDadosCript: string;
    procedure GetDados(ALicenca: string);
//    function GetAtivo: string;
//    function GetStringLicenca: string;
//    procedure SetLicenca(ALicenca: string; Renovar: Boolean = False);
//    procedure SetGeraLicenca;
  public
    constructor Create(ADatabse: TIBDatabase);
    property Documento: string read GetDocumento;
    property Token: string read GetToken;
    property Licenca: string read GetLicenca;
    property Acessos: Integer read GetAcessos;
    property Data: TDate read GetData;
    property Validade: TDate read GetValidade;
    property Status: Integer read GetStatus;
    property Logados: Integer read GetLogados;
//    function GetRenovaLicenca(ALicenca: string): Boolean;
//    function GetValidaLicenca: Boolean;
//    function GetValidaValidade: Boolean;
//    procedure SetAtualizaAcesso;
//    procedure SetGeraLicencaTrial(ACnpjCpf: string; AToken: string);
  end;

  TUsuario = class
  private
    FCodusuario: Integer;
    FUsuario: string;
    FLogin: string;
    FSenha: string;
    FCodLogado: String;
    FCript: TCript;
    FMensagens: TMensagens;
    FDataBase: TIBDatabase;
    FLicenca: TLicenca;
    FMaster: string;
    FKey: string;
    procedure SetCodUsuario(const Value: Integer);
    procedure SetUsuario(const Value: string);
    procedure SetLogin(const Value: string);
    procedure SetSenha(const Value: string);
    procedure SetMaster(const Value: string);
  public
    constructor Create(ADatabase: TIBDatabase; ALicenca: TLicenca);
    property CodUsuario: Integer read FCodUsuario write SetCodUsuario;
    property Usuario: string read FUsuario write SetUsuario;
    property Login: string read FLogin write SetLogin;
    property Senha: string read FSenha write SetSenha;
    property Master: string read FMaster write SetMaster;
    property CodLogado: String read FCodLogado;
    function GetLoginMaster: string;
    function GetSenhaMaster: string;
    function GetIsMaster: Boolean;
    function GetValidaUsuario(ALogin, ASenha: string; AVariaveis: TVariaveis): Boolean;
    procedure SetDesconectaUsuario(ACodLogado: string);
    procedure SetVerificaUsuario;
  end;

  TCores = class
    Foco: TColor;
    Habilitado: TColor;
    Incosistente: TColor;
    Desabilitado: TColor;
    HotSpot: TColor;
    ApenasLeitura: TColor;
    Consistente: TColor;
  public
    constructor Create;
  end;

  TInterface = class
    function GetField(ADataSet: TDataSet; Campo: string): TField;
    function GetKeyCampo(ADataSet: TDataSet): TField;
    function GetRowDeletado(ADataSet: TDataSet; Value: Integer): Boolean;
//    function GetKeyPai(ADataSet: TDataSet): TField;
    function GetRowTabela(Field: TField; Tipo: Integer): string;
//    function GetNomeCampoFiltro(Field: TField): string;
    procedure GetKeySequencia(ADataSet: TDataSet);
    procedure GetInterface(Form: TForm);
  private
    FCores: TCores;
    procedure SetCores(const Value: TCores);
  public
    constructor Create;
    property Cores: TCores read FCores write SetCores;
//    procedure SetFocaPrimeiroCampo(AWinControl: TWinControl; Index: Integer = 0);
  end;

implementation

uses uGuidEx;

{ TCript }

function TCript.Criptografar(AValue: string): string;
var
  Chave,
  ChaveCript,
  TextoCript: string;
  sKeyChave,
  sKeyTexto: TStringList;
  I: Integer;
begin
  Result     := EmptyStr;
  Chave      := TGuidEx.ToString(TGuidEx.NewGuid);

  sKeyChave  := TStringList.Create;
  sKeyTexto  := TStringList.Create;

  for I := 1 to Length(Chave) do
  begin
    sKeyChave.Values[IntToStr(I)] := IntToStr(Ord(Chave[I]));
    ChaveCript := ChaveCript + FormatFloat('000', Ord(Chave[I]) );
  end;

  for I := 1 to Length(AValue) do
  begin
    sKeyTexto.Values[IntToStr(I)] := FormatFloat('000', Ord(AValue[I]) + StrToInt(sKeyChave.Values[IntToStr(I)]) );
    TextoCript := TextoCript + FormatFloat('000', Ord(AValue[I]) + StrToInt(sKeyChave.Values[IntToStr(I)]) );
  end;

  Result := ChaveCript + TextoCript;
  FreeAndNil(sKeyChave);
  FreeAndNil(sKeyTexto);
end;

function TCript.DesCriptografar(AValue: string): string;
var
  Chave,
  Texto,
  Licenca: string;
  sKeyChave,
  sKeyTexto: TStringList;
  I: Integer;
begin
  Result    := EmptyStr;
  Licenca   := Trim(AValue);
  Chave     := Trim(Copy(Licenca, 1, 114));
  Texto     := Trim(Copy(Licenca, 115, Length(Licenca)));

  sKeyChave := TStringList.Create;
  sKeyTexto := TStringList.Create;

  I := 1;
  repeat
    sKeyChave.Values[IntToStr(I)] := Copy(Chave, 1, 3);
    Chave := Copy(Chave, 4, Length(Chave));
    Inc(I);
  until
    Chave = EmptyStr;

  for I := 0 to sKeyChave.Count - 1 do
    Chave := Chave + Chr(StrToInt(sKeyChave.Values[IntToStr(I+1)]));

  I := 1;
  repeat
    sKeyTexto.Values[IntToStr(I)] := Copy(Texto, 1, 3);
    Texto := Copy(Texto, 4, Length(Texto));
    Inc(I);
  until
    Texto = EmptyStr;

  for I := 0 to sKeyTexto.Count - 1 do
    Texto := Texto + Chr(StrToInt(sKeyTexto.Values[IntToStr(I+1)]) - StrToInt(sKeyChave.Values[IntToStr(I+1)]) );

//  Result := Chave + Texto;
  Result := Texto;
  FreeAndNil(sKeyChave);
  FreeAndNil(sKeyTexto);
end;

{ TMensagens }

constructor TMensagens.Create;
begin
  //
end;

procedure TMensagens.Aviso(Menssagem: string; Sair: Boolean;
  Focar: TWinControl);
begin
  Application.MessageBox(PWideChar(Menssagem), PWideChar(Application.Title), MB_ICONINFORMATION + MB_OK);
  if Focar <> nil then
    Focar.SetFocus;
  if Sair then
    Abort;
end;

function TMensagens.Pergunta(Mensagem: string; Padrao: Integer): Boolean;
begin
  Result := Application.MessageBox(PWideChar(Mensagem), PWideChar(Application.Title), MB_YESNO + Padrao) = IDYES;
end;

{ TVariaveis }

constructor TVariaveis.Create(AApplication: TApplication);
var
  ipwIP: TIdIPWatch;
begin
  ipwIP := TIdIPWatch.Create(nil);
  FDirSistema := ExtractFilePath(AApplication.ExeName);
  FDirTemp := ExtractFilePath(GetEnvVarValue('TEMP')) + Application.Title + '\';
  FVersao := GetBuildInfo(AApplication.ExeName);
  FIPComputador := ipwIP.LocalIP;
  FNomeComputador := GetEnvVarValue('ComputerName');
  ForceDirectories(FDirTemp);
  FreeAndNil(ipwIP);
end;

function TVariaveis.GetBuildInfo(FileName: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);
  Result := IntToStr(v1) + '.' + IntToStr(v2) + '.' + IntToStr(v3) + '.' + IntToStr(v4);
end;

function TVariaveis.GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName),
      PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

procedure TVariaveis.SetNomeComputador(const Value: string);
begin
  FNomeComputador := Value;
end;

procedure TVariaveis.SetDirSistema(const Value: string);
begin
  FDirSistema := Value;
end;

procedure TVariaveis.SetDirTemp(const Value: string);
begin
  FDirTemp := Value;
end;

procedure TVariaveis.SetIPComputador(const Value: string);
begin
  FIPComputador := Value;
end;

{ TLicenca }

constructor TLicenca.Create(ADatabse: TIBDatabase);
begin
  FCript     := TCript.Create;
  FMensagens := TMensagens.Create;
  FDatabase  := ADatabse;
  GetDados(GetDadosCript);
end;

function TLicenca.GetDocumento: string;
begin
  Result := FDocumento;
end;

function TLicenca.GetToken: string;
var
  Mascara: TMaskEdit;
begin
  Mascara           := TMaskEdit.Create(nil);
  Mascara.Text      := FToken;
  Mascara.EditMask  := 'AAAA-AAAA-AAAA-AAAA-AAAA-AAAA-AAAA-AAAA;1; ';
  Result            := Mascara.Text;
  if Result = '    -    -    -    -    -    -    -    ' then
    Result := EmptyStr;
  FreeAndNil(Mascara);
end;

function TLicenca.GetLicenca: string;
var
  Mascara: TMaskEdit;
begin
  if FLicenca <> 'Trial' then
  begin
    Mascara           := TMaskEdit.Create(nil);
    Mascara.Text      := FLicenca;
    Mascara.EditMask  := 'AAAA-AAAA-AAAA-AAAA-AAAA-AAAA-AAAA-AAAA;1; ';
    Result := Mascara.Text;
    FreeAndNil(Mascara);
  end
  else
    Result := FLicenca;
end;

function TLicenca.GetAcessos: Integer;
begin
  Result := FAcessos;
end;

function TLicenca.GetData: TDate;
begin
  Result := TimeStampToDateTime(FData);
end;

function TLicenca.GetValidade: TDate;
begin
  Result := TimeStampToDateTime(FValidade);
end;

function TLicenca.GetStatus: Integer;
begin
  Result := FStatus;
end;

function TLicenca.GetLogados: Integer;
var
  qryLogados: TIBQuery;
begin
  qryLogados := TIBQuery.Create(nil);
  qryLogados.Database := FDatabase;
  qryLogados.Transaction := FDatabase.DefaultTransaction;
  qryLogados.SQL.Add('select');
  qryLogados.SQL.Add('  count(CODLOGADO)');
  qryLogados.SQL.Add('from');
  qryLogados.SQL.Add('  LOGADOS');
  qryLogados.Open;
  Result := qryLogados.Fields[0].AsInteger;
  FreeAndNil(qryLogados);
end;

function TLicenca.GetDadosCript: string;
var
  qryLicenca: TIBQuery;
begin
  Result := EmptyStr;
  qryLicenca := TIBQuery.Create(nil);
  qryLicenca.Database := FDatabase;
  qryLicenca.Transaction := FDatabase.DefaultTransaction;
  qryLicenca.Close;
  qryLicenca.SQL.Clear;
  qryLicenca.SQL.Add('select');
  qryLicenca.SQL.Add('  R.RDB$ID');
  qryLicenca.SQL.Add('from');
  qryLicenca.SQL.Add('  RDB$LICENCA R');
  qryLicenca.Open;
  if not qryLicenca.IsEmpty then
    Result := qryLicenca.FieldByName('RDB$ID').AsString;
  FreeAndNil(qryLicenca);
end;

procedure TLicenca.GetDados(ALicenca: string);
var
  stlLicenca: TStringList;
begin
  stlLicenca := TStringList.Create;
  if ALicenca <> '' then
  begin
    stlLicenca.Delimiter      := '~';
    stlLicenca.DelimitedText  := FCript.DesCriptografar(ALicenca);
    FDocumento                := stlLicenca.Values['Documento'];
    FToken                    := stlLicenca.Values['Token'];
    FLicenca                  := stlLicenca.Values['Licença'];
    FAcessos                  := StrToInt(stlLicenca.Values['Acessos']);
    FData                     := DateTimeToTimeStamp(StrToDate(stlLicenca.Values['Data']));
    FValidade                 := DateTimeToTimeStamp(StrToDate(stlLicenca.Values['Validade']));
    FStatus                   := StrToInt(stlLicenca.Values['Status']);
    FDias                     := StrToInt(stlLicenca.Values['Dias']);
    FDiasUsados               := StrToInt(stlLicenca.Values['DiasUsados']);
    FUtimaVerificacao         := DateTimeToTimeStamp(StrToDate(stlLicenca.Values['UltimaVerificacao']));
  end;
  FreeAndNil(stlLicenca);
end;

{ TUsuario }

constructor TUsuario.Create(ADatabase: TIBDatabase; ALicenca: TLicenca);
begin
  FCript     := TCript.Create;
  FMensagens := TMensagens.Create;
  FDataBase  := ADatabase;
  FLicenca   := ALicenca;
  FMaster    := 'MEDICUS';
  FKey       := 'm3d1c0';
end;

procedure TUsuario.SetCodUsuario(const Value: Integer);
begin
  FCodUsuario := Value;
end;

procedure TUsuario.SetUsuario(const Value: string);
begin
  FUsuario := Value;
end;

procedure TUsuario.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TUsuario.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

procedure TUsuario.SetMaster(const Value: string);
begin
  FMaster := Value;
end;

function TUsuario.GetLoginMaster: string;
begin
  Result := Master;
end;

function TUsuario.GetSenhaMaster: string;
var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(Now, Ano, Mes, Dia);
  Result := Copy(Master, 1, 3) + FormatCurr('00', Dia + 0) + FormatCurr('00', Mes + 0);
end;

function TUsuario.GetIsMaster: Boolean;
begin
  Result := (FLogin = Master) and (Senha = GetSenhaMaster);
end;

function TUsuario.GetValidaUsuario(ALogin, ASenha: string; AVariaveis: TVariaveis): Boolean;
var
  qryConsulta: TIBQuery;
begin
  qryConsulta := TIBQuery.Create(nil);
  qryConsulta.Database := FDataBase;
  if ALogin = Master then
  begin
    FCodUsuario := 0;
    FUsuario    := Master;
    Result      := ASenha = GetSenhaMaster;
  end
  else
  begin
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('select');
    qryConsulta.SQL.Add('  U.CODUSUARIO,');
    qryConsulta.SQL.Add('  U.USUARIO,');
    qryConsulta.SQL.Add('  U.LOGIN,');
    qryConsulta.SQL.Add('  U.SENHA');
    qryConsulta.SQL.Add('from');
    qryConsulta.SQL.Add('  USUARIOS U');
    qryConsulta.SQL.Add('where');
    qryConsulta.SQL.Add('  U.ATIVO = ''SIM'' and');
    qryConsulta.SQL.Add('  U.LOGIN = :LOGIN');
    qryConsulta.ParamByName('LOGIN').AsString := ALogin;
    qryConsulta.Open;
    FUsuario    := qryConsulta.FieldByName('USUARIO').AsString;
    FCodUsuario := qryConsulta.FieldByName('CODUSUARIO').AsInteger;
    Result      := (not (qryConsulta.IsEmpty)) and (FCript.DesCriptografar(qryConsulta.FieldByName('SENHA').AsString) = ASenha);
  end;

  if Result then
  begin
    if ALogin <> Master then
    begin
      Result := FLicenca.Acessos >= (FLicenca.Logados + 1);
      if Result then
      begin
        if (FLogin = EmptyStr) or (FLogin <> ALogin) then
        begin
          FLogin := ALogin;
          FSenha := ASenha;
          qryConsulta.Close;
          qryConsulta.SQL.Clear;
          qryConsulta.SQL.Add('select');
          qryConsulta.SQL.Add('  CODLOGADO');
          qryConsulta.SQL.Add('from');
          qryConsulta.SQL.Add('  STP_LOGADOS(');
          qryConsulta.SQL.Add('    :CODLOGADO,');
          qryConsulta.SQL.Add('    :LOGIN,');
          qryConsulta.SQL.Add('    :COMPUTER,');
          qryConsulta.SQL.Add('    :IP,');
          qryConsulta.SQL.Add('    :TIPOOPERACAO)');
          if FLogin <> ALogin then
          begin
            qryConsulta.ParamByName('CODLOGADO').AsString     := FCodLogado;
            qryConsulta.ParamByName('TIPOOPERACAO').AsInteger := 0;
            qryConsulta.Open;
            qryConsulta.Transaction.CommitRetaining;
          end;
          qryConsulta.ParamByName('CODLOGADO').AsString       := TGuidEx.ToString(TGuidEx.NewGuid);
          qryConsulta.ParamByName('LOGIN').AsString           := FLogin;
          qryConsulta.ParamByName('COMPUTER').AsString        := AVariaveis.NomeComputador;
          qryConsulta.ParamByName('IP').AsString              := AVariaveis.IPComputador;
          qryConsulta.ParamByName('TIPOOPERACAO').AsInteger   := 1;
          qryConsulta.Open;
          FCodLogado := qryConsulta.FieldByName('CODLOGADO').AsString;
          qryConsulta.Transaction.CommitRetaining;
        end;
      end
      else
        FMensagens.Aviso('Quantidade acessos aitvos excede o nº de acessos da licença, por favor entre em contato com o administrador do sistema.');
    end
    else
    begin
      FLogin := ALogin;
      FSenha := ASenha;
    end;
  end
  else
    FMensagens.Aviso('Usuário ou senha inválidos.');
  FreeAndNil(qryConsulta);
end;

procedure TUsuario.SetDesconectaUsuario(ACodLogado: string);
var
  qryConsulta: TIBQuery;
begin
  qryConsulta := TIBQuery.Create(nil);
  qryConsulta.Database := FDataBase;
  qryConsulta.Transaction := FDataBase.DefaultTransaction;
  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('select');
  qryConsulta.SQL.Add('  CODLOGADO');
  qryConsulta.SQL.Add('from');
  qryConsulta.SQL.Add('  STP_LOGADOS(');
  qryConsulta.SQL.Add('    :CODLOGADO,');
  qryConsulta.SQL.Add('    null,');
  qryConsulta.SQL.Add('    null,');
  qryConsulta.SQL.Add('    null,');
  qryConsulta.SQL.Add('    :TIPOOPERACAO)');
  qryConsulta.ParamByName('CODLOGADO').AsString     := ACodLogado;
  qryConsulta.ParamByName('TIPOOPERACAO').AsInteger := 0;
  qryConsulta.Open;
  qryConsulta.Transaction.CommitRetaining;
  FreeAndNil(qryConsulta);
end;

procedure TUsuario.SetVerificaUsuario;
var
  qryConsulta: TIBQuery;
begin
  if FLogin <> Master then
  begin
    qryConsulta := TIBQuery.Create(nil);
    qryConsulta.Database := FDataBase;
    qryConsulta.Transaction := FDataBase.DefaultTransaction;
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('select');
    qryConsulta.SQL.Add('  CODLOGADO');
    qryConsulta.SQL.Add('from');
    qryConsulta.SQL.Add('  STP_LOGADOS(');
    qryConsulta.SQL.Add('    :CODLOGADO,');
    qryConsulta.SQL.Add('    null,');
    qryConsulta.SQL.Add('    null,');
    qryConsulta.SQL.Add('    null,');
    qryConsulta.SQL.Add('    :TIPOOPERACAO)');
    qryConsulta.ParamByName('CODLOGADO').AsString     := FCodLogado;
    qryConsulta.ParamByName('TIPOOPERACAO').AsInteger := 2;
    qryConsulta.Open;
    qryConsulta.Transaction.CommitRetaining;
    if qryConsulta.FieldByName('CODLOGADO').AsString = EmptyStr then
    begin
      FMensagens.Aviso('Você foi desconetado do sistema e todas as operações pendentes serão canceladas.');
      SetDesconectaUsuario(FCodLogado);
      Application.Terminate;
    end;
    FreeAndNil(qryConsulta);
  end;
end;

{ TCores }

constructor TCores.Create;
begin
  Foco          := $00FFDFBF;//$00A8FFFF;
  Habilitado    := clWindow;
  Incosistente  := $004040FF;//$00BEBCFE;
  Desabilitado  := $00EBEBEB;
  HotSpot       := $00FF8000;//clYellow;
  ApenasLeitura := Habilitado;
  Consistente   := $00AAFFAA;//$00C4FFC4;
end;

{ TInterface }

constructor TInterface.Create;
begin
  FCores := TCores.Create;
end;

procedure TInterface.SetCores(const Value: TCores);
begin
  FCores := Value;
end;

function TInterface.GetField(ADataSet: TDataSet; Campo: string): TField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ADataSet.FieldCount - 1 do
  begin
    if ADataSet.Fields[I].FieldName = Campo then
    begin
      Result := ADataSet.Fields[I];
      Break;
    end;
  end;
end;

function TInterface.GetKeyCampo(ADataSet: TDataSet): TField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ADataSet.FieldCount - 1 do
  begin
    if pfInKey in ADataSet.Fields[I].ProviderFlags then
    begin
      Result := ADataSet.Fields[I];
      Break;
    end;
  end;
end;

function TInterface.GetRowDeletado(ADataSet: TDataSet; Value: Integer): Boolean;
var
  qryConsulta: TIBQuery;
  fldField: TField;
begin
  fldField := GetKeyCampo(ADataSet);
  qryConsulta := TIBQuery.Create(nil);
  if ADataSet is TIBDataSet then
  begin
    qryConsulta.Database := TIBDataSet(ADataset).Database;
    qryConsulta.Transaction := TIBDataSet(ADataset).Transaction;
  end
  else if ADataSet is TIBQuery then
  begin
    qryConsulta.Database := TIBQuery(ADataset).Database;
    qryConsulta.Transaction := TIBQuery(ADataset).Transaction;
  end;
  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('select');
  qryConsulta.SQL.Add('  ' + fldField.Origin);
  qryConsulta.SQL.Add('from');
  qryConsulta.SQL.Add('  ' + GetRowTabela(fldField, 1));
  qryConsulta.SQL.Add('where');
  qryConsulta.SQL.Add('  ' + fldField.Origin + ' = :' + GetRowTabela(fldField, 2));
  qryConsulta.Params[0].AsInteger := Value;
  qryConsulta.Open;
  Result := not qryConsulta.IsEmpty;
  FreeAndNil(qryConsulta);
  if not Result then
  begin
//    Mensagens.Aviso('Este registro foi excluído.');
    ADataSet.Close;
    ADataSet.Open;
  end;
end;

function TInterface.GetRowTabela(Field: TField; Tipo: Integer): string;
begin
  case Tipo of
    1: Result := Copy(Field.Origin, 2, Pos('"."', Field.Origin) - 2); //Retorna a tabela
    2: Result := Copy(Field.Origin, Pos('"."', Field.Origin) + 3, Length(Field.Origin) - (Pos('"."', Field.Origin) + 3));//Retorna o campo
  end;
end;

procedure TInterface.GetKeySequencia(ADataSet: TDataSet);
var
  qryConsulta: TIBQuery;
  fldKey: TField;
begin
  fldKey := GetKeyCampo(ADataSet);
  if fldKey.AsInteger = 0 then
  begin
    qryConsulta := TIBQuery.Create(nil);
    qryConsulta.Database := TIBDataSet(ADataSet).Database;
    qryConsulta.SQL.Add('select');
    qryConsulta.SQL.Add('  max(' + fldKey.FieldName + ') KEY');
    qryConsulta.SQL.Add('from');
    qryConsulta.SQL.Add('  ' + GetRowTabela(fldKey, 1));
    qryConsulta.Open;

    TIBDataSet(ADataSet).DisableControls;
    TIBDataSet(ADataSet).Edit;
    fldKey.AsInteger := qryConsulta.FieldByName('KEY').AsInteger;
    TIBDataSet(ADataSet).Post;
    TIBDataSet(ADataSet).EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TInterface.GetInterface(Form: TForm);
var
  I: Integer;
  fldFiled: TField;
begin
  for I := 0 to Form.ComponentCount - 1 do
  begin
    try
      if Form.Components[I] is TRzDBEdit then
      begin
        TRzDBEdit(Form.Components[I]).FrameVisible  := True;
        TRzDBEdit(Form.Components[I]).Color         := Cores.Habilitado;
        TRzDBEdit(Form.Components[I]).FocusColor    := FCores.Foco;
        TRzDBEdit(Form.Components[I]).ReadOnlyColor := FCores.ApenasLeitura;
        TRzDBEdit(Form.Components[I]).DisabledColor := FCores.Desabilitado;
        TRzDBEdit(Form.Components[I]).AutoSize      := False;
        if TRzDBEdit(Form.Components[I]).CharCase <> ecLowerCase then
          TRzDBEdit(Form.Components[I]).CharCase    := ecUpperCase;
        TRzDBEdit(Form.Components[I]).Font.Height   := -14;
        TRzDBEdit(Form.Components[I]).Height        := 25;

        fldFiled                                    := GetField(TRzDBEdit(Form.Components[I]).DataSource.DataSet, TRzDBEdit(Form.Components[I]).DataField);
        TRzDBEdit(Form.Components[I]).TextHint      := fldFiled.DisplayLabel;
        TRzDBEdit(Form.Components[I]).TextHintVisibleOnFocus := True;

        if GetField(TRzDBEdit(Form.Components[I]).DataSource.DataSet, TRzDBEdit(Form.Components[I]).DataField).DataType = ftString then
          TRzDBEdit(Form.Components[I]).MaxLength := GetField(TRzDBEdit(Form.Components[I]).DataSource.DataSet, TRzDBEdit(Form.Components[I]).DataField).Size;

        if Form.Components[I] is TRzDBButtonEdit then
        begin
          TRzDBButtonEdit(Form.Components[I]).ButtonKind      := bkFind;
          TRzDBButtonEdit(Form.Components[I]).ButtonShortCut  := VK_F8;
        end
        else if Form.Components[I] is TRzDBNumericEdit then
        begin
          TRzDBNumericEdit(Form.Components[I]).AllowBlank     := False;
//          fldFiled                                            := GetField(TRzDBEdit(Form.Components[I]).DataSource.DataSet, TRzDBEdit(Form.Components[I]).DataField);
          TRzDBNumericEdit(Form.Components[I]).DisplayFormat  := TFloatField(fldFiled).DisplayFormat;
          TRzDBNumericEdit(Form.Components[I]).IntegersOnly   := Pos('.', TRzDBNumericEdit(Form.Components[I]).DisplayFormat) = 0;
        end;
      end
//      else if Form.Components[I] is TRzMaskEdit then
//      begin
//        TRzMaskEdit(Form.Components[I]).FrameVisible := True;
//        TRzMaskEdit(Form.Components[I]).Color := Cores.Habilitado;
//        TRzMaskEdit(Form.Components[I]).FocusColor := Cores.Foco;
//        TRzMaskEdit(Form.Components[I]).ReadOnlyColor := Cores.ApenasLeitura;
//        TRzMaskEdit(Form.Components[I]).DisabledColor := Cores.Desabilitado;
//      end
//      else if Form.Components[I] is TRzEdit then
//      begin
//        TRzEdit(Form.Components[I]).FrameVisible := True;
//        TRzEdit(Form.Components[I]).Color := Cores.Habilitado;
//        TRzEdit(Form.Components[I]).FocusColor := Cores.Foco;
//        TRzEdit(Form.Components[I]).ReadOnlyColor := Cores.ApenasLeitura;
//        TRzEdit(Form.Components[I]).DisabledColor := Cores.Desabilitado;
//        if TRzEdit(Form.Components[I]).Tag = 0 then
//          TRzEdit(Form.Components[I]).CharCase := ecUpperCase;
//        if Form.Components[I] is TRzNumericEdit then
//          TRzNumericEdit(Form.Components[I]).AllowBlank := False;
//      end
//      else if Form.Components[I] is TRzSizePanel then
//      begin
//        TRzSizePanel(Form.Components[I]).HotSpotColor := Cores.HotSpot;
//      end
      else if Form.Components[I] is TRzTabSheet then
      begin
        if TRzTabSheet(Form.Components[I]).Tag = 0 then
          TRzTabSheet(Form.Components[I]).TabVisible := False;
      end
//      else if Form.Components[I] is TRzDBMemo then
//      begin
//        TRzDBMemo(Form.Components[I]).FrameVisible := True;
//        TRzDBMemo(Form.Components[I]).Color := Cores.Habilitado;
//        TRzDBMemo(Form.Components[I]).FocusColor := Cores.Foco;
//        TRzDBMemo(Form.Components[I]).ReadOnlyColor := Cores.ApenasLeitura;
//        TRzDBMemo(Form.Components[I]).DisabledColor := Cores.Desabilitado;
//        if TRzDBMemo(Form.Components[I]).Tag = 0 then
//          TRzDBMemo(Form.Components[I]).OnKeyPress := MemoKeyPress;
//      end
//      else if Form.Components[I] is TRzMemo then
//      begin
//        TRzMemo(Form.Components[I]).FrameVisible := True;
//        TRzMemo(Form.Components[I]).Color := Cores.Habilitado;
//        TRzMemo(Form.Components[I]).FocusColor := Cores.Foco;
//        TRzMemo(Form.Components[I]).ReadOnlyColor := Cores.ApenasLeitura;
//        TRzMemo(Form.Components[I]).DisabledColor := Cores.Desabilitado;
//        if TRzMemo(Form.Components[I]).Tag = 0 then
//          TRzMemo(Form.Components[I]).OnKeyPress := MemoKeyPress;
//      end
//      else if Form.Components[I] is TRzLabel then
//      begin
//        TRzLabel(Form.Components[I]).Font.Style := [fsBold];
//        TRzLabel(Form.Components[I]).BorderOuter := fsFlatRounded;
//        TRzLabel(Form.Components[I]).Height := 24;
//        TRzLabel(Form.Components[I]).TextMargin := 1;
//        if TRzLabel(Form.Components[I]).Tag = 0 then
//          TRzLabel(Form.Components[I]).ParentColor := True;
//        if TRzLabel(Form.Components[I]).Parent.Name = 'spnFuncoes' then
//        begin
//          TRzLabel(Form.Components[I]).ParentColor := False;
//          TRzLabel(Form.Components[I]).Color := clWindow;
//        end;
//
//        if Form.Components[I] is TRzDBLabel then
//        begin
//          if TRzDBLabel(Form.Components[I]).Parent.Name = 'pnlRodape' then
//          begin
//            TRzDBLabel(Form.Components[I]).ParentColor := False;
//            TRzDBLabel(Form.Components[I]).Color := clWindow;
//            TRzDBLabel(Form.Components[I]).Height := 25;
//            TRzDBLabel(Form.Components[I]).TextMargin := 5;
//            TRzDBLabel(Form.Components[I]).Width := 132;
//            TRzDBLabel(Form.Components[I]).AutoSize := False;
//            TRzDBLabel(Form.Components[I]).Anchors := [akLeft,akTop];
//          end;
//
//          if TRzDBLabel(Form.Components[I]).DataField = 'US_CADAST' then
//          begin
//            TRzDBLabel(Form.Components[I]).Left := 89;
//            TRzDBLabel(Form.Components[I]).Top := 10;
//          end
//          else if TRzDBLabel(Form.Components[I]).DataField = 'DT_CADAST' then
//          begin
//            TRzDBLabel(Form.Components[I]).Left := 306;
//            TRzDBLabel(Form.Components[I]).Top := 10;
//          end
//          else if TRzDBLabel(Form.Components[I]).DataField = 'US_MODIFI' then
//          begin
//            TRzDBLabel(Form.Components[I]).Anchors := [akRight,akTop];
//            TRzDBLabel(Form.Components[I]).Top := 10;
//          end
//          else if TRzDBLabel(Form.Components[I]).DataField = 'DT_MODIFI' then
//          begin
//            TRzDBLabel(Form.Components[I]).Anchors := [akRight,akTop];
//            TRzDBLabel(Form.Components[I]).Top := 10;
//          end;
//        end
//      end
//      else if (Form.Components[I] is TRzDBLookupComboBox) and (Form.Components[I].Tag = 0) then
//      begin
//        if not Assigned(TRzDBLookupComboBox(Form.Components[I]).OnExit) then
//          TRzDBLookupComboBox(Form.Components[I]).OnExit := SetLookupComboExit;
//      end
      else if Form.Components[I] is TcxGridDBTableView then
      begin
        TcxGridDBTableView(Form.Components[I]).OptionsView.NoDataToDisplayInfoText := 'Não existem registros para exibir';
        if TcxGridDBTableView(Form.Components[I]).Tag = 0 then
          TcxGridDBTableView(Form.Components[I]).OptionsCustomize.ColumnsQuickCustomization := True;
      end
//      else if Form.Components[I] is TRzProgressBar then
//      begin
//        TRzProgressBar(Form.Components[I]).BarStyle := bsGradient;
//      end
//      else if Form.Components[I] is TRzGroupBox then
//      begin
//        TRzGroupBox(Form.Components[I]).TabStop := False;
//        TRzGroupBox(Form.Components[I]).ParentColor := True;
//        TRzGroupBox(Form.Components[I]).VisualStyle := vsGradient;
//      end
//      else if Form.Components[I] is TLabel then
//      begin
//        if TLabel(Form.Components[I]).Name = 'lblCadastradoPor' then
//         begin
//          TLabel(Form.Components[I]).Left := 7;
//          TLabel(Form.Components[I]).Top := 16;
//          TLabel(Form.Components[I]).AutoSize := True;
//          TLabel(Form.Components[I]).Anchors := [akLeft,akTop];
//          TLabel(Form.Components[I]).Caption := 'Cadastrado por';
//        end
//        else if TLabel(Form.Components[I]).Name = 'lblCadastradoEm' then
//        begin
//          TLabel(Form.Components[I]).Left := 225;
//          TLabel(Form.Components[I]).Top := 16;
//          TLabel(Form.Components[I]).AutoSize := True;
//          TLabel(Form.Components[I]).Anchors := [akLeft,akTop];
//          TLabel(Form.Components[I]).Caption := 'Cadastrado em';
//        end
//        else if TLabel(Form.Components[I]).Name = 'lblModificadoPor' then
//        begin
////          TLabel(Form.Components[I]).Left := 447;
//          TLabel(Form.Components[I]).Top := 16;
//          TLabel(Form.Components[I]).AutoSize := True;
//          TLabel(Form.Components[I]).Anchors := [akRight,akTop];
//          TLabel(Form.Components[I]).Caption := 'Modificado por';
//        end
//        else if TLabel(Form.Components[I]).Name = 'lblModificadoEm' then
//        begin
////          TLabel(Form.Components[I]).Left := 658;
//          TLabel(Form.Components[I]).Top := 16;
//          TLabel(Form.Components[I]).AutoSize := True;
//          TLabel(Form.Components[I]).Anchors := [akRight,akTop];
//          TLabel(Form.Components[I]).Caption := 'Modificado em';
//        end;
//      end
    except
      on e: Exception do
      begin
        //FMensagens.Aviso('Erro ao carregar o objeto "' + TComponent(Form.Components[I]).Name + '".');
      end;
    end;
  end;
end;

end.
