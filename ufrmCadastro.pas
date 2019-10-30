unit ufrmCadastro;

interface

uses
  Windows, Classes, ActnList, Controls, ExtCtrls, Forms, RzPanel, ufrmMenu,
  RzDBEdit, RzEdit, Messages, Dialogs, SysUtils, DateUtils, StrUtils, IBCustomDataSet, DB,
  ufrmForm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, IBDatabase, RzTabs, cxLabel, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ImgList, AdvGlowButton, RzButton,
  Menus, StdCtrls, cxButtons;

type
  TfrmCadastro = class(TfrmForm)
    actInserir: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actGravar: TAction;
    actCancelar: TAction;
    trnCadastro: TIBTransaction;
    dttCadastro: TIBDataSet;
    dtsCadastro: TDataSource;
    pnlInferior: TRzPanel;
    pgcCadastro: TRzPageControl;
    tbsCadastro: TRzTabSheet;
    pnlCadastro: TRzPanel;
    tbsPesquisa: TRzTabSheet;
    grdPesquisa: TcxGrid;
    gtvPesquisa: TcxGridDBTableView;
    grlPesquisa: TcxGridLevel;
    imlAcoes: TcxImageList;
    pnlAcoes: TRzPanel;
    btnInserir: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    btnExcluir: TAdvGlowButton;
    btnGravar: TAdvGlowButton;
    btnAlterar: TAdvGlowButton;
    actPrimeiro: TAction;
    actAnterior: TAction;
    actPosterior: TAction;
    actUltimo: TAction;
    procedure FormActivate(Sender: TObject); override;
    procedure FormCreate(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean); virtual;

    procedure actInserirExecute(Sender: TObject); virtual;
    procedure actAlterarExecute(Sender: TObject); virtual;
    procedure actExcluirExecute(Sender: TObject); virtual;
    procedure actGravarExecute(Sender: TObject); virtual;
    procedure actCancelarExecute(Sender: TObject); virtual;

    procedure dtsCadastroStateChange(Sender: TObject); virtual;

    procedure dttCadastroBeforePost(DataSet: TDataSet); virtual;
    procedure actVisualizarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure dttCadastroAfterOpen(DataSet: TDataSet);
    procedure actImprimirDesignerExecute(Sender: TObject);
    procedure actImprimirRestaurarExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
  private
    { Private declarations }
    procedure SetImprimeRegistro;
  public
    { Public declarations }
    FDataSet: TIBDataSet;
    FDataSource: TDataSource;
    FTransaction: TIBTransaction;
    FFormActive: TfrmCadastro;
    procedure SetDataSet(const Value: TIBDataSet);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetTransaction(const Value: TIBTransaction);
    procedure SetFormActive(const Value: TfrmCadastro);
    property DataSet: TIBDataSet read FDataSet write SetDataSet;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Transaction: TIBTransaction read FTransaction write SetTransaction;
    property FormActive: TfrmCadastro read FFormActive write SetFormActive;
    procedure SetSair; override;
  end;

var
  frmCadastro: TfrmCadastro;

implementation

uses udmDados;

{$R *.dfm}

procedure TfrmCadastro.FormActivate(Sender: TObject);
begin
  inherited;
//  Menu.dtsPrincipal.DataSet := DataSet;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  FFormActive  := TfrmCadastro(Form);
  FDataSet     := FFormActive.dttCadastro;
  FDatasource  := FFormActive.dtsCadastro;
  FTransaction := FFormActive.dttCadastro.Transaction;


  if not DataSet.Active then
    DataSet.Active := True;
  DataSet.Open;

  FormActive.pgcCadastro.ActivePage := FormActive.tbsCadastro;

//  SetLocalizaGroupBox(pnlCadastro);
//  SetLocalizaGroupBox(pnlFechamento);
//  SetAtualizaTabelasLookup(tbsCadastro);
//  FTabelas := tbNenhum;
end;

procedure TfrmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Transaction.InTransaction then
    Transaction.Rollback;
end;

procedure TfrmCadastro.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if DataSource.State in [dsInsert, dsEdit] then
    CanClose := Menu.Mensagens.Pergunta('Cadastro ainda não finalizado, deseja cancelar a operação?');
end;

procedure TfrmCadastro.actInserirExecute(Sender: TObject);
begin
  inherited;
  if FormActive.actInserir.Enabled then
  begin
    if not (DataSource.State in [dsInsert, dsEdit]) then
      DataSet.Insert;
  end;
end;

procedure TfrmCadastro.actAlterarExecute(Sender: TObject);
begin
  inherited;
  DataSet.Refresh;
  if FormActive.actAlterar.Enabled then
  begin
    if not DataSet.IsEmpty then
    begin
      if not (DataSource.State in [dsInsert, dsEdit]) then
      begin
        if Menu.ConfigInterface.GetRowDeletado(DataSet, Menu.ConfigInterface.GetKeyCampo(DataSet).AsInteger) then
        begin
          try
            DataSet.DisableControls;
            DataSet.Edit;
            DataSet.Post;
            DataSet.EnableControls;
            DataSet.Edit;
            FormActive.pgcCadastro.ActivePage := FormActive.tbsCadastro;
          except
            on E: Exception do
            begin
              if (Pos('deadlock', E.Message) > 0) or (Pos('msvcrt.dll', E.Message) > 0) then
              begin
                DataSet.EnableControls;
                FormActive.actCancelarExecute(nil);
                Menu.Mensagens.Aviso('Alteração não permitida pois o registro está manipulado em outro terminal.');
              end
              else
                raise Exception.Create(E.Message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadastro.actExcluirExecute(Sender: TObject);
begin
  inherited;
  DataSet.Refresh;
  if FormActive.actExcluir.Enabled then
  begin
    if not DataSet.IsEmpty then
    begin
      if not (DataSource.State in [dsInsert, dsEdit]) then
      begin
        if Menu.ConfigInterface.GetRowDeletado(DataSet, Menu.ConfigInterface.GetKeyCampo(DataSet).AsInteger) then
        begin
          if Menu.Mensagens.Pergunta('Excluir o registro selecionado?') then
          begin
            DataSet.Delete;
            Transaction.CommitRetaining;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadastro.actGravarExecute(Sender: TObject);
begin
  inherited;
  if FormActive.actGravar.Enabled then
  begin
    if DataSource.State in [dsInsert, dsEdit] then
    begin
      ActiveControl := nil;
  //    if GetValidaCadastro(pnlCadastro, dttCadastro) then
  //    begin
        DataSet.Post;
        Transaction.CommitRetaining;
        DataSet.Refresh;
        Menu.ConfigInterface.GetKeySequencia(DataSet);
  //    end;
    end;
  end;
end;

procedure TfrmCadastro.actCancelarExecute(Sender: TObject);
begin
  inherited;
  Sair := False;
  if FormActive.actCancelar.Enabled then
  begin
    if DataSource.State in [dsInsert, dsEdit] then
    begin
      if Menu.Mensagens.Pergunta('Deseja cancelar esta operação?') then
      begin
        DataSet.Cancel;
        Transaction.RollbackRetaining;
      end;
    end
  end;
end;

procedure TfrmCadastro.actImprimirDesignerExecute(Sender: TObject);
begin
  inherited;
//  if FTabelas <> tbNenhum then
//    Menu.Fast.PrintRegistroTelaDesigne(FTabelas, Menu.ConfigInterface.GetKey(dttCadastro).AsString);
end;

procedure TfrmCadastro.actImprimirExecute(Sender: TObject);
begin
  inherited;
//  if not (TfrmFormCadastro(Menu.ActiveMDIChild).dttCadastro.State in [dsInsert, dsEdit]) then
//  begin
//    if pgcForm.ActivePage = tbsForm then
//      TfrmFormCadastro(Menu.ActiveMDIChild).grlImpressao.Preview()
//    else if pgcForm.ActivePage = tbsCadastro then
//      SetImprimeRegistro;
//  end;
end;

procedure TfrmCadastro.actImprimirRestaurarExecute(Sender: TObject);
begin
  inherited;
//  if FTabelas <> tbNenhum then
//  begin
//    if Menu.ConfigInterface.Mensagens.Pergunta('Ao restaurar a impressão padrão, você não poderá voltar para a impressão customizada.' + #13 + 'Tem certeza que deseja restaurar a impressão padrão?') then
//    begin
//      clsFast.PrintRegistroTelaReset(FTabelas);
//      Menu.ConfigInterface.Mensagens.Aviso('Impressão padrão restaurada.');
//    end;
//  end;
end;

procedure TfrmCadastro.actVisualizarExecute(Sender: TObject);
begin
  inherited;
  if not (DataSource.State in [dsInsert, dsEdit]) then
  begin
    if not dttCadastro.IsEmpty then
      FormActive.pgcCadastro.ActivePage := tbsCadastro;
  end;
end;

procedure TfrmCadastro.dtsCadastroStateChange(Sender: TObject);
begin
  inherited;
  FormActive.actInserir.Enabled  := not (DataSource.State in [dsInsert, dsEdit]);
  FormActive.actAlterar.Enabled  := not (DataSource.State in [dsInsert, dsEdit]);
  FormActive.actExcluir.Enabled  := not (DataSource.State in [dsInsert, dsEdit]);
  FormActive.actGravar.Enabled   := DataSource.State in [dsInsert, dsEdit];
  FormActive.actCancelar.Enabled := DataSource.State in [dsInsert, dsEdit];
  FormActive.btnInserir.Visible  := FormActive.actInserir.Enabled;
  FormActive.btnAlterar.Visible  := FormActive.actAlterar.Enabled;
  FormActive.btnExcluir.Visible  := FormActive.actExcluir.Enabled;
  FormActive.btnGravar.Visible   := FormActive.actGravar.Enabled;
  FormActive.btnCancelar.Visible := FormActive.actCancelar.Enabled;
  FormActive.btnInserir.Align    := alRight;
  FormActive.btnAlterar.Align    := alRight;
  FormActive.btnExcluir.Align    := alRight;
  FormActive.btnGravar.Align     := alRight;
  FormActive.btnCancelar.Align   := alRight;
  FormActive.btnInserir.Align    := alLeft;
  FormActive.btnAlterar.Align    := alLeft;
  FormActive.btnExcluir.Align    := alLeft;
  FormActive.btnGravar.Align     := alLeft;
  FormActive.btnCancelar.Align   := alLeft;
  if DataSource.State in [dsInsert] then
    FormActive.Caption := Titulo + ' [Inserir]'
  else if DataSource.State in [dsEdit] then
    FormActive.Caption := Titulo + ' [Alterar]'
  else
    FormActive.Caption := Titulo;
end;

procedure TfrmCadastro.dttCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  gtvPesquisa.ApplyBestFit();
end;

procedure TfrmCadastro.dttCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
//  Menu.ConfigInterface.SetArredondaValoresNumericos(DataSet);
  if dttCadastro.State = dsInsert then
  begin
    dttCadastro.FieldByName('US_CADAST').AsString   := Menu.Usuario.Login;
    dttCadastro.FieldByName('DT_CADAST').AsDateTime := Now;
  end
  else
  begin
    dttCadastro.FieldByName('US_MODIFI').AsString   := Menu.Usuario.Login;
    dttCadastro.FieldByName('DT_MODIFI').AsDateTime := Now;
  end;
end;

procedure TfrmCadastro.SetImprimeRegistro;
begin
//  if FTabelas <> tbNenhum then
//    Menu.Fast.PrintRegistroTela(FTabelas, Menu.ConfigInterface.GetKey(dttCadastro).AsString);
end;

procedure TfrmCadastro.actSairExecute(Sender: TObject);
begin
  SetSair;
  inherited;
end;

procedure TfrmCadastro.SetSair;
begin
  Sair := True;
  if DataSource.State in [dsInsert, dsEdit] then
  begin
    FormActive.actCancelarExecute(Self);
    Sair := False;
  end
  else
    inherited;
end;

//procedure TfrmFormCadastro.SetTabelas(const Value: TTabelas);
//begin
//  FTabelas := Value;
//end;

procedure TfrmCadastro.SetDataSet(const Value: TIBDataSet);
begin
  FDataSet := Value;
end;

procedure TfrmCadastro.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

procedure TfrmCadastro.SetTransaction(const Value: TIBTransaction);
begin
  FTransaction := Value;
end;

procedure TfrmCadastro.SetFormActive(const Value: TfrmCadastro);
begin
  FFormActive := Value;
end;

end.
