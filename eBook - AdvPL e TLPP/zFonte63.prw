/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} User Function zFonte63
Aciona uma operação automática em MVC
@type Function
@author Atilio
@since 10/09/2024
@see https://tdn.totvs.com/display/public/framework/FWMVCRotAuto
/*/

User Function zFonte63()
	Local aArea         := GetArea()
    Local aDados        := {}
    Private aRotina     := FWLoadMenuDef("MATA020")
    Private oModel      := FWLoadModel("MATA020")
    Private lMsErroAuto := .F.
     
    //Adicionando os dados do ExecAuto
    aAdd(aDados, {"A2_COD",      "F00005",        Nil})
    aAdd(aDados, {"A2_LOJA",     "01",            Nil})
    aAdd(aDados, {"A2_NOME",     "Teste",         Nil})
    aAdd(aDados, {"A2_NREDUZ",   "Tst",           Nil})
    aAdd(aDados, {"A2_TIPO",     "F",             Nil})
    aAdd(aDados, {"A2_END",      "Rua de teste",  Nil})
    aAdd(aDados, {"A2_EST",      "SP",            Nil})
    aAdd(aDados, {"A2_COD_MUN",  "06003",         Nil})
    aAdd(aDados, {"A2_HPAGE",    "tst.com",       Nil})
    aAdd(aDados, {"A2_EMAIL",    "teste@tst.com", Nil})
    aAdd(aDados, {"A2_NATUREZ",  "NATREC0001",    Nil})
     
    //Chamando a inclusão - Modelo 1
    lMsErroAuto := .F.
    FWMVCRotAuto( ;
        oModel,;                        //Modelo
        "SA2",;                         //Alias
        MODEL_OPERATION_INSERT,;        //Operacao
        {{"SA2MASTER", aDados}};        //Dados
    )

    //Se tiver mais de um Form, deve se passar dessa forma:
    // {{"ZZ2MASTER", aAutoCab}, {"ZZ3DETAIL", aAutoItens}})
     
    //Se houve erro no ExecAuto, mostra mensagem
    If lMsErroAuto
        MostraErro()
     
    //Senão, mostra uma mensagem de inclusão    
    Else
        FWAlertSuccess("Registro incluido!", "Atenção")
    EndIf
     
    RestArea(aArea)
Return
