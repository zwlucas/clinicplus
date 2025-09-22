unit ClinicPlus.Form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.TabControl, FMX.ListBox, FMX.Layouts, FMX.MultiView, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON,
  FMX.Edit;

type
  TClinicPlusForm = class(TForm)
    TopRCT: TRectangle;
    MenuBTN: TButton;
    Label1: TLabel;
    AtualizarBTN: TButton;
    ButtonsRCT: TRectangle;
    ScheduleLYT: TLayout;
    SchedulePTH: TPath;
    HomeLYT: TLayout;
    HistoryLYT: TLayout;
    HistoryPTH: TPath;
    AnimeLYT: TLayout;
    AnimeRCT: TRectangle;
    MultiView1: TMultiView;
    MenuLST: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ContentTBC: TTabControl;
    ScheduleTBC: TTabItem;
    HomeTBC: TTabItem;
    HistoryTBC: TTabItem;
    ScheduleLTV: TListView;
    HistoryLTV: TListView;
    Layout1: TLayout;
    Circle1: TCircle;
    NameLBL: TLabel;
    CPFLBL: TLabel;
    ClienteMTB: TFDMemTable;
    HistoricoMTB: TFDMemTable;
    AgendamentoMTB: TFDMemTable;
    ClienteMTBNome: TStringField;
    ClienteMTBCpf: TStringField;
    ClienteMTBNascimento: TDateTimeField;
    ClienteMTBFoto: TBlobField;
    AgendamentoMTBidfuncionario: TIntegerField;
    AgendamentoMTBidlocal: TIntegerField;
    AgendamentoMTBidadmin: TIntegerField;
    AgendamentoMTBdata_agendamento: TDateField;
    AgendamentoMTBhora_agendamento: TTimeField;
    AgendamentoMTBdata_atendimento: TDateField;
    AgendamentoMTBhora_atendimento: TTimeField;
    AgendamentoMTBdata_confirmacao: TDateTimeField;
    AgendamentoMTBdata_cadastro: TDateTimeField;
    AgendamentoMTBfg_status: TStringField;
    AgendamentoMTBprofissional: TStringField;
    AgendamentoMTBpaciente: TStringField;
    AgendamentoMTBlocal: TStringField;
    AgendamentoMTBidcliente: TIntegerField;
    AgendamentoMTBidagendamento: TFDAutoIncField;
    ClienteMTBidcliente: TFDAutoIncField;
    HistoricoMTBidagendamento: TFDAutoIncField;
    HistoricoMTBidfuncionario: TIntegerField;
    HistoricoMTBidcliente: TIntegerField;
    HistoricoMTBidlocal: TIntegerField;
    HistoricoMTBidadmin: TIntegerField;
    HistoricoMTBdata_confirmacao: TDateTimeField;
    HistoricoMTBdata_agendamento: TDateField;
    HistoricoMTBhora_agendamento: TTimeField;
    HistoricoMTBdata_atendimento: TDateField;
    HistoricoMTBhora_atendimento: TTimeField;
    HistoricoMTBdata_cadastro: TDateTimeField;
    HistoricoMTBfg_status: TStringField;
    HistoricoMTBprofissional: TStringField;
    HistoricoMTBpaciente: TStringField;
    HistoricoMTBlocal: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    HomePTH: TPath;
    Label2: TLabel;
    Label3: TLabel;
    IDEDT: TEdit;
    Label4: TLabel;
    CPFEDT: TEdit;
    EntrarBTN: TButton;
    ListBoxItem5: TListBoxItem;
    LoginFotoCIR: TCircle;
    procedure ScheduleLYTClick(Sender: TObject);
    procedure HistoryLYTClick(Sender: TObject);
    procedure HomeLYTClick(Sender: TObject);
    procedure AtualizarBTNClick(Sender: TObject);
    procedure ScheduleLTVUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ScheduleLTVButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure EntrarBTNClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetAgendamentoAtivo(const AToken: String);
    procedure GetHistorico(const AToken: String);

    procedure GetCliente(const AToken: String);
    procedure LoadCliente(const AToken: String);

    procedure ChangeSchedule(const AID: Integer; JSON: TJSONObject);
    procedure Login(const ID, CPF: String);
  end;

const
  EnderecoServidor = 'http://localhost:9000/';

var
  ClinicPlusForm: TClinicPlusForm;
  Token: String;

implementation

uses FMX.Ani, RESTRequest4D, DataSet.Serialize, DataSet.Serialize.Adapter.RESTRequest4D, System.Threading;

{$R *.fmx}

procedure TClinicPlusForm.AtualizarBTNClick(Sender: TObject);
begin
  TTask.Run(procedure
  begin
    GetAgendamentoAtivo(Token);
    GetHistorico(Token);
    LoadCliente(Token);
  end);
end;

procedure TClinicPlusForm.ChangeSchedule(const AID: Integer; JSON: TJSONObject);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .ResourceSuffix(AID.ToString)
    .AddBody(JSON, False)
    .Accept('application/json')
    .Put;
end;

procedure TClinicPlusForm.EntrarBTNClick(Sender: TObject);
begin
  if (IDEDT.Text = '') or (CPFEDT.Text  = '') then
    raise Exception.Create('Informe o ID e o CPF');

  TTask.Run(procedure
  begin
    Login(IDEDT.Text, CPFEDT.Text);

    LoadCliente(Token);
    GetAgendamentoAtivo(Token);
    GetHistorico(Token);

    TThread.Synchronize(TThread.Current, procedure
    begin
      LoginFotoCIR.Fill.Bitmap.Assign(Circle1.Fill.Bitmap);
      MultiView1.HideMaster;
    end);
  end);
end;

procedure TClinicPlusForm.FormCreate(Sender: TObject);
begin
  AnimeRCT.Position.X := HomeLYT.Position.X;

  MultiView1.ShowMaster;
  IDEDT.SetFocus;
end;

procedure TClinicPlusForm.GetAgendamentoAtivo(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .AddHeader('Authorization', AToken, [poDoNotEncode])
    .AddParam('fg_status', 'a')
    .Accept('application/json')
    .Adapters(TDataSetSerializeAdapter.New(AgendamentoMTB))
    .Get;
end;

procedure TClinicPlusForm.GetHistorico(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .AddHeader('Authorization', AToken, [poDoNotEncode])
    .Accept('application/json')
    .Adapters(TDataSetSerializeAdapter.New(HistoricoMTB))
    .Get;
end;

procedure TClinicPlusForm.HistoryLYTClick(Sender: TObject);
begin
  TAnimator.AnimateFloat(AnimeRCT, 'position.x', HistoryLYT.Position.X, 0.5, TAnimationType.Out, TInterpolationType.Bounce);
  ContentTBC.SetActiveTabWithTransitionAsync(HistoryTBC, TTabTransition.Slide, TTabTransitionDirection.Normal, nil);
end;

procedure TClinicPlusForm.HomeLYTClick(Sender: TObject);
var
  TabDirection: TTabTransitionDirection;
begin
  if ContentTBC.ActiveTab.Index > HomeTBC.Index then
    TabDirection := TTabTransitionDirection.Reversed
  else
    TabDirection := TTabTransitionDirection.Normal;

  TAnimator.AnimateFloat(AnimeRCT, 'position.x', HomeLYT.Position.X, 0.5, TAnimationType.Out, TInterpolationType.Bounce);
  ContentTBC.SetActiveTabWithTransitionAsync(HomeTBC, TTabTransition.Slide, TabDirection, nil);
end;

procedure TClinicPlusForm.GetCliente(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'cliente')
    .AddHeader('Authorization', AToken, [poDoNotEncode])
    .Accept('application/json')
    .Adapters(TDataSetSerializeAdapter.New(ClienteMTB))
    .Get;
end;

procedure TClinicPlusForm.LoadCliente(const AToken: String);
var
  FotoStream: TMemoryStream;
  BrushBmp: TBrushBitmap;
begin
  GetCliente(AToken);

  TThread.Synchronize(TThread.CurrentThread, procedure
  begin
    NameLBL.Text := ClienteMTBNome.AsString;
    CPFLBL.Text := ClienteMTBCpf.AsString;

    FotoStream := TMemoryStream.Create;
    BrushBmp := TBrushBitmap.Create;

    try
      ClienteMTBFoto.SaveToStream(FotoStream);
      FotoStream.Position := 0;
      BrushBmp.Bitmap.LoadFromStream(FotoStream);
      
      BrushBmp.WrapMode := TWrapMode.TileStretch;
      Circle1.Fill.Bitmap.Assign(BrushBmp);
    finally
      FotoStream.Free;
      BrushBmp.Free;
    end;
  end);
end;

procedure TClinicPlusForm.Login(const ID, CPF: String);
var
  JSON: TJSONObject;
  Resposta: IResponse;
begin
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('idcliente', ID);
    JSON.AddPair('cpf', CPF);

    try
      Resposta := TRequest.New.BaseURL(EnderecoServidor + 'token')
                    .AddBody(JSON, False)
                    .Accept('application/json')
                    .Post;

      if Resposta.StatusCode = 200 then begin
        Token := 'Bearer ' + Resposta.Content;
      end else begin
        ShowMessage('Falha na autenticação: ' + Resposta.Content);
      end;
    except
      On E: Exception do begin
        ShowMessage('Falha no login: ' + E.Message);
      end;
    end;
  finally
    JSON.Free;
  end;
end;

procedure TClinicPlusForm.ScheduleLTVButtonClick(const Sender: TObject; const AItem: TListItem;
  const AObject: TListItemSimpleControl);
var
  JSON: TJSONObject;
begin
  if AObject.Name.ToLower = 'confirmabutton' then
  begin
    AgendamentoMTB.Edit;
    AgendamentoMTBfg_status.AsString := 'C';
    AgendamentoMTBdata_confirmacao.Value := Now;
    AgendamentoMTB.Post;
    JSON := AgendamentoMTB.ToJSONObject();
    ChangeSchedule(AgendamentoMTBidagendamento.Value, JSON);
    JSON.Free;
  end;

  if AObject.Name.ToLower = 'cancelabutton' then
  begin
    AgendamentoMTB.Edit;
    AgendamentoMTBfg_status.AsString := 'I';
    AgendamentoMTBdata_confirmacao.Value := Now;
    AgendamentoMTB.Post;
    JSON := AgendamentoMTB.ToJSONObject();
    ChangeSchedule(AgendamentoMTBidagendamento.Value, JSON);
    JSON.Free;

    TTask.Run(procedure
    begin
      Sleep(50);
      AgendamentoMTB.EmptyDataSet;
      HistoricoMTB.EmptyDataSet;
      GetAgendamentoAtivo(Token);
      GetHistorico(Token);
    end);
  end;
end;

procedure TClinicPlusForm.ScheduleLTVUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  AItem.Objects.DrawableByName('ConfirmaButton').Height := 37;
  AItem.Objects.DrawableByName('CancelaButton').Height := 37;
end;

procedure TClinicPlusForm.ScheduleLYTClick(Sender: TObject);
begin
  TAnimator.AnimateFloat(AnimeRCT, 'position.x', ScheduleLYT.Position.X, 0.5, TAnimationType.Out, TInterpolationType.Bounce);
  ContentTBC.SetActiveTabWithTransitionAsync(ScheduleTBC, TTabTransition.Slide, TTabTransitionDirection.Reversed, nil);
end;

end.
