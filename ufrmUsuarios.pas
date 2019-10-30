unit ufrmUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCadastro, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, DB, IBCustomDataSet, IBDatabase, ActnList, RzTabs,
  cxLabel, ExtCtrls, RzPanel, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, Mask, RzEdit, RzDBEdit, RzLabel, RzDBLbl,
  RzCmboBx, RzDBCmbo, ImgList, Menus, cxButtons, cxImage, AdvGlowButton;

type
  TfrmUsuarios = class(TfrmCadastro)
    dttCadastroCODUSUARIO: TIntegerField;
    dttCadastroUSUARIO: TIBStringField;
    dttCadastroLOGIN: TIBStringField;
    dttCadastroSENHA: TIBStringField;
    dttCadastroEMAIL: TIBStringField;
    dttCadastroATIVO: TIBStringField;
    dttCadastroCODPERFIL: TIntegerField;
    dttCadastroCODBINARIO: TIntegerField;
    dttCadastroUS_CADAST: TIBStringField;
    dttCadastroDT_CADAST: TDateTimeField;
    dttCadastroUS_MODIFI: TIBStringField;
    dttCadastroDT_MODIFI: TDateTimeField;
    procedure dttCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

procedure TfrmUsuarios.dttCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  dttCadastro.FieldByName('ATIVO').AsString      := 'SIM';
  dttCadastro.FieldByName('CODPERFIL').AsInteger := 2;
end;

end.
