*** Settings ***
Library    AppiumLibrary
Library    RequestsLibrary

*** Variables ***
${deviceName}    RFCXA0R96MF    #테스트대상 단말입력
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

탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="ZEM버튼"]
    Sleep    1

인증번호(1111) 입력
    FOR    ${I}    IN RANGE    0    4
        Sleep    1
        Press Keycode    8
    END

임의의 콘텐츠 목록까지 스크롤
    FOR  ${i}  IN RANGE    0    10
        Swipe By Percent    50    80    60    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.skb.smartrc:id/recycler_view"]
        Exit For Loop If    ${pass}
    END

채널번호(168) 입력
    FOR    ${I}    IN RANGE    0    3
        Sleep    1
        Press Keycode    8
        Sleep    1
        Press Keycode    13
        Sleep    1
        Press Keycode    15
    END