<?php

use lib\ConstantesGenericas;

//require_once('bootstrap.php');

try {
//    $RequestValidator = new RequestValidator(RotasUtil::getRotas());
//    $retorno = $RequestValidator->processarRequest();

//    $JsonUtil = new JsonUtil();
//    $JsonUtil->processarArrayParaRetornar($retorno);

} catch (Exception $exception) {
    echo json_encode([
        ConstantesGenericas::TIPO => ConstantesGenericas::TIPO_ERRO,
        ConstantesGenericas::RESPOSTA => utf8_encode($exception->getMessage())
    ], JSON_THROW_ON_ERROR, 512);
    exit;
}
