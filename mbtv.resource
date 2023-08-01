*** Settings ***
Library   AppiumLibrary

*** Variables ***
${deviceName}    R5CR8050X6P
${존윅4 재생 로그}    notifyNavigationLog() click.vod.play

*** Keywords ***
모바일 btv 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=com.skb.smartrc    appActivity=com.skb.smartrc.MainContainerActivity    automationName=UIAutomator2    noReset=true


비밀번호 입력 (1111)
     FOR    ${I}    IN RANGE    0    4
        Sleep    1
        Press Keycode    8
    END
    Sleep    1
    Click Element    com.skb.smartrc:id/dialog_right_button

앱 재실행
    Terminate Application    com.skb.smartrc
    Sleep    3
    Activate Application    com.skb.smartrc
    Sleep    5

하단으로 스와이프
    Click Element    id=com.skb.smartrc:id/ivMyNoti
    Sleep    1
    Click Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup[2]/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.LinearLayout
    Sleep    1
    FOR  ${i}  IN RANGE    0    10
        Swipe By Percent    50    80    50    20
        ${pass} =    Run Keyword And Return Status    Wait Until Page Contains Element    com.skb.smartrc:id/settings_item_auth_adult_auth_container    timeout=10
        Exit For Loop If    ${pass}
        Sleep    1
    END

시청 연령 제한 체크
    하단으로 스와이프
    Sleep    1
    ${Check}    Get Element Attribute    com.skb.smartrc:id/settings_auth_adult_auth_chk    Checked       
    IF    '${Check}' == 'false'   
        log     pass
    ELSE IF    '${Check}' == 'true'
        ${Check2}    Get Element Attribute    com.skb.smartrc:id/settings_item_auth_adult_age19    Checked
        IF    '${Check2}' == 'true'
            Click Element    com.skb.smartrc:id/settings_item_auth_adult_age7
            Sleep    1
            비밀번호 입력 (1111)
            Sleep    1
            Click Element    com.skb.smartrc:id/btn_right
            Sleep    2
            Click Element    com.skb.smartrc:id/settings_auth_adult_auth_chk
            Sleep    1
            비밀번호 입력 (1111)
            Sleep    1
            Click Element    com.skb.smartrc:id/btn_right
        ELSE IF    '${Check2}' == 'false'
            Click Element    com.skb.smartrc:id/settings_auth_adult_auth_chk
            Sleep    1
            비밀번호 입력 (1111)
            Sleep    1
            Click Element    com.skb.smartrc:id/btn_right
        END
    END

검색어 검색
    [Arguments]    ${bar}    ${name}
        Input Text    ${bar}    ${name}