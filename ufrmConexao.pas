unit ufrmConexao;

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
  dxSkinWhiteprint, dxSkinXmas2008Blue, StdCtrls, cxButtons, RzRadGrp, RzCommon;

type
  TfrmConexao = class(TfrmForm)
    rifConexao: TRzRegIniFile;
    pnlConexao: TRzPanel;
    rdgConexoes: TRzRadioGroup;
    actConectar: TAction;
    pnlInferior: TRzPanel;
    btnConectar: TcxButton;
    btnSair: TcxButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actConectarExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
  private
    { Private declarations}
  public
    { Public declarations }
  end;

var
  frmConexao: TfrmConexao;

implementation

{$R *.dfm}

procedure TfrmConexao.FormActivate(Sender: TObject);
begin
  inherited;
  rdgConexoes.ItemIndex := rdgConexoes.Items.IndexOf(rifConexao.ReadString(Self.Name, rdgConexoes.Name, ''));
  rdgConexoes.ItemIndex := StrToInt(IfThen(rdgConexoes.ItemIndex >= 0, IntToStr(rdgConexoes.ItemIndex), '0'));
end;

procedure TfrmConexao.FormCreate(Sender: TObject);
begin
  inherited;
  rifConexao.Path := Menu.Variaveis.DirTemp + Application.Title + '.ini';
end;

procedure TfrmConexao.FormDeactivate(Sender: TObject);
begin
  inherited;
  rifConexao.WriteString(Self.Name, rdgConexoes.Name, rdgConexoes.Items[rdgConexoes.ItemIndex]);
end;

procedure TfrmConexao.actConectarExecute(Sender: TObject);
begin
  inherited;
  if rdgConexoes.ItemIndex >= 0 then
    ModalResult := mrOk
  else
    Menu.Mensagens.Aviso('Selecione uma conexão!');
end;

procedure TfrmConexao.actSairExecute(Sender: TObject);
begin
//  inherited;
  ModalResult := mrCancel;
end;

end.

