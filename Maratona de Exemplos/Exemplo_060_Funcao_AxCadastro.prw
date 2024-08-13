/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/07/criando-uma-tela-simples-de-cadastro-com-axcadastro-maratona-advpl-e-tl-060/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe060
Exemplo de função que cria uma tela de cadastro (o indicado é usar MVC, mas esse exemplo é apenas para demonstrar)
@type Function
@author Atilio
@since 05/12/2022
@see https://tdn.totvs.com/display/public/framework/AxCadastro
@obs 
    Função AxCadastro
    Parâmetros
        + cAlias      , Caractere       , Alias da tabela
        + cTitle      , Caractere       , Título da janela
        + cDel        , Caractere       , Função executada ao confirmar uma exclusão
        + cOk         , Caractere       , Função executada ao clicar no confirmar
        + aRotAdic    , Array           , Rotinas adicionais para serem acrescentadas no menu
        + bPre        , Bloco de Código , Bloco de código executado antes de abrir a tela de manutenção do cadastro
        + bOK         , Bloco de Código , Bloco de código executado ao clicar no botão Confirmar na tela de manutenção do cadastro
        + bTTS        , Bloco de Código , Bloco de código executado durante a transação após clicar no Confirmar na tela de manutenção do cadastro
        + bNoTTS      , Bloco de Código , Bloco de código executado fora da transação após clicar no Confirmar na tela de manutenção do cadastro
        + aAuto       , Array           , Array com nome dos campos a serem considerados nas rotinas automáticas
        + nOpcAuto    , Numérico        , Número da opção selecionada em caso de rotinas automáticas
        + aButtons    , Array           , Array com os botões dentro da rotina de manutenção do cadastro
        + aACS        , Array           , Array com os controles de acessos das funções
        + cTela       , Caractere       , Nome da variável que será utilizada no lugar da aTela
        + lMenuDef    , Lógico          , Indica se usará um MenuDef com funções padronizadas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe060()
    Local aArea      := FWGetArea()
    Local cDelOk   := ".T."
    Local cFunTOk  := ".T." // Pode ser colocado como "u_zVldTst()"

    //Chamando a tela de cadastros
    AxCadastro('SBM', 'Grupo de Produtoss', cDelOk, cFunTOk)

    FWRestArea(aArea)
Return
