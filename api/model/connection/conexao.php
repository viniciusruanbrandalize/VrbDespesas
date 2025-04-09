<?php

namespace model\connection;

use InvalidArgumentException;
use PDO;
use PDOException;
use lib\ConstantesGenericas;

class Conexao {
    
    private object $db;
    private string $servidor;
    private int $porta;
    private string $banco;
    private string $usuario;
    private string $senha;
    private string $driver;
    private string $charset;

    public function __construct() {
        $this->servidor = '127.0.0.1';
        $this->porta    = 3306;
        $this->banco    = 'vrb_despesa';
        $this->usuario  = 'root';
        $this->senha    = '1234';
        $this->driver   = 'MYSQL';
        $this->charset  = 'utf8mb4';
        $this->db = $this->setDB();
    }

    /**
     * @return PDO
     */
    public function setDB() {
        try {
            if ($this->driver === "MYSQL"){
                return new PDO(
                    'mysql:host=' . $this->servidor . '; dbname=' . $this->banco . '; port=' . $this->porta . '; charset='. $this->charset . ';', $this->usuario, $this->senha
                );
            } else {
                return new PDO(
                    'mysql:host=' . $this->servidor . '; dbname=' . $this->banco . '; port=' . $this->porta . '; charset='. $this->charset . ';', $this->usuario, $this->senha
                );
            }
        } catch (PDOException $exception) {
            throw new PDOException($exception->getMessage());
        }
    }

    /**
     * @param $tabela
     * @param $id
     * @return string
     */
    public function delete($tabela, $id) {
        $consultaDelete = 'DELETE FROM ' . $tabela . ' WHERE id = :id';
        if ($tabela && $id) {
            $this->db->beginTransaction();
            $stmt = $this->db->prepare($consultaDelete);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            if ($stmt->rowCount() > 0) {
                $this->db->commit();
                return ConstantesGenericas::MSG_DELETADO_SUCESSO;
            }
            $this->db->rollBack();
            throw new InvalidArgumentException(ConstantesGenericas::MSG_ERRO_SEM_RETORNO);
        }
        throw new InvalidArgumentException(ConstantesGenericas::MSG_ERRO_GENERICO);
    }

    /**
     * @param $tabela
     * @return array
     */
    public function getAll($tabela) {
        if ($tabela) {
            $consulta = 'SELECT * FROM ' . $tabela;
            $stmt = $this->db->query($consulta);
            $registros = $stmt->fetchAll($this->db::FETCH_ASSOC);
            if (is_array($registros) && count($registros) > 0) {
                return $registros;
            }
        }
        throw new InvalidArgumentException(ConstantesGenericas::MSG_ERRO_SEM_RETORNO);
    }

    /**
     * @param $tabela
     * @param $id
     * @return mixed
     */
    public function getOneByKey($tabela, $id) {
        if ($tabela && $id) {
            $consulta = 'SELECT * FROM ' . $tabela . ' WHERE id = :id';
            $stmt = $this->db->prepare($consulta);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            $totalRegistros = $stmt->rowCount();
            if ($totalRegistros === 1) {
                return $stmt->fetch($this->db::FETCH_ASSOC);
            }
            throw new InvalidArgumentException(ConstantesGenericas::MSG_ERRO_SEM_RETORNO);
        }

        throw new InvalidArgumentException(ConstantesGenericas::MSG_ERRO_ID_OBRIGATORIO);
    }

    /**
     * @return object|PDO
     */
    public function getDb() {
        return $this->db;
    }
}