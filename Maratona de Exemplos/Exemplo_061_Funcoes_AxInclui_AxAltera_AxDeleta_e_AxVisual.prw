/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/08/manipulando-registros-com-axinclui-axaltera-axdeleta-e-axvisual-maratona-advpl-e-tl-061/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe061
Exemplo de função de tela de cadastro (o indicado é usar MVC, mas esse exemplo é apenas para demonstrar)
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814985 , https://tdn.totvs.com/pages/releaseview.action?pageId=23889132 , https://tdn.totvs.com/pages/releaseview.action?pageId=23889138 e https://tdn.totvs.com/pages/releaseview.action?pageId=23889145
@type function
@obs 
    Função AxInclui
    Parâmetros
        + cAlias      , Caractere       , Alias da tabela
        + nReg        , Numérico        , Número do registro posicionado (RecNo) sendo o padrão 0 pois é uma inclusão
        + nOpc        , Numérico        , Número da opção sendo o padrão 3 de Inclusão
        + aAcho       , Array           , Array com nome dos campos que serão exibidos
        + cFunc       , Caractere       , Função que será executada antes de abrir a tela
        + aCpos       , Array           , Array com nome dos campos que poderão ser editados
        + cTudoOk     , Caractere       , Função que será executada ao clicar no botão confirmar
        + lF3         , Lógico          , Indica se a tela foi criada a partir de uma consulta padrão
        + cTransact   , Caractere       , Função que será executada dentro da transação
        + aButtons    , Array           , Botões que serão adicionados no Outras Ações dentro da tela de edição
        + aParam      , Array           , Funções que serão executadas sendo: [1] = Antes de Exibir a tela; [2] = Ao clicar no Confirmar (TudoOk); [3] = Após o confirmar dentro da transação; [4] = Após o confirmar fora da transação
        + aAuto       , Array           , Indica os campos em uma execucação automática
        + lVirtual    , Lógico          , Se .T. irá usar variáveis de memória (com RegToMemory: M->); senão irá usar os próprios campos
        + lMaximized  , Lógico          , Se .T. a janela virá maximizada, senão ela virá com o tamanho um pouco menor
        + cTela       , Caractere       , Nome da variável que será utilizada no lugar da aTela
        + lPanelFin   , Lógico          , Se for .T. cria o painel do gestor financeiro
        + oFather     , Objeto          , Quando usado o lPanelFin cria um dialog dentro do objeto indicado
        + aDim        , Array           , Quando usado o lPanelFin indica as dimensões da dialog que será criada
        + uArea       , Indefinido      , Quando usado o lPanelFin esse parâmetro será usado dentro das funções do gestor financeiro
    Retorno
        + nOpca       , Numérico        , Retorna 1 se o usuário clicou em Confirmar ou 2 se foi em Cancelar ou 3 se houve alguma falha ao acionar a tela

    Função AxAltera
    Parâmetros
        + cAlias      , Caractere       , Alias da tabela
        + nReg        , Numérico        , Número do registro posicionado (RecNo)
        + nOpc        , Numérico        , Número da opção sendo o padrão 4 de Alteração
        + aAcho       , Array           , Array com nome dos campos que serão exibidos
        + aCpos       , Array           , Array com nome dos campos que poderão ser editados
        + nColMens    , Numérico        , Parâmetro não usado (apenas compatibilidade)
        + cMensagem   , Caractere       , Parâmetro não usado (apenas compatibilidade)
        + cTudoOk     , Caractere       , Função que será executada ao clicar no botão confirmar
        + cTransact   , Caractere       , Função que será executada dentro da transação
        + aButtons    , Array           , Botões que serão adicionados no Outras Ações dentro da tela de edição
        + aParam      , Array           , Funções que serão executadas sendo: [1] = Antes de Exibir a tela; [2] = Ao clicar no Confirmar (TudoOk); [3] = Após o confirmar dentro da transação; [4] = Após o confirmar fora da transação
        + aAuto       , Array           , Indica os campos em uma execucação automática
        + lVirtual    , Lógico          , Se .T. irá usar variáveis de memória (com RegToMemory: M->); senão irá usar os próprios campos
        + lMaximized  , Lógico          , Se .T. a janela virá maximizada, senão ela virá com o tamanho um pouco menor
    Retorno
        + nOpca       , Numérico        , Retorna 1 se o usuário clicou em Confirmar ou 2 se foi em Cancelar ou 3 se houve alguma falha ao acionar a tela

    Função AxDeleta
    Parâmetros
        + cAlias      , Caractere       , Alias da tabela
        + nReg        , Numérico        , Número do registro posicionado (RecNo)
        + nOpc        , Numérico        , Número da opção sendo o padrão 5 de Exclusão
        + cTransact   , Caractere       , Função que será executada dentro da transação
        + aCpos       , Array           , Array com nome dos campos que serão exibidos
        + aButtons    , Array           , Botões que serão adicionados no Outras Ações dentro da tela de edição
        + aParam      , Array           , Funções que serão executadas sendo: [1] = Antes de Exibir a tela; [2] = Ao clicar no Confirmar (TudoOk); [3] = Após o confirmar dentro da transação; [4] = Após o confirmar fora da transação
        + aAuto       , Array           , Indica os campos em uma execucação automática
        + lMaximized  , Lógico          , Se .T. a janela virá maximizada, senão ela virá com o tamanho um pouco menor
    Retorno
        + nOpca       , Numérico        , Retorna 1 se o usuário clicou em Confirmar ou 2 se foi em Cancelar ou 3 se houve alguma falha ao acionar a tela

    Função AxVisual
    Parâmetros
        + cAlias      , Caractere       , Alias da tabela
        + nReg        , Numérico        , Número do registro posicionado (RecNo)
        + nOpc        , Numérico        , Número da opção sendo o padrão 2 de Visualização
        + aAcho       , Array           , Array com nome dos campos que serão exibidos
        + nColMens    , Numérico        , Parâmetro não usado (apenas compatibilidade)
        + cMensagem   , Caractere       , Parâmetro não usado (apenas compatibilidade)
        + cFunc       , Caractere       , Função que irá carregar os campos
        + aButtons    , Array           , Botões que serão adicionados no Outras Ações dentro da tela de edição
        + lMaximized  , Lógico          , Se .T. a janela virá maximizada, senão ela virá com o tamanho um pouco menor
    Retorno
        + nOpca       , Numérico        , Retorna 1 se o usuário clicou em Confirmar ou 2 se foi em Cancelar ou 3 se houve alguma falha ao acionar a tela
/*/

User Function zExe061()
	Local aArea   := FWGetArea()
	Local oBrowse
	Private aRotina := {}
	Private cCadastro := "Grupo de Produtos"

    DbSelectArea('SBM')
    SBM->(DbSetOrder(1)) //BM_FILIAL + BM_GRUPO

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("SBM")
	oBrowse:SetDescription(cCadastro)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zExe061
@author Atilio
@since 06/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	aAdd(aRotina, {"Pesquisar", "AXPESQUI", 0, 1})
	aAdd(aRotina, {"Visualizar", "AXVISUAL", 0, 2})
	aAdd(aRotina, {"Incluir", "AXINCLUI", 0, 3})
	aAdd(aRotina, {"Alterar", "AXALTERA", 0, 4})
	aAdd(aRotina, {"Excluir", "AXDELETA", 0, 5})
	aAdd(aRotina, {"Visualizar (manual)", "U_Z061VIS", 0, 2})
	aAdd(aRotina, {"Incluir (manual)", "U_Z061INC", 0, 3})
	aAdd(aRotina, {"Alterar (manual)", "U_Z061ALT", 0, 4})
	aAdd(aRotina, {"Excluir (manual)", "U_Z061EXC", 0, 5})

Return aRotina


/*/{Protheus.doc} Z061VIS
Visualizar (manual)
@author Atilio
@since 06/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function Z061VIS()
	Local aArea       := FWGetArea()
    Local aAreaBM     := SBM->(FWGetArea())
    Local nOpcao      := 0
    Private cCadastro := "Teste de Visualização"
    
    //Chama a função
    nOpcao := AxVisual('SBM', SBM->(RecNo()), 2)
    If nOpcao == 1
        FWAlertInfo("Grupo visualizado: " + SBM->BM_GRUPO, "Exemplo AxVisual")
    EndIf
    
    FWRestArea(aAreaBM)
	FWRestArea(aArea)
Return


/*/{Protheus.doc} Z061INC
Incluir (manual)
@author Atilio
@since 06/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function Z061INC()
    Local aArea       := FWGetArea()
    Local aAreaBM     := SBM->(FWGetArea())
    Local nOpcao      := 0
    Private cCadastro := "Teste de Inclusão"
    
    //Chama a função
    nOpcao := AxInclui('SBM', 0, 3)
    If nOpcao == 1
        FWAlertInfo("Grupo incluido: " + SBM->BM_GRUPO, "Exemplo AxInclui")
    EndIf
    
    FWRestArea(aAreaBM)
	FWRestArea(aArea)
Return


/*/{Protheus.doc} Z061ALT
Alterar (manual)
@author Atilio
@since 06/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function Z061ALT()
	Local aArea       := FWGetArea()
    Local aAreaBM     := SBM->(FWGetArea())
    Local nOpcao      := 0
    Private cCadastro := "Teste de Alteração"
    
    //Chama a função
    nOpcao := AxAltera('SBM', SBM->(RecNo()), 4)
    If nOpcao == 1
        FWAlertInfo("Grupo alterado: " + SBM->BM_GRUPO, "Exemplo AxAltera")
    EndIf
    
    FWRestArea(aAreaBM)
	FWRestArea(aArea)
Return


/*/{Protheus.doc} Z061EXC
Excluir (manual)
@author Atilio
@since 06/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function Z061EXC()
	Local aArea       := FWGetArea()
    Local aAreaBM     := SBM->(FWGetArea())
    Local nOpcao      := 0
    Private cCadastro := "Teste de Exclusão"
    
    //Chama a função
    nOpcao := AxDeleta('SBM', SBM->(RecNo()), 5)
    If nOpcao == 1
        FWAlertInfo("Grupo alterado: " + SBM->BM_GRUPO, "Exemplo AxDeleta")
    EndIf
    
    FWRestArea(aAreaBM)
	FWRestArea(aArea)
Return
