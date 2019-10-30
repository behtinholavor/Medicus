unit ufrmForm;

interface

uses
  Windows, Classes, ActnList, Controls, ExtCtrls, Forms, RzPanel, ufrmMenu,
  RzDBEdit, RzEdit, Messages, Dialogs, SysUtils, DateUtils, StrUtils, IBCustomDataSet, DB;

type
  TfrmForm = class(TForm)
    pnlForm: TRzPanel;
    aclFuncoes: TActionList;
    actSair: TAction;
    procedure FormCreate(Sender: TObject); virtual;
    procedure FormActivate(Sender: TObject); virtual;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure FormDestroy(Sender: TObject); virtual;
    procedure actSairExecute(Sender: TObject); virtual;
  private
    { Private declarations }
    FTitulo: string;
    FMenu: TfrmMenu;
    FForm: TForm;
    FParams: TStringList;
    FSair: Boolean;
    procedure SetTitulo(const Value: string);
    procedure SetMenu(const Value: TfrmMenu);
    procedure SetForm(const Value: TForm);
    procedure SetParams(const Value: TStringList);
  public
    { Public declarations }
    property Titulo: string read FTitulo write SetTitulo;
    property Params: TStringList read FParams write SetParams;
    property Form: TForm read FForm write SetForm;
    property Menu: TfrmMenu read FMenu write SetMenu;
    property Sair: Boolean read FSair write FSair;
    constructor Create(AOwner: TComponent; ATitulo: string; AMenu: TfrmMenu; AForm: TForm = nil; AParams: string = '');
    procedure SetSair; virtual;
  end;

var
  frmForm: TfrmForm;

implementation

{$R *.dfm}

{ TfrmForm }

constructor TfrmForm.Create(AOwner: TComponent; ATitulo: string;
  AMenu: TfrmMenu; AForm: TForm; AParams: string);
begin
  inherited Create(AOwner);
  Titulo                  := ATitulo;
  FMenu                   := AMenu;
  FForm                   := Self;
//  FForm                   := AForm
  FParams                 := TStringList.Create;
  FParams.Delimiter       := '^';
  FParams.StrictDelimiter := True;
  FParams.DelimitedText   := AParams;
end;

procedure TfrmForm.SetTitulo(const Value: string);
begin
  FTitulo           := Value;
  self.Caption      := Value;
  self.ClientHeight := 200;
  self.ClientWidth  := 350;
end;

procedure TfrmForm.SetForm(const Value: TForm);
begin
  FForm := Value;
end;

procedure TfrmForm.SetMenu(const Value: TfrmMenu);
begin
  FMenu := Value;
end;

procedure TfrmForm.SetParams(const Value: TStringList);
begin
  FParams := Value;
end;

procedure TfrmForm.FormActivate(Sender: TObject);
begin
  if self.FormStyle = fsMDIChild then
  begin
    WindowState := wsMaximized;
    if Menu.MDIChildCount > 0 then
    begin
      Menu.FormPaint(Sender);
//      Menu.rbnMenu.Contexts[0].Caption := Caption;
    end;
  end;
end;

procedure TfrmForm.FormCreate(Sender: TObject);
begin
  Menu.ConfigInterface.GetInterface(Self);
end;

procedure TfrmForm.FormDestroy(Sender: TObject);
begin
  Menu.ConfigInterface.GetInterface(Self);
end;

procedure TfrmForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
    begin
      if ActiveControl.Tag = 0 then
      begin
        if not(ActiveControl is TRzDBMemo) and not(ActiveControl is TRzMemo) then
        begin
          if Shift = [ssShift] then
            PostMessage(Handle, WM_NEXTDLGCTL, 1, 0)
          else
            PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    end;
  end;
end;

procedure TfrmForm.actSairExecute(Sender: TObject);
begin
  if Sair then
  begin
    Close;
    Destroy;
  end;
end;

procedure TfrmForm.SetSair;
begin
  FSair := True;
end;

end.
