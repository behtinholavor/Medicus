unit ufrmLogin;

interface

uses
  Windows, Classes, ActnList, Controls, ExtCtrls, Forms, RzPanel, ufrmMenu,
  RzDBEdit, RzEdit, Messages, Dialogs, SysUtils, DateUtils, StrUtils, IBCustomDataSet, DB,
  ufrmForm, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, StdCtrls, cxButtons, Mask;

type
  TfrmLogin = class(TfrmForm)
    pnlLogin: TPanel;
    edtLogin: TRzEdit;
    edtSenha: TRzEdit;
    pnlSuperior: TRzPanel;
    actEntrar: TAction;
    actMaster: TAction;
    pnlInferior: TRzPanel;
    btnEntrar: TcxButton;
    btnSair: TcxButton;
    procedure actEntrarExecute(Sender: TObject);
    procedure actMasterExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.actEntrarExecute(Sender: TObject);
var
  Login,
  Usuario,
  CodLogado: string;
  Invalido: Boolean;
begin
  inherited;
  Login     := Menu.Usuario.Login;
  Usuario   := Menu.Usuario.Usuario;
  CodLogado := Menu.Usuario.CodLogado;

  if Menu.Usuario.GetValidaUsuario(edtLogin.Text, edtSenha.Text, Menu.Variaveis) then
  begin
    Invalido := False;
    if (Login <> EmptyStr) and (Login <> Menu.Usuario.Login) then
    begin
      if Menu.MDIChildCount > 0 then
      begin
        if Menu.Mensagens.Pergunta('O usuário "' + Usuario + '" está com uma ou mais telas abertas que ao logar-se essas telas serão fechadas e todas as operações iniciadas e não finalizadas serão canceladas.' + #13 + 'Confirma o seu login?') then
        begin
          Menu.Usuario.SetDesconectaUsuario(CodLogado);
          ModalResult := mrOk;
        end
        else
        begin
          Menu.Usuario.Login := Login;
          edtLogin.Text := EmptyStr;
          edtSenha.Text := EmptyStr;
          edtLogin.SetFocus;
        end;
      end
      else
      begin
        Menu.Usuario.SetDesconectaUsuario(CodLogado);
        ModalResult := mrOk;
      end;
    end
    else
      ModalResult := mrOk;
  end
  else
  begin
    Menu.Usuario.Login := Login;
    edtLogin.Text := EmptyStr;
    edtSenha.Text := EmptyStr;
    edtLogin.SetFocus;
  end;
end;

procedure TfrmLogin.actMasterExecute(Sender: TObject);
begin
  inherited;
  if FileExists(Menu.Variaveis.DirSistema+'\m.txt') then
  begin
    edtLogin.Text := Menu.Usuario.GetLoginMaster;
    edtSenha.Text := Menu.Usuario.GetSenhaMaster;
    actEntrarExecute(Sender);
  end;
end;

procedure TfrmLogin.actSairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
//  FormPrincipal.Usuario.SetDesconectaUsuario(FormPrincipal.Usuario.CodLogado, FormPrincipal);
//  inherited;
end;

end.
