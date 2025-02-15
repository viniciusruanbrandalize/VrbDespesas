unit model.entity.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.subtipodespesa,
  model.entity.usuario, model.entity.participante,
  model.entity.despesaformapagamento;

type

  { TDespesa }

  TDespesa = class
  private
    FAlteracao: TDateTime;
    FCadastro: TDateTime;
    FDonoCadastro: TParticipante;
    FFornecedor: TParticipante;
    FId:   Integer;
    FDescricao: String;
    FObservacao: String;
    FPaga: Boolean;
    FParcela: Integer;
    FUsuarioCadastro: TUsuario;
    FValor: Double;
    FData: TDate;
    FHora: TTime;
    FChaveNFE: String;
    FDesconto: Double;
    FFrete: Double;
    FOutros: Double;
    FTotal: Double;
    FSubTipo: TSubtipoDespesa;
    FDespesaFormaPagamento: TDespesaFormaPagamentoLista;
    function GetAlteracao: TDateTime;
    function GetCadastro: TDateTime;
    function GetChaveNFE: String;
    function GetData: TDate;
    function GetDesconto: Double;
    function GetDespesaFormaPagamento: TDespesaFormaPagamentoLista;
    function GetDonoCadastro: TParticipante;
    function GetFornecedor: TParticipante;
    function GetFrete: Double;
    function GetHora: TTime;
    function GetId: Integer;
    function GetDescricao: String;
    function GetObservacao: String;
    function GetOutros: Double;
    function GetPaga: Boolean;
    function GetParcela: Integer;
    function GetSubTipo: TSubtipoDespesa;
    function GetTotal: Double;
    function GetUsuarioCadastro: TUsuario;
    function GetValor: Double;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetChaveNFE(AValue: String);
    procedure SetData(AValue: TDate);
    procedure SetDesconto(AValue: Double);
    procedure SetDespesaFormaPagamento(AValue: TDespesaFormaPagamentoLista);
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetFornecedor(AValue: TParticipante);
    procedure SetFrete(AValue: Double);
    procedure SetHora(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetDescricao(AValue: String);
    procedure SetObservacao(AValue: String);
    procedure SetOutros(AValue: Double);
    procedure SetPaga(AValue: Boolean);
    procedure SetParcela(AValue: Integer);
    procedure SetSubTipo(AValue: TSubtipoDespesa);
    procedure SetTotal(AValue: Double);
    procedure SetUsuarioCadastro(AValue: TUsuario);
    procedure SetValor(AValue: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Descricao: String read GetDescricao write SetDescricao;
    property Observacao: String read GetObservacao write SetObservacao;
    property Valor: Double read GetValor write SetValor;
    property Data: TDate read GetData write SetData;
    property Hora: TTime read GetHora write SetHora;
    property ChaveNFE: String read GetChaveNFE write SetChaveNFE;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Frete: Double read GetFrete write SetFrete;
    property Outros: Double read GetOutros write SetOutros;
    property Total: Double read GetTotal write SetTotal;
    property SubTipo: TSubtipoDespesa read GetSubTipo write SetSubTipo;
    property Fornecedor: TParticipante read GetFornecedor write SetFornecedor;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
    property Paga: Boolean read GetPaga write SetPaga;
    property Parcela: Integer read GetParcela write SetParcela;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property DespesaFormaPagamento: TDespesaFormaPagamentoLista read GetDespesaFormaPagamento write SetDespesaFormaPagamento;
  end;

implementation

{ TDespesa }

function TDespesa.GetId: Integer;
begin
  Result := FId;
end;

function TDespesa.GetChaveNFE: String;
begin
  Result := FChaveNFE;
end;

function TDespesa.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TDespesa.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TDespesa.GetData: TDate;
begin
  Result := FData;
end;

function TDespesa.GetDesconto: Double;
begin
  Result := FDesconto;
end;

function TDespesa.GetDespesaFormaPagamento: TDespesaFormaPagamentoLista;
begin
  Result := FDespesaFormaPagamento;
end;

function TDespesa.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TDespesa.GetFornecedor: TParticipante;
begin
  Result := FFornecedor;
end;

function TDespesa.GetFrete: Double;
begin
  Result := FFrete;
end;

function TDespesa.GetHora: TTime;
begin
  Result := FHora;
end;

function TDespesa.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TDespesa.GetObservacao: String;
begin
  Result := FObservacao;
end;

function TDespesa.GetOutros: Double;
begin
  Result := FOutros;
end;

function TDespesa.GetPaga: Boolean;
begin
  Result := FPaga;
end;

function TDespesa.GetParcela: Integer;
begin
  Result := FParcela;
end;

function TDespesa.GetSubTipo: TSubtipoDespesa;
begin
  Result := FSubTipo;
end;

function TDespesa.GetTotal: Double;
begin
  Result := FTotal;
end;

function TDespesa.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

function TDespesa.GetValor: Double;
begin
  Result := FValor;
end;

procedure TDespesa.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao:=AValue;
end;

procedure TDespesa.SetCadastro(AValue: TDateTime);
begin
  FCadastro:=AValue;
end;

procedure TDespesa.SetChaveNFE(AValue: String);
begin
  FChaveNFE := AValue;
end;

procedure TDespesa.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TDespesa.SetDesconto(AValue: Double);
begin
  FDesconto := AValue;
end;

procedure TDespesa.SetDespesaFormaPagamento(AValue: TDespesaFormaPagamentoLista
  );
begin
  FDespesaFormaPagamento := AValue;
end;

procedure TDespesa.SetDonoCadastro(AValue: TParticipante);
begin
  FDonoCadastro:=AValue;
end;

procedure TDespesa.SetFornecedor(AValue: TParticipante);
begin
  FFornecedor:=AValue;
end;

procedure TDespesa.SetFrete(AValue: Double);
begin
  FFrete := AValue;
end;

procedure TDespesa.SetHora(AValue: TTime);
begin
  FHora := AValue;
end;

procedure TDespesa.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TDespesa.SetDescricao(AValue: String);
begin
  FDescricao := AValue;
end;

procedure TDespesa.SetObservacao(AValue: String);
begin
  FObservacao := AValue;
end;

procedure TDespesa.SetOutros(AValue: Double);
begin
  FOutros := AValue;
end;

procedure TDespesa.SetPaga(AValue: Boolean);
begin
  FPaga:=AValue;
end;

procedure TDespesa.SetParcela(AValue: Integer);
begin
  FParcela:=AValue;
end;

procedure TDespesa.SetSubTipo(AValue: TSubtipoDespesa);
begin
  FSubTipo := AValue;
end;

procedure TDespesa.SetTotal(AValue: Double);
begin
  FTotal := AValue;
end;

procedure TDespesa.SetUsuarioCadastro(AValue: TUsuario);
begin
  FUsuarioCadastro:=AValue;
end;

procedure TDespesa.SetValor(AValue: Double);
begin
  FValor := AValue;
end;

constructor TDespesa.Create;
begin
  FFornecedor      := TParticipante.Create;
  FDonoCadastro    := TParticipante.Create;
  FSubTipo         := TSubtipoDespesa.Create;
  FUsuarioCadastro := TUsuario.Create;
  FDespesaFormaPagamento := TDespesaFormaPagamentoLista.Create;
end;

destructor TDespesa.Destroy;
begin
  FFornecedor.Free;
  FDonoCadastro.Free;
  FSubTipo.Free;
  FUsuarioCadastro.Free;
  FDespesaFormaPagamento.Free;
  inherited Destroy;
end;

end.

