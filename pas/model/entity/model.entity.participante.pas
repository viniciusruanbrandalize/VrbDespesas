unit model.entity.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.cidade, model.entity.usuario;

type
  IParticipante = interface
  ['{13C3526D-E306-4A53-80BC-839A6C80258F}']

    function GetAlteracao: TDateTime;
    function GetBairro: String;
    function GetCadastro: TDateTime;
    function GetCelular: String;
    function GetCEP: String;
    function GetCidade: TCidade;
    function GetCNPJ: String;
    function GetComplemento: String;
    function GetDonoCadastro: Boolean;
    function GetEmail: String;
    function GetFantasia: String;
    function GetId: Integer;
    function GetIE: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    function GetObs: String;
    function GetPessoa: String;
    function GetRua: String;
    function GetTelefone: String;
    function GetUsuarioCadastro: TUsuario;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetBairro(AValue: String);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetCelular(AValue: String);
    procedure SetCEP(AValue: String);
    procedure SetCidade(AValue: TCidade);
    procedure SetCNPJ(AValue: String);
    procedure SetComplemento(AValue: String);
    procedure SetDonoCadastro(AValue: Boolean);
    procedure SetEmail(AValue: String);
    procedure SetFantasia(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetIE(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
    procedure SetObs(AValue: String);
    procedure SetPessoa(AValue: String);
    procedure SetRua(AValue: String);
    procedure SetTelefone(AValue: String);
    procedure SetUsuarioCadastro(AValue: TUsuario);

  end;


implementation

end.
