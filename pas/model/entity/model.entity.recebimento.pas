unit model.entity.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.formapagamento, model.entity.contabancaria,
  model.entity.pix, model.entity.participante, model.entity.usuario;

type

  { TRecebimento }

  TRecebimento = class
  private
    FContaBancaria: TContaBancaria;
    FDonoCadastro: IParticipante;
    FFormaPagamento: TFormaPagamento;
    FId:   Integer;
    FData: TDate;
    FHoraExtra: Double;
    FINSS: Double;
    FIR: Double;
    FPagador: IParticipante;
    FPix: TPix;
    FUsuarioCadastro: TUsuario;
    FValorTotal: Double;
    FValorBase: Double;
    FDecimoTerceiro: Boolean;
    FFerias: Boolean;
    FValorDecimoTerceiro: Double;
    FValorFerias: Double;
    FAntecipacao: Double;
    FCadastro: TDateTime;
    FAlteracao: TDateTime;
    function GetAlteracao: TDateTime;
    function GetAntecipacao: Double;
    function GetCadastro: TDateTime;
    function GetContaBancaria: TContaBancaria;
    function GetData: TDate;
    function GetDecimoTerceiro: Boolean;
    function GetDonoCadastro: IParticipante;
    function GetFerias: Boolean;
    function GetFormaPagamento: TFormaPagamento;
    function GetHoraExtra: Double;
    function GetId: Integer;
    function GetINSS: Double;
    function GetIR: Double;
    function GetPagador: IParticipante;
    function GetPix: TPix;
    function GetUsuarioCadastro: TUsuario;
    function GetValorBase: Double;
    function GetValorDecimoTerceiro: Double;
    function GetValorFerias: Double;
    function GetValorTotal: Double;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetAntecipacao(AValue: Double);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetContaBancaria(AValue: TContaBancaria);
    procedure SetData(AValue: TDate);
    procedure SetDecimoTerceiro(AValue: Boolean);
    procedure SetDonoCadastro(AValue: IParticipante);
    procedure SetFerias(AValue: Boolean);
    procedure SetFormaPagamento(AValue: TFormaPagamento);
    procedure SetHoraExtra(AValue: Double);
    procedure SetId(AValue: Integer);
    procedure SetINSS(AValue: Double);
    procedure SetIR(AValue: Double);
    procedure SetPagador(AValue: IParticipante);
    procedure SetPix(AValue: TPix);
    procedure SetUsuarioCadastro(AValue: TUsuario);
    procedure SetValorBase(AValue: Double);
    procedure SetValorDecimoTerceiro(AValue: Double);
    procedure SetValorFerias(AValue: Double);
    procedure SetValorTotal(AValue: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Data: TDate read GetData write SetData;
    property HoraExtra: Double read GetHoraExtra write SetHoraExtra;
    property INSS: Double read GetINSS write SetINSS;
    property IR: Double read GetIR write SetIR;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorBase: Double read GetValorBase write SetValorBase;
    property DecimoTerceiro: Boolean read GetDecimoTerceiro write SetDecimoTerceiro;
    property Ferias: Boolean read GetFerias write SetFerias;
    property ValorDecimoTerceiro: Double read GetValorDecimoTerceiro write SetValorDecimoTerceiro;
    property ValorFerias: Double read GetValorFerias write SetValorFerias;
    property Antecipacao: Double read GetAntecipacao write SetAntecipacao;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property FormaPagamento: TFormaPagamento read GetFormaPagamento write SetFormaPagamento;
    property ContaBancaria: TContaBancaria read GetContaBancaria write SetContaBancaria;
    property Pix: TPix read GetPix write SetPix;
    property Pagador: IParticipante read GetPagador write SetPagador;
    property DonoCadastro: IParticipante read GetDonoCadastro write SetDonoCadastro;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
  end;

implementation

{ TRecebimento }

function TRecebimento.GetId: Integer;
begin
  Result := FId;
end;

function TRecebimento.GetAntecipacao: Double;
begin
  Result := FAntecipacao;
end;

function TRecebimento.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TRecebimento.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TRecebimento.GetContaBancaria: TContaBancaria;
begin
  Result := FContaBancaria;
end;

function TRecebimento.GetData: TDate;
begin
  Result := FData;
end;

function TRecebimento.GetDecimoTerceiro: Boolean;
begin
  Result := FDecimoTerceiro;
end;

function TRecebimento.GetDonoCadastro: IParticipante;
begin
  Result := FDonoCadastro;
end;

function TRecebimento.GetFerias: Boolean;
begin
  Result := FFerias;
end;

function TRecebimento.GetFormaPagamento: TFormaPagamento;
begin
  Result := FFormaPagamento;
end;

function TRecebimento.GetHoraExtra: Double;
begin
  Result := FHoraExtra;
end;

function TRecebimento.GetINSS: Double;
begin
  Result := FINSS;
end;

function TRecebimento.GetIR: Double;
begin
  Result := FIR;
end;

function TRecebimento.GetPagador: IParticipante;
begin
  Result := FPagador;
end;

function TRecebimento.GetPix: TPix;
begin
  Result := FPix;
end;

function TRecebimento.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

function TRecebimento.GetValorBase: Double;
begin
  Result := FValorBase;
end;

function TRecebimento.GetValorDecimoTerceiro: Double;
begin
  Result := FValorDecimoTerceiro;
end;

function TRecebimento.GetValorFerias: Double;
begin
  Result := FValorFerias;
end;

function TRecebimento.GetValorTotal: Double;
begin
  Result := FValorTotal;
end;

procedure TRecebimento.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao := AValue;
end;

procedure TRecebimento.SetAntecipacao(AValue: Double);
begin
  FAntecipacao := AValue;
end;

procedure TRecebimento.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TRecebimento.SetContaBancaria(AValue: TContaBancaria);
begin
  FContaBancaria:=AValue;
end;

procedure TRecebimento.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TRecebimento.SetDecimoTerceiro(AValue: Boolean);
begin
  FDecimoTerceiro := AValue;
end;

procedure TRecebimento.SetDonoCadastro(AValue: IParticipante);
begin
  FDonoCadastro:=AValue;
end;

procedure TRecebimento.SetFerias(AValue: Boolean);
begin
  FFerias := AValue;
end;

procedure TRecebimento.SetFormaPagamento(AValue: TFormaPagamento);
begin
  FFormaPagamento:=AValue;
end;

procedure TRecebimento.SetHoraExtra(AValue: Double);
begin
  FHoraExtra := AValue;
end;

procedure TRecebimento.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TRecebimento.SetINSS(AValue: Double);
begin
  FINSS := AValue;
end;

procedure TRecebimento.SetIR(AValue: Double);
begin
  FIR := AValue;
end;

procedure TRecebimento.SetPagador(AValue: IParticipante);
begin
  FPagador:=AValue;
end;

procedure TRecebimento.SetPix(AValue: TPix);
begin
  FPix:=AValue;
end;

procedure TRecebimento.SetUsuarioCadastro(AValue: TUsuario);
begin
  FUsuarioCadastro:=AValue;
end;

procedure TRecebimento.SetValorBase(AValue: Double);
begin
  FValorBase := AValue;
end;

procedure TRecebimento.SetValorDecimoTerceiro(AValue: Double);
begin
  FValorDecimoTerceiro := AValue;
end;

procedure TRecebimento.SetValorFerias(AValue: Double);
begin
  FValorFerias := AValue;
end;

procedure TRecebimento.SetValorTotal(AValue: Double);
begin
  FValorTotal := AValue;
end;

constructor TRecebimento.Create;
begin
  //
end;

destructor TRecebimento.Destroy;
begin
  inherited Destroy;
end;

end.

