unit model.entity.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.subtipodespesa, model.entity.usuario,
  model.entity.participante;

type

  { TDespesa }

  TDespesa = class
  private
    FDonoCadastro: IParticipante;
    FFornecedor: IParticipante;
    FId:   Integer;
    FDescricao: String;
    FObservacao: String;
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
    function GetChaveNFE: String;
    function GetData: TDate;
    function GetDesconto: Double;
    function GetDonoCadastro: IParticipante;
    function GetFornecedor: IParticipante;
    function GetFrete: Double;
    function GetHora: TTime;
    function GetId: Integer;
    function GetDescricao: String;
    function GetObservacao: String;
    function GetOutros: Double;
    function GetSubTipo: TSubtipoDespesa;
    function GetTotal: Double;
    function GetUsuarioCadastro: TUsuario;
    function GetValor: Double;
    procedure SetChaveNFE(AValue: String);
    procedure SetData(AValue: TDate);
    procedure SetDesconto(AValue: Double);
    procedure SetDonoCadastro(AValue: IParticipante);
    procedure SetFornecedor(AValue: IParticipante);
    procedure SetFrete(AValue: Double);
    procedure SetHora(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetDescricao(AValue: String);
    procedure SetObservacao(AValue: String);
    procedure SetOutros(AValue: Double);
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
    property Fornecedor: IParticipante read GetFornecedor write SetFornecedor;
    property DonoCadastro: IParticipante read GetDonoCadastro write SetDonoCadastro;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
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

function TDespesa.GetData: TDate;
begin
  Result := FData;
end;

function TDespesa.GetDesconto: Double;
begin
  Result := FDesconto;
end;

function TDespesa.GetDonoCadastro: IParticipante;
begin
  Result := FDonoCadastro;
end;

function TDespesa.GetFornecedor: IParticipante;
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

procedure TDespesa.SetDonoCadastro(AValue: IParticipante);
begin
  FDonoCadastro:=AValue;
end;

procedure TDespesa.SetFornecedor(AValue: IParticipante);
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
  //
end;

destructor TDespesa.Destroy;
begin
  inherited Destroy;
end;

end.

