unit model.entity.compra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.subtipocompra, model.entity.loja, 
  model.entity.usuario,model.entity.formapagamento, model.entity.banco, 
  model.entity.devedor;

type

  { TCompra }

  TCompra = class
  private
    FId:   Integer;
    FDescricao: String;
    FObservacao: String;
    FValor: Double;
    FData: TDate;
    FHora: TTime;
    FChaveNFE: String;
    FDesconto: Double;
    FFrete: Double;
    FOutros: Double;
    FTotal: Double;
    FDevedor: TDevedor;
    FFormaPagamento: TFormaPagamento;
    FBanco: TBanco;
    FUsuario: TUsuario;
    FLoja: TLoja;
    FSubTipo: TSubtipoCompra;
    function GetBanco: TBanco;
    function GetChaveNFE: String;
    function GetData: TDate;
    function GetDesconto: Double;
    function GetDevedor: TDevedor;
    function GetFormaPagamento: TFormaPagamento;
    function GetFrete: Double;
    function GetHora: TTime;
    function GetId: Integer;
    function GetDescricao: String;
    function GetLoja: TLoja;
    function GetObservacao: String;
    function GetOutros: Double;
    function GetSubTipo: TSubtipoCompra;
    function GetTotal: Double;
    function GetUsuario: TUsuario;
    function GetValor: Double;
    procedure SetBanco(AValue: TBanco);
    procedure SetChaveNFE(AValue: String);
    procedure SetData(AValue: TDate);
    procedure SetDesconto(AValue: Double);
    procedure SetDevedor(AValue: TDevedor);
    procedure SetFormaPagamento(AValue: TFormaPagamento);
    procedure SetFrete(AValue: Double);
    procedure SetHora(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetDescricao(AValue: String);
    procedure SetLoja(AValue: TLoja);
    procedure SetObservacao(AValue: String);
    procedure SetOutros(AValue: Double);
    procedure SetSubTipo(AValue: TSubtipoCompra);
    procedure SetTotal(AValue: Double);
    procedure SetUsuario(AValue: TUsuario);
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
    property Devedor: TDevedor read GetDevedor write SetDevedor;
    property FormaPagamento: TFormaPagamento read GetFormaPagamento write SetFormaPagamento;
    property Banco: TBanco read GetBanco write SetBanco;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
    property Loja: TLoja read GetLoja write SetLoja;
    property SubTipo: TSubtipoCompra read GetSubTipo write SetSubTipo;
  end;

implementation

{ TCompra }

function TCompra.GetId: Integer;
begin
  Result := FId;
end;

function TCompra.GetBanco: TBanco;
begin
  Result := FBanco;
end;

function TCompra.GetChaveNFE: String;
begin
  Result := FChaveNFE;
end;

function TCompra.GetData: TDate;
begin
  Result := FData;
end;

function TCompra.GetDesconto: Double;
begin
  Result := FDesconto;
end;

function TCompra.GetDevedor: TDevedor;
begin
  Result := FDevedor;
end;

function TCompra.GetFormaPagamento: TFormaPagamento;
begin
  Result := FFormaPagamento;
end;

function TCompra.GetFrete: Double;
begin
  Result := FFrete;
end;

function TCompra.GetHora: TTime;
begin
  Result := FHora;
end;

function TCompra.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TCompra.GetLoja: TLoja;
begin
  Result := FLoja;
end;

function TCompra.GetObservacao: String;
begin
  Result := FObservacao;
end;

function TCompra.GetOutros: Double;
begin
  Result := FOutros;
end;

function TCompra.GetSubTipo: TSubtipoCompra;
begin
  Result := FSubTipo;
end;

function TCompra.GetTotal: Double;
begin
  Result := FTotal;
end;

function TCompra.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

function TCompra.GetValor: Double;
begin
  Result := FValor;
end;

procedure TCompra.SetBanco(AValue: TBanco);
begin
  FBanco := AValue;
end;

procedure TCompra.SetChaveNFE(AValue: String);
begin
  FChaveNFE := AValue;
end;

procedure TCompra.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TCompra.SetDesconto(AValue: Double);
begin
  FDesconto := AValue;
end;

procedure TCompra.SetDevedor(AValue: TDevedor);
begin
  FDevedor := AValue;
end;

procedure TCompra.SetFormaPagamento(AValue: TFormaPagamento);
begin
  FFormaPagamento := AValue;
end;

procedure TCompra.SetFrete(AValue: Double);
begin
  FFrete := AValue;
end;

procedure TCompra.SetHora(AValue: TTime);
begin
  FHora := AValue;
end;

procedure TCompra.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TCompra.SetDescricao(AValue: String);
begin
  FDescricao := AValue;
end;

procedure TCompra.SetLoja(AValue: TLoja);
begin
  FLoja := AValue;
end;

procedure TCompra.SetObservacao(AValue: String);
begin
  FObservacao := AValue;
end;

procedure TCompra.SetOutros(AValue: Double);
begin
  FOutros := AValue;
end;

procedure TCompra.SetSubTipo(AValue: TSubtipoCompra);
begin
  FSubTipo := AValue;
end;

procedure TCompra.SetTotal(AValue: Double);
begin
  FTotal := AValue;
end;

procedure TCompra.SetUsuario(AValue: TUsuario);
begin
  FUsuario := AValue;
end;

procedure TCompra.SetValor(AValue: Double);
begin
  FValor := AValue;
end;

constructor TCompra.Create;
begin
  //
end;

destructor TCompra.Destroy;
begin
  inherited Destroy;
end;

end.

