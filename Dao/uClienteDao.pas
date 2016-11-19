unit uClienteDao;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel;

type
  TClienteDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AClienteModel: TClienteModel): Boolean;
    function Alterar(AClienteModel: TClienteModel): Boolean;
    function Excluir(AClienteModel: TClienteModel): Boolean;
    function Obter: TFDQuery;
  end;

implementation

{ TClienteDao }

uses uSistemaControl;

function TClienteDao.Alterar(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update cliente set nome = :nome where (codigo = :codigo)', [AClienteModel.Nome, AClienteModel.Codigo]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

constructor TClienteDao.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TClienteDao.Excluir(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from cliente where (codigo = :codigo)', [AClienteModel.Codigo]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Incluir(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into cliente (nome) values (:nome)', [AClienteModel.Nome]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Obter: TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  VQry.Open('select codigo, nome from cliente');

  Result := VQry;
end;

end.
