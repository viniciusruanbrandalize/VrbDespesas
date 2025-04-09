<?php

namespace Model\Entity;

use DateTime;

class Usuario {
    private int $id;
    private string $nome;
    private string $senha;
    private string $email;
    private DateTime $cadastro;
    private DateTime $alteracao;
    private bool $excluido;

    public function __construct() {
        
    }    

}

?>