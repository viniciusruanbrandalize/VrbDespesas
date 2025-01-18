unit model.entity.confbackup;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TConfBackup }

  TConfBackup = class
  private
    FId:        Integer;
    FOrigemFB:  String;
    FDestinoFB: String;
    FOrigemDB:  String;
    FDestinoDB: String;
    function GetDestinoDB: String;
    function GetDestinoFB: String;
    function GetId: Integer;
    function GetOrigemDB: String;
    function GetOrigemFB: String;
    procedure SetDestinoDB(AValue: String);
    procedure SetDestinoFB(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetOrigemDB(AValue: String);
    procedure SetOrigemFB(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property OrigemFB: String read GetOrigemFB write SetOrigemFB;
    property DestinoFB: String read GetDestinoFB write SetDestinoFB;
    property OrigemDB: String read GetOrigemDB write SetOrigemDB;
    property DestinoDB: String read GetDestinoDB write SetDestinoDB;
  end;

implementation

{ TConfBackup }

function TConfBackup.GetId: Integer;
begin
  Result := FId;
end;

function TConfBackup.GetDestinoDB: String;
begin
  Result := FDestinoDB;
end;

function TConfBackup.GetDestinoFB: String;
begin
  Result := FDestinoFB;
end;

function TConfBackup.GetOrigemDB: String;
begin
  Result := FOrigemDB;
end;

function TConfBackup.GetOrigemFB: String;
begin
  Result := FOrigemFB;
end;

procedure TConfBackup.SetDestinoDB(AValue: String);
begin
  FDestinoDB := AValue;
end;

procedure TConfBackup.SetDestinoFB(AValue: String);
begin
  FDestinoFB := AValue;
end;

procedure TConfBackup.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TConfBackup.SetOrigemDB(AValue: String);
begin
  FOrigemDB := AValue;
end;

procedure TConfBackup.SetOrigemFB(AValue: String);
begin
  FOrigemFB := AValue;
end;

constructor TConfBackup.Create;
begin
  //
end;

destructor TConfBackup.Destroy;
begin
  inherited Destroy;
end;

end.
