*** Settings ***
Library    AppiumLibrary
Library    RequestsLibrary

*** Variables ***
${deviceName}    R5CR8050X6P    #테스트대상 단말입력
${appPackage}    com.skb.smartrc 
${appActivity}    com.skb.smartrc.MainContainerActivity


*** Keywords ***
앱 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true

앱 종료 후 재진입
    Wait Until Keyword Succeeds    1 min    3 sec    Terminate Application    ${appPackage}
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Sleep    5