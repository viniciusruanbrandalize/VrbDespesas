unit model.entity.despesaformapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, model.entity.contabancaria,
  model.entity.pix, model.entity.formapagamento, model.entity.cartao;

type

  { TDespesaFormaPagamento }

  TDespesaFormaPagamento = class
  private
    FCartao: TCartao;
    FContaBancaria: TContaBancaria;
    //FDespesa: TDespesa;
    FFormaPagamento: TFormaPagamento;
    FId:   Integer;
    FPix: TPix;
    FValor: Double;
    function GetCartao: TCartao;
    function GetContaBancaria: TContaBancaria;
    //function GetDespesa: TDespesa;
    function GetFormaPagamento: TFormaPagamento;
    function GetId: Integer;
    function GetPix: TPix;
    function GetValor: Double;
    procedure SetCartao(AValue: TCartao);
    procedure SetContaBancaria(AValue: TContaBancaria);
    //procedure SetDespesa(AValue: TDespesa);
    procedure SetFormaPagamento(AValue: TFormaPagamento);
    procedure SetId(AValue: Integer);
    procedure SetPix(AValue: TPix);
    procedure SetValor(AValue: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Valor: Double read GetValor write SetValor;
    property ContaBancaria: TContaBancaria read GetContaBancaria write SetContaBancaria;
    property Pix: TPix read GetPix write SetPix;
    property Cartao: TCartao read GetCartao write SetCartao;
    property FormaPagamento: TFormaPagamento read GetFormaPagamento write SetFormaPagamento;
    //property Despesa: TDespesa read GetDespesa write SetDespesa;
  end;

type
  TDespesaFormaPagamentoLista = specialize TObjectList<TDespesaFormaPagamento>;

implementation

{ TDespesaFormaPagamento }

function TDespesaFormaPagamento.GetId: Integer;
begin
  Result := FId;
end;

function TDespesaFormaPagamento.GetCartao: TCartao;
begin
  Result := FCartao;
end;

function TDespesaFormaPagamento.GetContaBancaria: TContaBancaria;
begin
  Result := FContaBancaria;
end;

//function TDespesaFormaPagamento.GetDespesa: TDespesa;
//begin
//  Result := FDespesa;
//end;

function TDespesaFormaPagamento.GetFormaPagamento: TFormaPagamento;
begin
  Result := FFormaPagamento;
end;

function TDespesaFormaPagamento.GetPix: TPix;
begin
  Result := FPix;
end;

function TDespesaFormaPagamento.GetValor: Double;
begin
  Result := FValor;
end;

procedure TDespesaFormaPagamento.SetCartao(AValue: TCartao);
begin
  FCartao:=AValue;
end;

procedure TDespesaFormaPagamento.SetContaBancaria(AValue: TContaBancaria);
begin
  FContaBancaria:=AValue;
end;

//procedure TDespesaFormaPagamento.SetDespesa(AValue: TDespesa);
//begin
//  FDespesa:=AValue;
//end;

procedure TDespesaFormaPagamento.SetFormaPagamento(AValue: TFormaPagamento);
begin
  FFormaPagamento:=AValue;
end;

procedure TDespesaFormaPagamento.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TDespesaFormaPagamento.SetPix(AValue: TPix);
begin
  FPix:=AValue;
end;

procedure TDespesaFormaPagamento.SetValor(AValue: Double);
begin
  FValor:=AValue;
end;

constructor TDespesaFormaPagamento.Create;
begin
  //
end;

destructor TDespesaFormaPagamento.Destroy;
begin
  inherited Destroy;
end;

end.

