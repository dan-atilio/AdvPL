//Bibliotecas
#Include "Protheus.ch"

/*------------------------------------------------------------------------------------------------------*
 | P.E.:  PswValid                                                                                      |
 | Autor: Daniel Atilio                                                                                 |
 | Data:  24/09/2016                                                                                    |
 | Desc:  Ponto de entrada executado após errar a senha no login do Protheus                            |
 | Links: http://tdn.totvs.com/pages/releaseview.action?pageId=6815184                                  |
 *------------------------------------------------------------------------------------------------------*/

User Function PswValid()
	//SetKey (VK_F4,{||u_zFecPSS()})
Return

/*/{Protheus.doc} zFecPSS
Função responsável por fechar o sigapss.spf, chamada pelo botão F4 instanciado no login do Protheus pelo P.E. PswValid
@type function
@author Atilio
@since 24/09/2016
@version 1.0
/*/

User Function zFecPSS()
	Local aArea := GetArea()
	
	//Fecha o arquivo de senhas
	SPF_CLOSE("SIGAPSS.SPF")
	Alert("zFecPSS executado!")
	
	RestArea(aArea)
Return