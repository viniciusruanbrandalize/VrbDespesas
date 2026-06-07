## Como contribuir

<script>
	function copiarDados(event, elemento, tipo) {
		event.preventDefault();

		let conteudoParaCopiar = "";

		if (tipo === 'href') {
			conteudoParaCopiar = elemento.href;
		} else if (tipo === 'texto') {
			conteudoParaCopiar = elemento.innerText;
		}

		navigator.clipboard.writeText(conteudoParaCopiar).then(() => {
			alert("Copiado com sucesso: " + conteudoParaCopiar);
		}).catch(err => {
			console.error("Erro ao copiar: ", err);
		});
	}
</script>

Agradecemos seu interesse em contribuir para este projeto! Sua doação é importante!

Se você gosta de nossos projetos, considere fazer uma pequena doação.

Chave Pix: <a href="#" onclick="copiarDados(event, this, 'texto')"> 2ce9b7e4-5ec6-473a-96af-46304c4f05a3 </a>

Pix Copia e cola: <a href="00020126580014BR.GOV.BCB.PIX01362ce9b7e4-5ec6-473a-96af-46304c4f05a35204000053039865802BR5901N6001C62070503***63049F70"> Copiar </a>

QRCode PIX:

<center><a href="00020126580014BR.GOV.BCB.PIX01362ce9b7e4-5ec6-473a-96af-46304c4f05a35204000053039865802BR5901N6001C62070503***63049F70" onclick="copiarDados(event, this, 'href')"><img src="img/doacao/qrcode-pix.png" alt="Leia o QRCode para fazer sua doação" style="margin: 0 auto" width="150" height="150" ></a></center>
