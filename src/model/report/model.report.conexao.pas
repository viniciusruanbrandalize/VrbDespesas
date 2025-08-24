{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

unit model.report.conexao;

{
  Componentes SQLConnector, SQLTransaction, SQLDBLibraryLoader são usados
  apenas para a criação/atualização de relatórios e testes internos de
  conexão com o banco de dados.
}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, IBConnection, LR_Class, LR_DBSet,
  LR_E_CSV, LR_E_TXT, LR_Desgn, LR_Shape, lr_e_pdf, model.connection.conexao1,
  LR_View, LR_PGrid, LR_ChBox, Graphics, TAGraph, Dialogs, ExtCtrls;

type

  { TdmConexaoReport }

  TdmConexaoReport = class(TDataModule)
    frCheckBoxObject: TfrCheckBoxObject;
    frCSVExport: TfrCSVExport;
    frDBDataSet: TfrDBDataSet;
    frDesigner: TfrDesigner;
    frReport: TfrReport;
    frShapeObject: TfrShapeObject;
    frTextExport: TfrTextExport;
    frTNPDFExport: TfrTNPDFExport;
    qryPadrao: TSQLQuery;
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLTransaction: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    FDir: String;
    FIDDonoCadastro: Integer;
    procedure ConfiguraComponentes();
  public
    procedure CarregarLogo();
    procedure GerarImagemGrafico(Grafico: TChart; SalvarImg: Boolean = False);
    property DiretorioRelatorios: String read FDir write FDir;
    property IDDonoCadastro: Integer read FIDDonoCadastro write FIDDonoCadastro;
  end;

var
  dmConexaoReport: TdmConexaoReport;

implementation

{$R *.lfm}

{ TdmConexaoReport }

procedure TdmConexaoReport.DataModuleCreate(Sender: TObject);
begin
  ConfiguraComponentes();
end;

procedure TdmConexaoReport.ConfiguraComponentes();
begin
  FDir := ExtractFilePath(ParamStr(0))+'reports\';
  FIDDonoCadastro := dmConexao1.DonoCadastro.Id;
  if qryPadrao.Active then
    qryPadrao.Active := False;
  qryPadrao.SQL.Clear;
  qryPadrao.DataBase   := dmConexao1.SQLConnector;
  frDBDataSet.DataSet  := qryPadrao;
  frReport.Dataset     := frDBDataSet;
end;

procedure TdmConexaoReport.GerarImagemGrafico(Grafico: TChart; SalvarImg: Boolean = False);
var
  jpg: TRasterImage;
  sDlg: TSaveDialog;
begin
  jpg := Grafico.SaveToImage(TJpegImage);
  try
    TJPegImage(jpg).CompressionQuality := 100;
    if SalvarImg then
    begin
      sDlg := TSaveDialog.Create(nil);
      try
        sDlg.Filter := 'JPG|*.jpg|Bitmap|*.bmp';
        sDlg.FileName := 'Sem Título';
        if sDlg.Execute then
        begin
          if UpperCase(ExtractFileExt(sDlg.FileName)) = '.JPG' then
            jpg.SaveToFile(sDlg.FileName)
          else
          if UpperCase(ExtractFileExt(sDlg.FileName)) = '.BMP' then
            Grafico.SaveToBitmapFile(sDlg.FileName)
          else
            jpg.SaveToFile(sDlg.FileName);
        end;
      finally
        sDlg.Free;
      end;
    end
    else
    begin
      if Assigned(frReport.FindObject('imgGrafico')) then
      begin
        TFrPictureView(frReport.FindObject('imgGrafico')).Picture.Assign(jpg);
        frReport.ShowReport;
      end;
    end;
  finally
    jpg.Free;
  end;
end;

procedure TdmConexaoReport.CarregarLogo();
begin
  if Assigned(frReport.FindObject('imgLogo')) then
    TfrPictureView(frReport.FindObject('imgLogo')).Picture.LoadFromFile(FDir+'logo.png');
end;

end.

