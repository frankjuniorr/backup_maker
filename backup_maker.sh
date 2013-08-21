# Cabeçalho
# ----------------------------------------------------------------------------
# <descrição>
#
# Uso: <uso>
# Ex.: <exemplo>
#
# Autor: Frank <frank (a) gmail com>
# Desde: 20-8-2013
# Versão: 1
# ----------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------
CONFIG="backup_maker.config" 		# arquivo de configuração
CONFIG_PADRAO=						# Arquivo de configuração padrão, caso não exista
"
#
## backup_maker.conf - arquivo de configuração do backup_maker
#

### Opções Liga/Desliga
#
# Use ON/OFF para ligar e desligar as opções
VERBOSE     ON      # mostrar toda a saída do rsync
PROGRESSO   ON      # mostrar progresso da transferencia, por arquivo transferido
DELETE      ON      # deletar arquivos no destino, que não existem mais naorigem
CHECKSUM    ON      # copia verificando o checksum. OBS: Deixa a transferencia muito mais lenta
"
PARSER_FILE="parser.sh"				# arquivo de parser

# Configurações padrões
RSYNC_PARAMS="ax"					# parametros padrões e obrigatórios para o rsync
CONF_VERBOSE="0"					# config: Verbose
CONF_PROGRESSO="0"					# config: Progresso
CONF_DELETE="0"						# config: Delete
CONF_CHECKSUM="0"					# config: Checksum

# Variaveis auxiliares
CHAVES=""							# pega todas as chaves do arquivo de configuração
# ----------------------------------------------------------------------------


# funções
# ----------------------------------------------------------------------------
# funcão para pegar o valor da chave procurada
function retorna_valor(){
chaves=$1
chave=$2
valor=""

# filtrando a saída pela chave que foi passada por parametro
valor=$(echo -e "$chaves" | grep -i "$chave")

# validação, para chave duplicada
if [ $(echo -e "$valor" | wc -l) -gt 1 ]; then
       echo Erro: chave $PARAM duplicada, no arquivo de configuração
       exit 1
fi

# pegando a somente o valor da chave, e imprimindo na saída padrão
valor=$(echo "$valor" | cut -d "=" -f2 | sed 's/\"//g' | tr A-Z a-z)

echo "$valor"
}

# função para validar a chave, e setar o valor correto dela
function valida_chaves(){
chave="$1"

if [ "$chave" = 'on' ] || [ "$chave" = "1" ];then
		chave="$2"
else
		chave=""
fi

echo "$chave"
}
# ----------------------------------------------------------------------------


# Main
# ----------------------------------------------------------------------------
# verificando se o arquivo de configuração existe
if [ ! -e "$CONFIG" ];then
	echo ""$CONFIG" não existe"
	echo "deseja criar um arquivo padrão? s/n: "
	read resposta
		if [ "$resposta" = "s" ];then
			echo "criando arquivo $CONFIG"
			echo "$CONFIG_PADRAO" > "$CONFIG"
		else
			exit 1
		fi
	exit 1
fi
# Carregando a configuração do arquivo externo
CHAVES="$(bash "$PARSER_FILE" "$CONFIG")"

# consultando as chaves
CONF_VERBOSE=$(retorna_valor "$CHAVES" "verbose")
CONF_PROGRESSO=$(retorna_valor "$CHAVES" "progresso")
CONF_CHECKSUM=$(retorna_valor "$CHAVES" "checksum")
CONF_DELETE=$(retorna_valor "$CHAVES" "delete")

# validando as chaves
CONF_VERBOSE=$(valida_chaves "$CONF_VERBOSE" "vh")
CONF_PROGRESSO=$(valida_chaves "$CONF_PROGRESSO" "P")
CONF_CHECKSUM=$(valida_chaves "$CONF_DELETE" "c")
CONF_DELETE=$(valida_chaves "$CONF_DELETE" "--delete")

# agrupando todos os parametros do rsync
RSYNC_PARAMS="$RSYNC_PARAMS$CONF_VERBOSE$CONF_PROGRESSO$CONF_CHECKSUM $CONF_DELETE"
echo "rsync -"$RSYNC_PARAMS" <origem> <destino>"

# ----------------------------------------------------------------------------
