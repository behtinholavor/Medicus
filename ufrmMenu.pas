unit ufrmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxRibbonSkins, dxSkinsdxRibbonPainter,
  dxSkinsdxBarPainter, dxBar, cxClasses, dxRibbon, dxRibbonBackstageView,
  dxStatusBar, dxRibbonStatusBar, ActnList, ImgList, ExtCtrls, RzPanel, uFuncoes,
  cxPC, dxSkinscxPCPainter, cxPCdxBarPopupMenu, dxTabbedMDI, System.Actions;

type
  TfrmMenu = class(TForm)
    rbtCadastros: TdxRibbonTab;
    rbnMenu: TdxRibbon;
    bmnMenu: TdxBarManager;
    rbtAtendimento: TdxRibbonTab;
    rsbMenu: TdxRibbonStatusBar;
    aclMenu: TActionList;
    rbtRelatorios: TdxRibbonTab;
    rbtConfiguracoes: TdxRibbonTab;
    rbtSobre: TdxRibbonTab;
    actSair: TAction;
    iml32: TcxImageList;
    actPacientes: TAction;
    actConvenios: TAction;
    actExames: TAction;
    actServicos: TAction;
    actMedicamentos: TAction;
    actClinicas: TAction;
    actMedicos: TAction;
    actAgenda: TAction;
    actConsultas: TAction;
    barCadastros: TdxBar;
    btnPacientes: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarLargeButton7: TdxBarLargeButton;
    barAtendimento: TdxBar;
    btnAgenda: TdxBarLargeButton;
    btnConsultas: TdxBarLargeButton;
    barConfiguracoes: TdxBar;
    btnUsuarios: TdxBarLargeButton;
    btnPerfis: TdxBarLargeButton;
    btnUsuariosLogados: TdxBarLargeButton;
    tmmMenu: TdxTabbedMDIManager;
    iml16: TcxImageList;
    actUsuarios: TAction;
    actPerfis: TAction;
    actUsuariosLogados: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure actPacientesExecute(Sender: TObject);
    procedure actConveniosExecute(Sender: TObject);
    procedure actExamesExecute(Sender: TObject);
    procedure actServicosExecute(Sender: TObject);
    procedure actMedicamentosExecute(Sender: TObject);
    procedure actClinicasExecute(Sender: TObject);
    procedure actMedicosExecute(Sender: TObject);
    procedure actUsuariosExecute(Sender: TObject);
    procedure actPerfisExecute(Sender: TObject);
    procedure actUsuariosLogadosExecute(Sender: TObject);
  private
    { Private declarations }
    FVariaveis: TVariaveis;
    FMensagens: TMensagens;
    FLicenca: TLicenca;
    FUsuario: TUsuario;
    FConfigInterface: TInterface;
    procedure SetVariaveis(const Value: TVariaveis);
    procedure SetMensagens(const Value: TMensagens);
    procedure SetLicenca(const Value: TLicenca);
    procedure SetUsuario(const Value: TUsuario);
    procedure SetConfigInterface(const Value: TInterface);
    function GetCreateTela(AFormClass: TFormClass): Boolean;
  public
    { Public declarations }
    property Variaveis: TVariaveis read FVariaveis write SetVariaveis;
    property Mensagens: TMensagens read FMensagens write SetMensagens;
    property Licenca: TLicenca read FLicenca write SetLicenca;
    property Usuario: TUsuario read FUsuario write SetUsuario;
    property ConfigInterface: TInterface read FConfigInterface write SetConfigInterface;
  end;

var
  frmMenu: TfrmMenu;

implementation

uses ufrmForm, ufrmCadastro, ufrmUsuarios;

{$R *.dfm}

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  self.WindowState := wsMaximized;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  Variaveis       := TVariaveis.Create(Application);
  Mensagens       := TMensagens.Create;
  ConfigInterface := TInterface.Create;
end;

procedure TfrmMenu.FormPaint(Sender: TObject);
begin
//  if Width < 1020 then
//    Width := 1020;
//  if Height < 720 then
//    Height := 720;
end;

procedure TfrmMenu.SetVariaveis(const Value: TVariaveis);
begin
  FVariaveis := Value;
end;

procedure TfrmMenu.SetMensagens(const Value: TMensagens);
begin
  FMensagens := Value;
end;

procedure TfrmMenu.SetLicenca(const Value: TLicenca);
begin
  FLicenca := Value;
end;

procedure TfrmMenu.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

procedure TfrmMenu.SetConfigInterface(const Value: TInterface);
begin
  FConfigInterface := Value;
end;

procedure TfrmMenu.actPacientesExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actConveniosExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actExamesExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actServicosExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actClinicasExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actMedicamentosExecute(Sender: TObject);
begin
//
end;

procedure TfrmMenu.actMedicosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenu.actUsuariosExecute(Sender: TObject);
begin
  if GetCreateTela(TfrmUsuarios) then
    iml16.GetIcon(actUsuarios.ImageIndex, TfrmUsuarios.Create(Self, actUsuarios.Caption, Self).Icon);
end;
procedure TfrmMenu.actPerfisExecute(Sender: TObject);
begin
  //-
end;

procedure TfrmMenu.actUsuariosLogadosExecute(Sender: TObject);
begin
  //-
end;

procedure TfrmMenu.actSairExecute(Sender: TObject);
begin
  if self.MDIChildCount = 0 then
  begin
    if Mensagens.Pergunta('Deseja sair do sistema?') then
      Close;
  end
end;

function TfrmMenu.GetCreateTela(AFormClass: TFormClass): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[I].ClassName = AFormClass.ClassName then
    begin
      MDIChildren[I].Show;
      Result := False;
      Break;
    end;
  end;
end;

//rbnMenu.ActiveTab := rbtCadastros;
//rbnMenu.ActiveTab := rbtAtendimento;
//rbnMenu.ActiveTab := rbtConfiguracoes;
//rbnMenu.ActiveTab := rbtRelatorios;
//rbnMenu.ActiveTab := rbtSobre;

end.
