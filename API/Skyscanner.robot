*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     HttpLibrary.HTTP

Suite Setup       Create Session    skyscanner    https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com

*** Variables ***
${COUNTRY}=                   DE
${CURRENCY}=                  EUR
${LOCALE}=                    de-DE
${ORIGIN_PLACE}=              SJJ-kky
${DESTINATION_PLACE}=         ISTA-sky
${OUTBOUND_DATE}=             2021-09-01

*** Test Cases ***

Browse Quotes - verify status code 200
    ${headers}=     Create Dictionary    x-rapidapi-key=db53320519msh292a4b14f44ca06p17371djsn6139620139fb     x-rapidapi-host=skyscanner-skyscanner-flight-search-v1.p.rapidapi.com
    ${response}=         get request         skyscanner     /apiservices/browsequotes/v1.0/${COUNTRY}/${CURRENCY}/${LOCALE}/${ORIGIN_PLACE}/${DESTINATION_PLACE}/${OUTBOUND_DATE}  headers=${headers}
     should be equal as integers     ${response.status_code}        200

Browse Quotes - validate currency
    ${headers}=     Create Dictionary    x-rapidapi-key=db53320519msh292a4b14f44ca06p17371djsn6139620139fb     x-rapidapi-host=skyscanner-skyscanner-flight-search-v1.p.rapidapi.com
    ${response}=         get request         skyscanner     /apiservices/browsequotes/v1.0/${COUNTRY}/${CURRENCY}/${LOCALE}/${ORIGIN_PLACE}/${DESTINATION_PLACE}/${OUTBOUND_DATE}  headers=${headers}
    ${json}=        set variable  ${response.json()}
    ${currency}=       get value from json  ${json}  $..Currencies[0].Code
    should be equal as strings      ${currency[0]}         EUR


