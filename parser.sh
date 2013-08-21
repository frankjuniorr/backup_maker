# ----------------------------------------------------------------------------
# <oescrição>
#
# Uso: <uso>
# Ex.: <exemplo>
#
# Autor: Frank <frank (a) gmail com>
# Desde: 20-8-2013
# Versão: 1
# ----------------------------------------------------------------------------

# O arquivo de configuração é indicado na linha de comando
CONFIG=$1

chave=""
valor=""
retorno=""

# O arquivo deve existir e ser legível
echo "[DEBUG] $CONFIG"
if [ -z "$CONFIG" ]; then
		echo uso: parser arquivo.conf
		exit 1
elif [ ! -r "$CONFIG" ]; then
		echo Erro: Não consigo ler o arquivo $CONFIG
		exit 1
fi

# Loop para ler a linha de configuração, guardando em $LINHA
while read LINHA; do

		# Ignorando as linhas de comentário
		[ "$(echo $LINHA | cut -c1)" = '#' ] && continue

		# Ignorando linhas em branco
		[ "$LINHA" ] || continue

		# Guardando cada palavra da linha em $1, $2, $3...
		set - $LINHA

		# Extraindo os dados (chaves sempre maiusculas)
		chave=$(echo $1 | tr a-z A-Z)
		shift
		valor=$*

		# capturando cada linha do arquivo (chave e valor) e atribuindo a variavel $retorno
		# o sed esta retirando os comentários de 1 linha
		echo -e "$retorno$chave=\"$valor\"" | sed 's/\ #.*/"/g'

done < "$CONFIG"
